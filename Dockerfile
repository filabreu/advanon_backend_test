FROM ruby:2.4.1
RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
RUN echo "deb http://deb.nodesource.com/node_6.x jessie main" > /etc/apt/sources.list.d/nodesource.list
RUN curl -s https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn
RUN mkdir /backend_test
WORKDIR /backend_test
ADD Gemfile /backend_test/Gemfile
ADD Gemfile.lock /backend_test/Gemfile.lock
RUN bundle install
ADD . /backend_test
RUN yarn install
