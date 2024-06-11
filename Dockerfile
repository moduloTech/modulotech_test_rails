FROM ruby:3.3.2-alpine

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
    postgresql-dev \
    git \
    imagemagick \
    vips-dev 

RUN gem install bundler -v 2.5.11

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs=2

COPY . .

# Initialize Git repository and configure safe directory
RUN git init && \
    git config --global --add safe.directory /app

EXPOSE 3000

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]

CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
