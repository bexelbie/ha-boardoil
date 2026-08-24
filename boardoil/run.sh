#!/bin/sh
set -eu

allow_insecure_cookies="$(
    awk 'match($0, /"allow_insecure_cookies"[[:space:]]*:[[:space:]]*(true|false)/) {
        value = substr($0, RSTART, RLENGTH)
        sub(/^.*:/, "", value)
        gsub(/[[:space:]]/, "", value)
        print value
    }' /data/options.json
)"

case "$allow_insecure_cookies" in
    true|false) ;;
    *)
        echo "allow_insecure_cookies must be true or false" >&2
        exit 1
        ;;
esac

export BoardOilAuth__AllowInsecureCookies="$allow_insecure_cookies"
exec dotnet BoardOil.Api.dll
