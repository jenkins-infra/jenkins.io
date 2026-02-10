FROM ruby:3.4.8

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl gnupg chromium \
    && curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*
