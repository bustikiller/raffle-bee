FROM ruby:2.5.1
MAINTAINER Bustikiller
RUN apt-get update -qq \
    && apt-get install --no-install-recommends -y build-essential libpq-dev nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN mkdir /raffle-bee
WORKDIR /raffle-bee
COPY Gemfile /raffle-bee/Gemfile
COPY Gemfile.lock /raffle-bee/Gemfile.lock
RUN bundle install
COPY . /raffle-bee
ENTRYPOINT rails server
