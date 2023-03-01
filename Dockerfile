FROM ruby:3.2.0-alpine

ENV RAILS_ENV=development
ENV EDITOR=vim
WORKDIR /app

RUN apk add --update --no-cache \
    alpine-sdk \
    nodejs \
    yarn \
    tzdata \
    gcompat \
    vim \
    postgresql-dev
RUN gem install bundler -v 2.4.7

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs=2

COPY . .

EXPOSE 3000

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
