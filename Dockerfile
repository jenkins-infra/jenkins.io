FROM ruby:2.6 as builder

RUN apt-get update -y &&\
    apt-get install -y --no-install-recommends make &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/jenkinsio

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN awestruct --generate --verbose --source-dir=content --output-dir=/usr/src/jenkinsio/_site

FROM nginx:1.17

COPY --from=builder /usr/src/jenkinsio/_site /usr/share/nginx/html

copy docker/default.conf /etc/nginx/conf.d/default.conf
