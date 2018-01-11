PTX_HOME = /Users/joefields/Desktop/mathbook
JING_HOME = /Users/joefields/Desktop/jing-trang
BOOK_HOME = /Users/joefields/Desktop/Intro2Proof

all: svg pdf html
pdf: pdf/i2p.pdf
html: html/i2p.html

svg::
	${PTX_HOME}/script/mbx -vv -c latex-image -f svg -i ${BOOK_HOME}/figures -d ./html/images/ ./src/i2p.ptx

pdf/i2p.pdf: pdf/i2p.aux
	cd pdf; pdflatex i2p

pdf/i2p.aux: pdf/i2p.tex
	cd pdf; pdflatex i2p

pdf/i2p.tex: *.ptx images
	cd pdf; test ! -e photos && ln -s ../photos;  test ! -e figures && ln -s ../figures; xsltproc --xinclude ${PTX_HOME}/xsl/mathbook-latex.xsl ../src/i2p.ptx


html/i2p.html: ./src/*.ptx
	cd html; test ! -e photos && ln -s ../photos; test ! -e figures && ln -s ../figures; xsltproc --stringparam html.css.extra extra.css --stringparam html.knowl.example.inline no --stringparam html.knowl.exercise.inline no --xinclude ${PTX_HOME}/xsl/mathbook-html.xsl ../src/i2p.ptx

clean::
	rm *.aux *~ *.bak */*.aux */*~ */*.bak pdf/*.pdf html/*.html

check::
	java -classpath ${JING_HOME}/build/ -classpath ${JING_HOME}/lib/ -Dorg.apache.xerces.xni.parser.XMLParserConfiguration=org.apache.xerces.parsers.XIncludeParserConfiguration -jar ${JING_HOME}/build/jing.jar ${PTX_HOME}/schema/pretext.rng src/i2p.ptx > validation_errors.txt; less validation_errors.txt
