#!/bin/bash
/usr/bin/curl -s https://wotquotes.com/ | /bin/grep quotescollection-2 | /usr/bin/cut -d'>' -f4 | /usr/bin/cut -d'<' -f1 | /bin/sed -r -e 's/&#8230;/.../g' -e "s/&#8217;/'/g" -e 's/,\.\.\./\.\.\./g' -e 's/\. \. \. \./\.\.\.\./g' -e 's:<br />: :g' -
#/usr/bin/curl -s https://www.matcauthon.com/ | /bin/grep quotescollection-5 | /bin/sed -r -e 's/&#8230;/.../g' -e "s/&#8217;/'/g" -e 's/,\.\.\./\.\.\./g' -e 's/\. \. \. \./\.\.\.\./g' -e 's:<br />: :g' - | /usr/bin/cut -d'>' -f4 | /usr/bin/cut -d'<' -f1
