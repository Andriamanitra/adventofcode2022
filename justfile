set dotenv-load

make-day NUM:
    #!/bin/sh
    set -eu
    ZNUM=$(printf "%02d" {{NUM}})
    mkdir day$ZNUM
    sed "s/00/$ZNUM/g" 'lib/template.rb' > "day$ZNUM/solution.rb"
    curl "https://adventofcode.com/$YEAR/day/{{NUM}}/input" \
        --no-progress-meter \
        -H 'Accept: text/plain' \
        -H "Cookie: $AOC_COOKIE" \
        --output "day$ZNUM/input.txt"

solve NUM:
    -just make-day {{NUM}}
    micro $(printf "day%02d/solution.rb" {{NUM}}):6:42
