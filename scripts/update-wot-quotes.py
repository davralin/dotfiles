#!/usr/bin/env python3

import html
import json
import re
import sys
import urllib.parse
import urllib.request
from pathlib import Path


URL = "https://wotquotes.com/"
ROOT = Path(__file__).resolve().parents[1]
QUOTES_PATH = ROOT / "i3blocks" / "scripts" / "wot-quotes.tsv"


def clean_fragment(fragment):
    fragment = re.sub(r"(?i)<br\s*/?>", " ", fragment)
    fragment = re.sub(r"<[^>]+>", "", fragment)
    text = html.unescape(fragment)
    return re.sub(r"\s+", " ", text).strip()


def extract_by_class(page, class_pattern, tag="cite"):
    match = re.search(
        rf"<(?P<tag>{tag})\b[^>]*class=[\"'][^\"']*{class_pattern}[^\"']*[\"'][^>]*>(.*?)</(?P=tag)>",
        page,
        re.IGNORECASE | re.DOTALL,
    )
    if not match:
        raise ValueError(f"Could not find {class_pattern!r}")
    return clean_fragment(match.group(2))


def page_diagnostics(page):
    title_match = re.search(r"<title>(.*?)</title>", page, re.IGNORECASE | re.DOTALL)
    title = clean_fragment(title_match.group(1)) if title_match else "missing"
    return (
        f"bytes={len(page)}, title={title!r}, "
        f"has_currQuoteID={bool(re.search(r'currQuoteID\"\\s*:', page))}, "
        f"has_quotescollectionAjax={'quotescollectionAjax' in page}, "
        f"has_quote_wrapper={'quotescollection-quote-wrapper' in page}"
    )


def parse_homepage_quote(page):
    id_match = re.search(r'currQuoteID"\s*:\s*(\d+)', page)
    if not id_match:
        raise ValueError("Could not find quote ID")
    quote_id = int(id_match.group(1))

    wrapper_match = re.search(
        r"<[^>]+class=[\"'][^\"']*quotescollection-quote-wrapper[^\"']*[\"'][^>]*>(.*?)</div>",
        page,
        re.IGNORECASE | re.DOTALL,
    )
    if not wrapper_match:
        raise ValueError("Could not find quote wrapper")

    quote_match = re.search(r"<p\b[^>]*>(.*?)</p>", wrapper_match.group(1), re.IGNORECASE | re.DOTALL)
    if not quote_match:
        raise ValueError("Could not find quote text")

    quote = clean_fragment(quote_match.group(1))
    author = extract_by_class(page, r"\bauthor\b")
    source = extract_by_class(page, r"\btitle\b[^\"']*\bsource\b")

    return quote_id, quote, author, source


def extract_ajax_config(page):
    config_match = re.search(
        r"var\s+quotescollectionAjax\s*=\s*(\{.*?\});",
        page,
        re.IGNORECASE | re.DOTALL,
    )
    if not config_match:
        raise ValueError("Could not find quotescollectionAjax config")

    config = json.loads(config_match.group(1))
    nonce = config.get("nonce")
    ajax_url = config.get("ajaxUrl")
    if not nonce:
        raise ValueError("Could not find quotescollectionAjax nonce")
    if not ajax_url:
        raise ValueError("Could not find quotescollectionAjax URL")
    return ajax_url, nonce


def fetch_ajax_quote(page):
    ajax_url, nonce = extract_ajax_config(page)
    current_match = re.search(r'currQuoteID"\s*:\s*(\d+)', page)
    current = current_match.group(1) if current_match else "0"
    payload = urllib.parse.urlencode(
        {
            "action": "quotescollection",
            "_ajax_nonce": nonce,
            "current": current,
            "char_limit": "500",
            "tags": "",
            "orderby": "random",
        }
    ).encode()
    request = urllib.request.Request(
        ajax_url,
        data=payload,
        headers={
            "User-Agent": "Mozilla/5.0 (X11; Linux x86_64)",
            "Content-Type": "application/x-www-form-urlencoded",
        },
    )
    with urllib.request.urlopen(request, timeout=30) as response:
        body = response.read().decode("utf-8", errors="replace")

    if body == "-1" or not body:
        raise ValueError(f"Unexpected AJAX response: {body!r}")

    quote_data = json.loads(body)
    return (
        int(quote_data["quote_id"]),
        clean_fragment(quote_data.get("quote", "")),
        clean_fragment(quote_data.get("author", "")),
        clean_fragment(quote_data.get("source", "")),
    )


def fetch_current_quote():
    request = urllib.request.Request(
        URL,
        headers={"User-Agent": "Mozilla/5.0 (X11; Linux x86_64)"},
    )
    with urllib.request.urlopen(request, timeout=30) as response:
        page = response.read().decode("utf-8", errors="replace")

    try:
        return parse_homepage_quote(page)
    except Exception as homepage_error:
        try:
            return fetch_ajax_quote(page)
        except Exception as ajax_error:
            raise ValueError(
                f"{homepage_error}; AJAX fallback failed: {ajax_error}; "
                f"page diagnostics: {page_diagnostics(page)}"
            ) from ajax_error


def load_quotes():
    quotes = []
    if not QUOTES_PATH.exists():
        return quotes

    for line_number, line in enumerate(QUOTES_PATH.read_text(encoding="utf-8").splitlines(), start=1):
        if not line:
            continue
        fields = line.split("\t", 3)
        if len(fields) != 4:
            raise ValueError(f"Invalid TSV row at {QUOTES_PATH}:{line_number}")
        quote_id, quote, author, source = fields
        quotes.append((int(quote_id), quote, author, source))
    return quotes


def write_quotes(quotes):
    lines = []
    for quote_id, quote, author, source in sorted(quotes, key=lambda item: item[0]):
        fields = [str(quote_id), quote, author, source]
        lines.append("\t".join(field.replace("\t", " ").replace("\r", " ").replace("\n", " ") for field in fields))
    QUOTES_PATH.write_text("\n".join(lines) + "\n", encoding="utf-8")


def main():
    current = fetch_current_quote()
    quotes = load_quotes()
    existing_ids = {quote_id for quote_id, _, _, _ in quotes}

    if current[0] in existing_ids:
        print(f"Quote ID {current[0]} already exists; no changes made")
        return 0

    quotes.append(current)
    write_quotes(quotes)
    print(f"Added WoT quote ID {current[0]} to {QUOTES_PATH}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:
        print(f"error: {exc}", file=sys.stderr)
        raise SystemExit(1)
