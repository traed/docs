#! /usr/bin/env bash
set -e

# hints + typos
find . -name '*.md' -exec sed -i 's/{% hint style="info" %}/::: info/g' {} +
find . -name '*.md' -exec sed -i 's/{% hint style="info %}/::: info/g' {} +
find . -name '*.md' -exec sed -i 's/{% hint style=info %}/::: info/g' {} +
find . -name '*.md' -exec sed -i 's/{% hint type="info" %}/::: info/g' {} +
find . -name '*.md' -exec sed -i 's/{% hint style="information" %}/::: info/g' {} +

find . -name '*.md' -exec sed -i 's/{% hint style="successful" %}/::: tip/g' {} +
find . -name '*.md' -exec sed -i 's/{% hint style="warning" %}/::: warning/g' {} +
find . -name '*.md' -exec sed -i 's/{% hint style="danger" %}/::: danger/g' {} +

# replace manually
# find . -name '*.md' -exec sed -i 's/::: info /::: info\n/g' {} +

find . -name '*.md' -exec sed -i 's/{% endhint %}/:::/g' {} +

# rename
find . -name 'README.md' -exec bash -c 'mv "$1" "${1/README/index}"' -- {} \;

# restore index
mv index.md README.md

# md page-ref
find . -name '*.md' -exec sed -i 's/{% page-ref page="\(.*\).md" %}/<PageRef page="\1" \/>/g' {} +

# non-md page-ref
find . -name '*.md' -exec sed -i 's/{% page-ref page="\(.*\)" %}/<PageRef page="\1" \/>/g' {} +

# external embeds
find . -name '*.md' -exec sed -i 's/{% embed url="\(https:\/\/[^"]*\)\.md" caption="\([^"]*\)" %}/<PageRef page="\1" title="\2" target="_blank" \/>/g' {} +

# external embed - non-md
find . -name '*.md' -exec sed -i 's/{% embed url="\(https:\/\/[^"]*\)" caption="\([^"]*\)" %}/<PageRef page="\1" title="\2" target="_blank" \/>/g' {} +

# external embeds - empty caption
find . -name '*.md' -exec sed -i 's/{% embed url="\(https:\/\/[^"]*\)\.md" caption="" %}/<PageRef page="\1" title="" target="_blank" \/>/g' {} +

# tabs - T00D00 - is newline really needed?
find . -name '*.md' -exec sed -i 's/{% tabs %}/\n<Tabs>/g' {} +
find . -name '*.md' -exec sed -i 's/{% tab title="\(.*\)" %}/<Tab title="\1">/g' {} +

# end tabs
find . -name '*.md' -exec sed -i 's/{% endtab %}/<\/Tab>/g' {} +
find . -name '*.md' -exec sed -i 's/{% endtabs %}/<\/Tabs>/g' {} +

# xml - replace newlines, replace xml-only, make newlines
find . -name '*.md' -exec sed -i ':a;N;$!ba;s/\n/---%%%---/g' {} +
find . -name '*.md' -exec sed -i "s/\`\`\`markup---%%%---<?xml/\`\`\`xml---%%%---<?xml/g" {} +
find . -name '*.md' -exec sed -i "s/---%%%---/\n/g" {} +

# xml2 - with // comment
find . -name '*.md' -exec sed -i ':a;N;$!ba;s/\n/---%%%---/g' {} +
find . -name '*.md' -exec sed -i "s/\`\`\`markup---%%%---\/\//\`\`\`xml---%%%---\/\//g" {} +
find . -name '*.md' -exec sed -i "s/---%%%---/\n/g" {} +

# html - replace newlines, replace html-only, make newlines
find . -name '*.md' -exec sed -i ':a;N;$!ba;s/\n/---%%%---/g' {} +
find . -name '*.md' -exec sed -i "s/\`\`\`markup---%%%---/\`\`\`html---%%%---/g" {} +
find . -name '*.md' -exec sed -i "s/---%%%---/\n/g" {} +

# code - php, javascript, yaml, xml, html, css
find . -name '*.md' -exec sed -i ':a;N;$!ba;s/\n/---%%%---/g' {} +
find . -name '*.md' -exec sed -i 's/{% code title="\([^"]*\)" %}---%%%------%%%---```php/```php---%%%---\/\/ \1/g' {} +
find . -name '*.md' -exec sed -i 's/{% code title="\([^"]*\)" %}---%%%------%%%---```javascript/```javascript---%%%---\/\/ \1/g' {} +
find . -name '*.md' -exec sed -i 's/{% code title="\([^"]*\)" %}---%%%------%%%---```yaml/```yaml---%%%---\/\/ \1/g' {} +
find . -name '*.md' -exec sed -i 's/{% code title="\([^"]*\)" %}---%%%------%%%---```Yaml/```Yaml---%%%---\/\/ \1/g' {} +
find . -name '*.md' -exec sed -i 's/{% code title="\([^"]*\)" %}---%%%------%%%---```xml/```xml---%%%---\/\/ \1/g' {} +
find . -name '*.md' -exec sed -i 's/{% code title="\([^"]*\)" %}---%%%------%%%---```css/```css---%%%---\/\/ \1/g' {} +
find . -name '*.md' -exec sed -i 's/{% code title="\([^"]*\)" %}---%%%------%%%---```html/```html---%%%---\/\/ \1/g' {} +
find . -name '*.md' -exec sed -i 's/{% code title="\([^"]*\)" %}---%%%------%%%---```dotenv/```dotenv---%%%---\/\/ \1/g' {} +
find . -name '*.md' -exec sed -i 's/{% code title="\([^"]*\)" %}---%%%------%%%---```text/```text---%%%---\/\/ \1/g' {} +
find . -name '*.md' -exec sed -i 's/{% code title="\([^"]*\)" %}---%%%------%%%---```bash/```bash---%%%---\/\/ \1/g' {} +
find . -name '*.md' -exec sed -i 's/{% code title="\([^"]*\)" %}---%%%------%%%---```sh/```sh---%%%---\/\/ \1/g' {} +
find . -name '*.md' -exec sed -i 's/{% code title="\([^"]*\)" %}---%%%------%%%---```nix/```nix---%%%---\/\/ \1/g' {} +
find . -name '*.md' -exec sed -i 's/{% code title="\([^"]*\)" %}---%%%------%%%---```shell script/```shell script---%%%---\/\/ \1/g' {} +
find . -name '*.md' -exec sed -i 's/{% code title="\([^"]*\)" %}---%%%------%%%---```jsx/```jsx---%%%---\/\/ \1/g' {} +
find . -name '*.md' -exec sed -i 's/{% code title="\([^"]*\)" %}---%%%------%%%---```js/```js---%%%---\/\/ \1/g' {} +
find . -name '*.md' -exec sed -i "s/---%%%---/\n/g" {} +

# extra single-line xml
find . -name '*.md' -exec sed -i 's/{% code title="\([^"]*\)" %}---%%%---```xml/```xml\/\/ \1/g' {} +

# solve {% raw %} - twig, text, html, php
# solve {% endraw %}

# text to txt
find . -name '*.md' -exec sed -i 's/{```text/```txt/g' {} +

# start code
find . -name '*.md' -exec sed -i 's/{% code %}//g' {} +

# endcode
find . -name '*.md' -exec sed -i 's/{% endcode %}//g' {} +

# find . -name 'test.md' -exec sed 's/\[([^]]*)\]\((?!http)([^.]*)\.md\)/[\1](\2)/g' {} +

#find . -name '*.md' -exec sed 's/\[([^\[]+)\]\((?!http:|https:)(.*).md(#?.*)\)/\[\\1]\(\\2\\3)/g' {} +

#find . -name '*.md' -exec sed 's/\[(.*)\]\((.*)\/README\.md\)/[\1](\2/)/g' {} +
##find . -name '*.md' -exec sed -i 's/\[\([^]]*\)\]\(([^)]*)\/README\.md\)/[\1](\2\//g' {} +


# \[([^\[]+)\]\((.*).md(#?.*)\)
# \[([^\[]+)\]\((?!http:|https:)(.*).md(#?.*)\)

#sed 's/\[(.*)\]\((.*)\)/[\1](\2\/test/g' test.md

# git diff --diff-filter=M