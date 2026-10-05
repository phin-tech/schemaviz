#!/bin/sh
# Build the sample pages that are published to GitHub Pages.   sh examples/build-site.sh <out-dir>
# The inputs sit next to this script, so the pages can be rebuilt at any time.
set -eu
here=$(cd "$(dirname "$0")" && pwd)
out=${1:?usage: build-site.sh <out-dir>}
sv="python3 $here/../schemaviz.py"
mkdir -p "$out"
$sv diff "$here/recipe-v1.dbml" "$here/recipe-v2.dbml" --rename users=accounts --rename accounts.created_at=joined_at \
  --old-label "example v1" --new-label "example v2" --title "Recipe app migration" --out "$out/recipe-diff.html"
$sv render "$here/jaffle_shop.dbml" --title "Jaffle Shop (dbt)" --out "$out/jaffle-shop.html"
$sv render "$here/gitlab.dbml" --title "GitLab" --out "$out/gitlab.html"
$sv render "$here/kratos.dbml" --title "Ory Kratos" --out "$out/kratos.html"
$sv render "$here/pagila.dbml" --title "Pagila" --out "$out/pagila.html"
$sv render "$here/northwind.dbml" --title "Northwind" --out "$out/northwind.html"
cp "$here/index.html" "$out/index.html"
touch "$out/.nojekyll"
