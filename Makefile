
BUILD_DIR=build
OUTPUT_DIR=$(BUILD_DIR)/_site
AWESTRUCT_CONFIG=--source-dir=content --output-dir=$(OUTPUT_DIR)
ASSETS_DIR=$(OUTPUT_DIR)/assets/bower
FONTS_DIR=$(OUTPUT_DIR)/css/fonts
VERSION=$(BUILD_NUMBER)-$(shell git rev-parse --short HEAD)
GITHUB_USER=$(USER)
BRANCH=$(shell git rev-parse --abbrev-ref HEAD)
USER_SITE_URL=https://$(GITHUB_USER).github.io/jenkins.io/$(BRANCH)/
AWESTRUCT_USER_SITE=-P user-site --url "$(USER_SITE_URL)"


# Generate everything
all: fetch-reset prepare generate archive
prepare: fetch depends assets

# Run a local dev server on localhost:4242
run: prepare scripts/awestruct
	LISTEN=true ./scripts/awestruct --dev --bind 0.0.0.0  $(AWESTRUCT_CONFIG)

generate: site pdfs

site: prepare scripts/awestruct
	./scripts/awestruct --generate --verbose $(AWESTRUCT_CONFIG)

user-site: prepare scripts/awestruct
	./scripts/awestruct --generate --verbose $(AWESTRUCT_CONFIG) $(AWESTRUCT_USER_SITE)
	./scripts/user-site-deploy.sh $(BRANCH)
	@echo SUCCESS: Published to $(USER_SITE_URL)

pdfs: prepare scripts/generate-handbook-pdf scripts/asciidoctor-pdf
	./scripts/ruby scripts/generate-handbook-pdf $(BUILD_DIR)/user-handbook.adoc
	./scripts/asciidoctor-pdf -a allow-uri-read \
		--base-dir content \
		--out-file user-handbook.pdf \
		$(BUILD_DIR)/user-handbook.adoc

# Fetching and generating content from external sources
#######################################################
# NOTE: Fetch only runs once until flag is reset
fetch: $(BUILD_DIR)/fetch

# force fetching of resources
fetch-reset:
	@rm -f $(BUILD_DIR)/fetch

$(BUILD_DIR)/fetch: $(BUILD_DIR)/ruby scripts/release.rss.groovy scripts/fetch-examples scripts/fetch-external-resources | $(OUTPUT_DIR)
	./scripts/groovy pull
	./scripts/groovy scripts/release.rss.groovy 'https://updates.jenkins.io/release-history.json' > $(OUTPUT_DIR)/releases.rss
	./scripts/fetch-examples
	./scripts/ruby bundle exec ./scripts/fetch-external-resources
	@touch $(BUILD_DIR)/fetch

#######################################################


# Handling dependencies
#######################################################
depends: $(BUILD_DIR)/ruby $(BUILD_DIR)/node

# update dependencies information
update: depends
	./scripts/ruby bundle update
	./scripts/node npm update

# when we pull dependencies also pull docker image
# without this images can get stale and out of sync from CI system
$(BUILD_DIR)/ruby: Gemfile Gemfile.lock scripts/ruby | $(OUTPUT_DIR)
	./scripts/ruby pull
	./scripts/ruby bundle install --path=vendor/gems
	@touch $(BUILD_DIR)/ruby

# when we pull dependencies also pull docker image
# without this images can get stale and out of sync from CI system
$(BUILD_DIR)/node: package.json package-lock.json scripts/node | $(OUTPUT_DIR)
	./scripts/node pull
	./scripts/node npm install
	@touch $(BUILD_DIR)/node

assets: $(BUILD_DIR)/assets

$(BUILD_DIR)/assets: $(BUILD_DIR)/node $(shell find . -ipath "./node_modules/*")
	@mkdir -p $(FONTS_DIR)
	@mkdir -p $(ASSETS_DIR)
	@for f in $(shell find node_modules \( -iname "*.eot" -o -iname "*.woff" -o -iname "*.ttf" \)); do \
		echo "Copying $$f into $(FONTS_DIR)"; \
		cp $$f $(FONTS_DIR); \
	done;
	@for d in bootstrap jquery tether; do \
		echo "Copying node_modules/$$d/dist/* into $(ASSETS_DIR)/$$d/"; \
		mkdir -p $(ASSETS_DIR)/$$d; \
		cp -R node_modules/$$d/dist/* $(ASSETS_DIR)/$$d/ ; \
	done;
	mkdir -p $(ASSETS_DIR)/anchor-js/
	cp node_modules/anchor-js/*.js $(ASSETS_DIR)/anchor-js/
	mkdir -p $(ASSETS_DIR)/ionicons
	cp -R node_modules/ionicons/css $(ASSETS_DIR)/ionicons
	cp -R node_modules/ionicons/fonts $(ASSETS_DIR)/ionicons
	@touch $(BUILD_DIR)/assets

#######################################################


# Archive tasks
#######################################################
archive: generate
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
	rm -rf $(BUILD_DIR)
	rm -rf node_modules/
#######################################################

.PHONY: all archive assets clean depends \
		fetch fetch-reset generate pdfs prepare run site update
