
BUILD_DIR=build
OUTPUT_DIR=$(BUILD_DIR)/_site
AWESTRUCT_CONFIG=--source-dir=content --output-dir=$(OUTPUT_DIR)
ASSETS_DIR=$(OUTPUT_DIR)/assets/bower
VERSION=$(BUILD_NUMBER)-$(shell git rev-parse --short HEAD)

# Generate everything
all: fetch-reset fetch generate archive
prepare: fetch depends assets

# Run a local dev server on localhost:4242
run: fetch depends-ruby assets
	LISTEN=true ./scripts/ruby bundle exec awestruct --bind 0.0.0.0 --dev $(AWESTRUCT_CONFIG)

generate: site pdfs

site: fetch $(OUTPUT_DIR) depends-ruby assets
	./scripts/ruby bundle exec awestruct --generate --verbose $(AWESTRUCT_CONFIG)

pdfs: fetch $(OUTPUT_DIR)/user-handbook.pdf

$(OUTPUT_DIR)/user-handbook.pdf: $(OUTPUT_DIR) depends-ruby scripts/generate-handbook-pdf
	./scripts/ruby scripts/generate-handbook-pdf $(BUILD_DIR)/user-handbook.adoc
	./scripts/ruby bundle exec asciidoctor-pdf -a allow-uri-read \
		--base-dir content \
		--out-file user-handbook.pdf \
		$(BUILD_DIR)/user-handbook.adoc


# Fetching and generating content from external sources
#######################################################
# NOTE: Fetch only runs once until flag is reset
fetch: depends-ruby $(BUILD_DIR)/fetched

# force fetching of resources
fetch-reset: $(OUTPUT_DIR)
	@rm -f $(BUILD_DIR)/fetched

$(BUILD_DIR)/fetched: $(OUTPUT_DIR) $(OUTPUT_DIR)/releases.rss scripts/fetch-examples scripts/fetch-external-resources
	./scripts/fetch-examples
	./scripts/ruby bundle exec ./scripts/fetch-external-resources
	@touch $(BUILD_DIR)/fetched

$(OUTPUT_DIR)/releases.rss: $(OUTPUT_DIR) scripts/release.rss.groovy
	./scripts/groovy scripts/release.rss.groovy 'https://updates.jenkins.io/release-history.json' > $(OUTPUT_DIR)/releases.rss
#######################################################


# Handling dependencies
#######################################################
depends: depends-ruby depends-node

depends-ruby: vendor/gems

vendor/gems: Gemfile
	./scripts/ruby bundle install --path=vendor/gems
	@touch vendor/gems

depends-node: node_modules

node_modules: package.json package-lock.json
		./scripts/node npm install
		@touch node_modules

assets: depends-node
	mkdir -p $(ASSETS_DIR)
	mkdir -p $(OUTPUT_DIR)/css/fonts
	@for f in $(shell find node_modules \( -iname "*.eot" -o -iname "*.woff" -o -iname "*.ttf" \)); do \
		echo ">> $$f => $(OUTPUT_DIR)/css/fonts/"; \
		cp $$f $(OUTPUT_DIR)/css/fonts/; \
	done;
	@for d in bootstrap jquery tether; do \
		echo ">> Copying node_modules/$$d/dist/* into $(ASSETS_DIR)/$$d/"; \
		mkdir -p $(ASSETS_DIR)/$$d; \
		cp -R node_modules/$$d/dist/* $(ASSETS_DIR)/$$d/ ; \
	done;
	mkdir -p $(ASSETS_DIR)/anchor-js/
	cp node_modules/anchor-js/*.js $(ASSETS_DIR)/anchor-js/
	mkdir -p $(ASSETS_DIR)/ionicons
	cp -R node_modules/ionicons/css $(ASSETS_DIR)/ionicons
	cp -R node_modules/ionicons/fonts $(ASSETS_DIR)/ionicons
#######################################################


# Archive tasks
#######################################################
archive: $(OUTPUT_DIR)
	mkdir -p $(BUILD_DIR)/archives
	(cd $(BUILD_DIR) && \
		rm -f archives/jenkins.io-$(VERSION).zip && \
		ln -f -s _site jenkins.io-$(VERSION) && \
		zip --quiet -r archives/jenkins.io-$(VERSION).zip jenkins.io-$(VERSION))
#######################################################


# Miscellaneous tasks
#######################################################
$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

clean:
	rm -rf vendor/gems
	rm -rf build/
	rm -rf node_modules/
#######################################################

.PHONY: all archive assets clean depends depends-node depends-ruby \
		fetch fetch-reset generate pdfs prepare run site
