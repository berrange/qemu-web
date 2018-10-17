
YEARS = $(wildcard 2???)

INDEX_XML = index.xml $(YEARS:%=%/index.xml)
INDEX_HTML = $(INDEX_XML:%.xml=%.html)

NOTICE_XML = $(wildcard */???.xml)
NOTICE_TXT = $(NOTICE_XML:%.xml=%.txt)
NOTICE_HTML = $(NOTICE_XML:%.xml=%.html)

all: $(INDEX_XML) $(INDEX_HTML) $(NOTICE_TXT) $(NOTICE_HTML)

index.xml: $(NOTICE_XML) _scripts/index-xml Makefile
	mkdir -p `dirname $@`
	_scripts/index-xml $(NOTICE_XML) > $@

index.html: index.xml _scripts/index-html.xsl Makefile
	xsltproc _scripts/index-html.xsl $< > $@

%/index.xml: $(NOTICE_XML) _scripts/index-xml Makefile
	mkdir -p `dirname $@`
	DIR=`echo $@ | sed -e 's,/index.xml,,'`
	rm -f $@
	_scripts/index-xml $(wildcard $(@:%/index.xml=%/)???.xml) > $@

%/index.html: %/index.xml _scripts/index-html.xsl Makefile
	xsltproc --stringparam permalink $(@:%/index.html=/secnotice/%/) _scripts/index-html.xsl $< > $@

%.txt: %.xml _scripts/notice-txt.xsl Makefile
	mkdir -p `dirname $@`
	xsltproc _scripts/notice-txt.xsl $< > $@

%.html: %.xml $(INDEX_XML) _scripts/notice-html.xsl Makefile
	mkdir -p `dirname $@`
	xsltproc _scripts/notice-html.xsl $< > $@

clean:
	rm -rf index.{xml,html}
	rm -rf */index.{xml,html}
	rm -rf */*.{txt,html}
