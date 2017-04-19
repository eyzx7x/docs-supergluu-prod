#! /bin/bash
git pull
mkdocs build
rm -rf 3.0.0/
mv site/ 3.0.0/
echo -n "Enter task Performed >"
read text
echo "Entered Task: $text"

git add -A
git commit -m "updated site & - $text"
git push origin 3.0.0