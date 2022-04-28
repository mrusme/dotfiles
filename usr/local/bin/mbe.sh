#!/bin/sh
# ╔════════════════════════════════════════════════════════════════════════════╗
# ║                                                                            ║
# ║   ███╗   ███╗ ███╗ █╗█╗  ██████╗  ████╗ █╗  █╗███╗███╗███████╗█████╗ ███╗  ║
# ║   ████╗ ████║█╔══█╗█║█║  ██╔══██╗█╔═══█╗╚█╗█╔╝█╔═╝█╔═╝██╔════╝╚═█╔═╝█╔══╝  ║
# ║   ██╔████╔██║█████║█║█║  ██████╔╝█║   █║ ╚█╔╝ ██╗ ███╗█████╗    █║  █║     ║
# ║   ██║╚██╔╝██║█╔══█║█║█║  ██╔══██╗█║   █║ █╔█╗ █╔╝ ╚═█║██╔══╝    █║  █║     ║
# ║   ██║ ╚═╝ ██║█║  █║█║███╗██████╔╝╚████╔╝█╔╝ █╗███╗███║███████╗  █║   ███╗  ║
# ║   ╚═╝     ╚═╝╚╝  ╚╝╚╝╚══╝╚═════╝  ╚═══╝ ╚╝  ╚╝╚══╝╚══╝╚══════╝  ╚╝   ╚══╝  ║
# ║                                                                            ║
# ║      xn--gckvb8fzb.com * github.com/mrusme * marius@xn--gckvb8fzb.com      ║
# ║                                                                            ║
# ╚════════════════════════════════════════════════════════════════════════════╝
source ~/.secrets

curl -s 'https://mbe-latam.com/eboxweb/?lang=en' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Origin: https://mbe-latam.com' \
  -H 'DNT: 1' \
  -H 'Connection: keep-alive' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'Sec-Fetch-Dest: document' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-User: ?1' \
  --compressed \
  --data-raw "country=$MBE_COUNTRY&login_email=$MBE_EMAIL&login_password=$MBE_PASSWORD&login_btn=Login" \
  -c /tmp/cookies.txt \
  -b /tmp/cookies.txt

curl -s 'https://mbe-latam.com/eboxweb/package_listing.php?lang=en' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Origin: https://mbe-latam.com' \
  -H 'DNT: 1' \
  -H 'Connection: keep-alive' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'Sec-Fetch-Dest: document' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-User: ?1' \
  --compressed \
  -c /tmp/cookies.txt \
  -b /tmp/cookies.txt > /tmp/mbe.html

cat /tmp/mbe.html \
  | pup '.package_head json{}' \
  | jq '.[] | { "package": .children[1].children[0].children[0].text, "tracking": .children[1].children[1].text, "status": .children[3].text }'

rm /tmp/mbe.html /tmp/cookies.txt

