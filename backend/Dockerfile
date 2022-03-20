FROM ruby:2.7.1-alpine3.12
SHELL ["/bin/sh", "-c"]
ENV LANG C.UTF-8

RUN apk update && \
    apk --update add --no-cache \
      build-base=0.5-r2 \
      less=551-r0 \
      libressl-dev=3.1.2-r0 \
      libxml2-dev=2.9.13-r0 \
      libxslt-dev=1.1.35-r0 \
      nodejs=12.22.10-r0 \
      postgresql-client=12.10-r0 \
      postgresql-dev=12.10-r0 \
      tzdata=2022a-r0 && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    rm -rf /var/cache/apk/*

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler -v "2.0.1" && \
  bundle config build.nokogiri --use-system-libraries && \
  bundle install -j4

COPY . ./
