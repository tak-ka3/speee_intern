
FROM ruby:2.7.4

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
      curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
      echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && \
      apt-get install -y nodejs yarn

WORKDIR /tmp

RUN mkdir /app
WORKDIR /app

COPY package.json yarn.lock /app/
RUN yarn install

COPY Gemfile Gemfile.lock /app/
RUN bundle install --jobs 4

COPY . /app
RUN mkdir -p tmp/pids log
