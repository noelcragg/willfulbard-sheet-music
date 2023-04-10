#!/bin/bash

cd music

cat << EOF > ../build/index.html
<h1>Will's Music Files</h1>

<ul>

EOF

for f in *.abc
do
  echo "Processing $f file..."
  # take action on each file. $f store current file name
  filename="${f%.*}"
  abcm2ps "$f"
  ps2pdf Out.ps "$filename.pdf"
  mv "$filename.pdf" ../build/
  echo "<li><a href=\"$filename.pdf\">$filename.pdf</a></li> " >> ../build/index.html
done

cat << EOF >> ../build/index.html

</ul>

EOF

# Concat pdf & ps files
# gs \
#   -o merged.pdf \
#   -sDEVICE=pdfwrite \
#   -dPDFSETTINGS=/prepress \
#    input_1.pdf \
#    input_2.pdf \
#    input_3.eps \
#    input_4.ps \
#    input_5.pdf
