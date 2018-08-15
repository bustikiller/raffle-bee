FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /raffle-bee
WORKDIR /raffle-bee
COPY Gemfile /raffle-bee/Gemfile
COPY Gemfile.lock /raffle-bee/Gemfile.lock
RUN bundle install
COPY . /raffle-bee
ENTRYPOINT rails server
