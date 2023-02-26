# ccr-latex-pandoc-reader
Pandoc reader for latex files in CCR style

To convert a file `main.tex` to JATS, use e.g.:

```
pandoc -f ccr_latex.lua -st jats main.tex
```

Optionally, postprocess abstract to contain a title and p element:

```
pandoc -f ccr_latex.lua -st jats main.tex | python postprocess.py
```
