all: pdf html
pdf: pdf/i2p.pdf
html: html/i2p.html

pdf/i2p.pdf: pdf/i2p.aux
	cd pdf; pdflatex i2p
pdf/i2p.aux: pdf/i2p.tex
	cd pdf; pdflatex i2p
pdf/i2p.tex: *.ptx images
	cd pdf; test ! -e figures && ln -s ../figures; xsltproc --xinclude ../../../Desktop/mathbook/xsl/mathbook-latex.xsl ../src/i2p.ptx

html/i2p.html: ./src/*.ptx
	cd html;  test ! -e figures && ln -s ../figures; xsltproc --stringparam html.css.extra extra.css --stringparam html.knowl.example.inline no --stringparam html.knowl.exercise.inline no --xinclude ../../../Desktop/mathbook/xsl/mathbook-html.xsl ../src/i2p.ptx
clean::
	rm *.aux *~ *.bak */*.aux */*~ */*.bak pdf/*.pdf html/*.html
check::
	xmllint --xinclude --postvalid --noout --dtdvalid ../../Desktop/mathbook/schema/dtd/mathbook.dtd ./src/i2p.ptx 2> dtd-errors.txt
images::
	../../Desktop/mathbook/script/mbx -vv -c latex-image -f svg -d ./images -i ~/i2p/figures/ ./i2p.ptx
