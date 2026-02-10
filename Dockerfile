FROM node:22.22.0 as node
ENV PUPPETEER_SKIP_DOWNLOAD=true
ENV USE_LOCAL_NODE=true

WORKDIR /usr/src/jenkinsio/build/_site/
ENV ASSETS_DIR=/usr/src/jenkinsio/build/_site/assets/bower
ENV FONTS_DIR=/usr/src/jenkinsio/build/_site/css/fonts

COPY Makefile package* ./
COPY scripts ./scripts

RUN npm install
RUN make assets

FROM ruby:3.4.8 as builder
ENV USE_LOCAL_RUBY=true

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1
RUN apt-get update \
    && apt-get install -y --no-install-recommends chromium \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/jenkinsio

COPY Makefile Gemfile Gemfile.lock ./
RUN BUNDLE_FULL_INDEX=true bundle install

COPY scripts scripts
COPY content content

RUN mkdir -p ./build/_site
COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /usr/local/bin/npm /usr/local/bin/npm
COPY --from=node /usr/local/bin/npx /usr/local/bin/npx
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/src/jenkinsio/build/_site/node_modules ./node_modules
COPY --from=node /usr/src/jenkinsio/build/_site/assets/bower ./build/_site/assets/bower
COPY --from=node /usr/src/jenkinsio/build/_site/css/fonts ./build/_site/css/fonts
RUN bundle exec ./scripts/release.rss.rb 'https://updates.jenkins.io/release-history.json' > ./build/_site/releases.rss
RUN bundle exec ./scripts/fetch-external-resources
RUN make real_generate


FROM nginx:1.25

COPY --from=builder /usr/src/jenkinsio/build/_site /usr/share/nginx/html

COPY docker/default.conf /etc/nginx/conf.d/default.conf
