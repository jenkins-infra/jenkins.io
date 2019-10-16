
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
prepare: scripts-permission fetch depends assets

# Run a local dev server on localhost:4242
run: prepare scripts/awestruct
	LISTEN=true ./scripts/awestruct --dev --bind 0.0.0.0  $(AWESTRUCT_CONFIG)

generate: site check-broken-links

site: prepare scripts/awestruct
	./scripts/awestruct --generate --verbose $(AWESTRUCT_CONFIG)

check-broken-links: site
	./scripts/check-broken-links > build/check-broken-links.txt

user-site: prepare scripts/awestruct
	./scripts/awestruct --generate --verbose $(AWESTRUCT_CONFIG) $(AWESTRUCT_USER_SITE)
	./scripts/user-site-deploy.sh $(BRANCH)
	@echo SUCCESS: Published to $(USER_SITE_URL)index.html

# Fetching and generating content from external sources
#######################################################
# NOTE: Fetch only runs once until flag is reset
fetch: $(BUILD_DIR)/fetch

# force fetching of resources
fetch-reset:
	@rm -f $(BUILD_DIR)/fetch

$(BUILD_DIR)/fetch: $(BUILD_DIR)/ruby scripts/release.rss.groovy scripts/fetch-external-resources content/_tmp | $(OUTPUT_DIR)
	./scripts/groovy pull
	./scripts/groovy scripts/release.rss.groovy 'https://updates.jenkins.io/release-history.json' > $(OUTPUT_DIR)/releases.rss
	./scripts/ruby bundle exec ./scripts/fetch-external-resources
	@touch $(BUILD_DIR)/fetch

# Ensure scripts are marked +x
# chmod only runs on these scripts during fresh build or when one of these scripts changes.
scripts-permission: $(BUILD_DIR)/scripts-permission

$(BUILD_DIR)/scripts-permission: ./scripts/groovy ./scripts/ruby ./scripts/node ./scripts/asciidoctor-pdf ./scripts/awestruct ./scripts/user-site-deploy.sh ./scripts/release.rss.groovy ./scripts/fetch-external-resources ./scripts/check-broken-links | $(OUTPUT_DIR)
	chmod u+x $?
	@touch $(BUILD_DIR)/scripts-permission



#######################################################


# Handling dependencies
#######################################################
depends: $(BUILD_DIR)/ruby $(BUILD_DIR)/node

# update dependencies to latest within the allowed version ranges
# When we update we also clean ensure build output includes only dependencies.
update: clean depends
	./scripts/ruby bundle update
	./scripts/node npm update

# when we pull dependencies also pull docker image
# without this images can get stale and out of sync from CI system
# If the dev deletes vendor/gems independent of other changes, the build reinstalls it.
$(BUILD_DIR)/ruby: Gemfile Gemfile.lock scripts/ruby vendor/gems | $(OUTPUT_DIR)
	./scripts/ruby pull
	./scripts/ruby bundle install --path=vendor/gems
	@touch $(BUILD_DIR)/ruby

# when we pull dependencies also pull docker image
# without this images can get stale and out of sync from CI system
# If the dev deletes node_modules independent of other changes, the build reinstalls it.
$(BUILD_DIR)/node: package.json package-lock.json scripts/node node_modules | $(OUTPUT_DIR)
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
	cp -R node_modules/ionicons/dist/css $(ASSETS_DIR)/ionicons
	cp -R node_modules/ionicons/dist/fonts $(ASSETS_DIR)/ionicons
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
# build targets for directories
$(OUTPUT_DIR) node_modules vendor/gems content/_tmp:
	mkdir -p $@

# clean -Xfd removes any ignored files and directories
# but leave any changed or untracked files alone.
clean:
	git clean -Xfd

#######################################################

.PHONY: all archive assets clean depends \
		fetch fetch-reset generate prepare run site update
