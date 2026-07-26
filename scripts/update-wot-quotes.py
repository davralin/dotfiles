#!/usr/bin/env python3

import html
import re
import sys
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


def fetch_current_quote():
    request = urllib.request.Request(
        URL,
        headers={"User-Agent": "Mozilla/5.0 (X11; Linux x86_64)"},
    )
    with urllib.request.urlopen(request, timeout=30) as response:
        page = response.read().decode("utf-8", errors="replace")

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
