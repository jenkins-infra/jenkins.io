FROM node:alpine as node

WORKDIR /usr/src/jenkinsio/_site/
ENV ASSETS_DIR=/usr/src/jenkinsio/_site/assets/bower
ENV FONTS_DIR=/usr/src/jenkinsio/_site/css/fonts

COPY Makefile package* ./

RUN npm install
RUN make assets

FROM ruby:2.6 as builder

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/jenkinsio

COPY Makefile Gemfile Gemfile.lock ./
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
