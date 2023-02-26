import re
import sys
from lxml import etree

#parser = etree.XMLParser(remove_blank_text=True)
parser = etree.XMLParser()
tree = etree.parse(sys.stdin.buffer, parser)
abstract = tree.find("./front//abstract")
title = etree.Element("title")
title.text = "Abstract"
abstract.append(title)
p = etree.Element("p")
p.text = abstract.text
abstract.append(p)
abstract.text=""
sys.stdout.buffer.write(etree.tostring(tree, pretty_print=False, xml_declaration=True, encoding=tree.docinfo.encoding))