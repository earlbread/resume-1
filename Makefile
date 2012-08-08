
PANDOC=pandoc

all: resume

resume: resume.txt index.html resume.odt

resume.txt: resume.rst
	cp resume.rst resume.txt

index.html: resume.rst style.css
	$(PANDOC) --base-header=2 -f rst -t html -s -S -c style.css \
	          -o index.html resume.rst

resume.odt: resume.rst
	$(PANDOC) -f rst -t odt -o resume.odt resume.txt

clean:
	rm resume.txt index.html resume.odt

publish: resume
	git clone -b gh-pages git@github.com:dahlia/resume.git __tmp__
	cp resume.rst index.html resume.txt resume.odt __tmp__/
	pushd __tmp__; \
	git add -f resume.rst index.html resume.txt resume.odt; \
	git commit -am "Publish"; \
	git push git@github.com:dahlia/resume.git gh-pages:gh-pages
	rm -rf __tmp__
