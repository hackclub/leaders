FROM ruby:2.5.1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install vim for easy editing of credentials
# Install pg_restore for loading Heroku database captures
RUN apt-get -y update && apt-get -y install vim postgresql-client
ENV EDITOR=vim

ADD Gemfile /usr/src/app/Gemfile
ADD Gemfile.lock /usr/src/app/Gemfile.lock

ENV BUNDLE_GEMFILE=Gemfile \
  BUNDLE_JOBS=4 \
  BUNDLE_PATH=/bundle

RUN bundle install

ADD . /usr/src/app
