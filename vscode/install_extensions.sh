#! /bin/bash
cat extensions.txt | while read -r line
do
  code --install-extension "$line"
done
