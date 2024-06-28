FROM node:20.12.2 as node
ENV USE_LOCAL_NODE=true

WORKDIR /usr/src/jenkinsio/build/_site/
ENV ASSETS_DIR=/usr/src/jenkinsio/build/_site/assets/bower
ENV FONTS_DIR=/usr/src/jenkinsio/build/_site/css/fonts

COPY Makefile package* ./
COPY scripts ./scripts

RUN npm install
RUN make assets

FROM ruby:3.3.2 as builder
ENV USE_LOCAL_RUBY=true

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/jenkinsio

COPY Makefile Gemfile Gemfile.lock ./
RUN bundle install

COPY scripts scripts
COPY content content

RUN mkdir -p ./build/_site
COPY --from=node /usr/src/jenkinsio/build/_site/assets/bower ./build/_site/assets/bower
COPY --from=node /usr/src/jenkinsio/build/_site/css/fonts ./build/_site/css/fonts
RUN bundle exec ./scripts/release.rss.rb 'https://updates.jenkins.io/release-history.json' > ./build/_site/releases.rss
RUN bundle exec ./scripts/fetch-external-resources
RUN make real_generate


FROM nginx:1.25

COPY --from=builder /usr/src/jenkinsio/build/_site /usr/share/nginx/html

COPY docker/default.conf /etc/nginx/conf.d/default.conf
