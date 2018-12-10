BOOKS=alice christmas_carol dracula frankenstein heart_of_darkness life_of_bee moby_dick modest_propsal pride_and_prejudice tale_of_two_cities ulysses all

FREQLISTS=$(BOOKS:%=results/%.freq.txt)
SENTEDBOOKS=$(BOOKS:%=results/%.sent.txt)
NOMD=$(BOOKS:%=data/%.no_md.txt)
PARSEDBOOKS=$(BOOKS:%=results/%.parsed.txt)

all: $(FREQLISTS) $(SENTEDBOOKS) $(NOMD) $(PARSEDBOOKS)

clean:
	rm -f results/* data/*no_md.txt

data/%.no_md.txt: data/%.txt
	python3 src/remove_gutenberg_metadata.py $< $@

results/%.freq.txt: data/%.no_md.txt 
	src/freqlist.sh $< $@

results/%.sent.txt: data/%.no_md.txt
	src/sent_per_line.sh $< $@

data/all.no_md.txt: data/*.no_md.txt
	cat $^ >data/all.no_md.txt

results/%.parsed.txt: results/%.sent.txt
	/usr/local/bin/python3 src/parse.py $< $@
