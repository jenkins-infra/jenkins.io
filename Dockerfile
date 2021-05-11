FROM node:alpine as node

WORKDIR /usr/src/jenkinsio/_site/
ENV ASSETS_DIR=/usr/src/jenkinsio/_site/assets/bower
ENV FONTS_DIR=/usr/src/jenkinsio/_site/css/fonts

COPY package* ./

RUN npm install
RUN mkdir -p assets/bower css/fonts

RUN find node_modules \( -iname "*.eot" -o -iname "*.woff" -o -iname "*.ttf" \) -not -path "./node_modules/.cache/*" >> $$line ;\
    while read -r line; do\
		echo "Copying $line into assets/bower"; \
		cp "$line" assets/bower; \
	done < $$line

RUN for d in bootstrap jquery tether; do \
        echo "Copying node_modules/$d/dist/* into assets/bower/$d/"; \
        mkdir -p assets/bower/$d; \
        cp -R node_modules/$d/dist/* assets/bower/$d/ ; \
	  done;
RUN mkdir -p assets/bower/anchor-js/ assets/bower/ionicons
RUN cp node_modules/anchor-js/*.js assets/bower/anchor-js/
RUN cp -R node_modules/ionicons/dist/css assets/bower/ionicons
RUN cp -R node_modules/ionicons/dist/fonts assets/bower/ionicons

FROM ruby:2.6 as builder

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/jenkinsio

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY scripts scripts
COPY content content

RUN mkdir _site
COPY --from=node /usr/src/jenkinsio/_site/assets/bower ./_site/assets/bower
COPY --from=node /usr/src/jenkinsio/_site/css/fonts ./_site/css/fonts
RUN bundle exec ./scripts/release.rss.rb 'https://updates.jenkins.io/release-history.json' > ./_site/releases.rss
RUN bundle exec ./scripts/fetch-external-resources
RUN awestruct --generate --verbose --source-dir=content --output-dir=./_site


FROM nginx:1.17

COPY --from=builder /usr/src/jenkinsio/_site /usr/share/nginx/html

COPY docker/default.conf /etc/nginx/conf.d/default.conf
