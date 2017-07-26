OUTPUT_DIR=build/_site
AWESTRUCT_CONFIG=--source-dir=content --output-dir=$(OUTPUT_DIR)

all: fetch generate pdfs

run: warning depends
	LISTEN=true ./scripts/ruby bundle exec awestruct --bind 0.0.0.0 --dev $(AWESTRUCT_CONFIG)

depends:
	./scripts/ruby bundle install --path=vendor/gems

generate: warning depends $(OUTPUT_DIR)/releases.rss
	./scripts/ruby bundle exec awestruct --generate --verbose $(AWESTRUCT_CONFIG)

$(OUTPUT_DIR)/releases.rss: scripts/release.rss.groovy
	./scripts/groovy scripts/release.rss.groovy 'https://updates.jenkins.io/release-history.json' > $(OUTPUT_DIR)/releases.rss

pdfs: $(OUTPUT_DIR)/user-handbook.pdf

$(OUTPUT_DIR)/user-handbook.pdf: depends scripts/generate-handbook-pdf
	./scripts/ruby scripts/generate-handbook-pdf user-handbook.adoc
	./scripts/ruby bundle exec asciidoctor-pdf -a allow-uri-read \
		--base-dir content \
		--out-file $(OUTPUT_DIR)/user-handbook.pdf \
		user-handbook.adoc

fetch: depends scripts/fetch-examples scripts/fetch-external-resources
	./scripts/fetch-examples
	./scripts/ruby bundle exec ./scripts/fetch-external-resources

warning:
	@echo '-------------------------------------------------------------'
	@echo ">> To save time, this won't automatically run \`make fetch\`."
	@echo ">> Please ensure you have run \`make fetch\` at least onces"
	@echo '-------------------------------------------------------------'

clean:
	rm -rf vendor/gems
	rm -rf build/


.PHONY: all clean generate run fetch warning pdfs
