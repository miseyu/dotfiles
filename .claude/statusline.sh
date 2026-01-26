#!/bin/bash

echo "💰 \$$(npx ccusage@latest monthly --json --offline --order desc 2>/dev/null | jq -r '.monthly[0].totalCost * 100 | round / 100') monthly"
