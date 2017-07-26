
BUILD_DIR=build
OUTPUT_DIR=$(BUILD_DIR)/_site
AWESTRUCT_CONFIG=--source-dir=content --output-dir=$(OUTPUT_DIR)
ASSETS_DIR=$(OUTPUT_DIR)/assets/bower

# Generate everything
all: fetch generate pdfs
prepare: fetch depends assets

# Run a local dev server on localhost:4242
run: warning depends-ruby assets
	LISTEN=true ./scripts/ruby bundle exec awestruct --bind 0.0.0.0 --dev $(AWESTRUCT_CONFIG)

generate: warning depends-ruby assets $(OUTPUT_DIR)/releases.rss
	./scripts/ruby bundle exec awestruct --generate --verbose $(AWESTRUCT_CONFIG)

pdfs: $(OUTPUT_DIR)/user-handbook.pdf

$(OUTPUT_DIR)/user-handbook.pdf: depends-ruby scripts/generate-handbook-pdf
	./scripts/ruby scripts/generate-handbook-pdf $(BUILD_DIR)/user-handbook.adoc
	./scripts/ruby bundle exec asciidoctor-pdf -a allow-uri-read \
		--base-dir content \
		--out-file $(OUTPUT_DIR)/user-handbook.pdf \
		$(BUILD_DIR)/user-handbook.adoc


# Fetching and generating content from external sources
#######################################################
fetch: depends-ruby scripts/fetch-examples scripts/fetch-external-resources
	./scripts/fetch-examples
	./scripts/ruby bundle exec ./scripts/fetch-external-resources

$(OUTPUT_DIR)/releases.rss: scripts/release.rss.groovy
	./scripts/groovy scripts/release.rss.groovy 'https://updates.jenkins.io/release-history.json' > $(OUTPUT_DIR)/releases.rss
#######################################################


# Handling dependencies
#######################################################
depends: depends-ruby depends-node

depends-ruby: Gemfile
	./scripts/ruby bundle install --path=vendor/gems

depends-node: package.json
	./scripts/node npm install

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

#######################################################

# Miscellaneous tasks
#######################################################
warning:
	@echo '-------------------------------------------------------------'
	@echo ">> To save time, this won't automatically run \`make fetch\`."
	@echo ">> Please ensure you have run \`make fetch\` at least once"
	@echo '-------------------------------------------------------------'

clean:
	rm -rf vendor/gems
	rm -rf build/
	rm -rf node_modules/
#######################################################

.PHONY: all clean depends depends-node depends-ruby generate run \
		fetch warning pdfs assets prepare
