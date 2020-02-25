FROM ruby:2.6.5

RUN apt-get update && apt-get install -y libimage-exiftool-perl
RUN apt-get install -y net-tools

ENV APP_ROOT /usr/src
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT

RUN gem install bundler -v 2.0.2

ADD ./Gemfile $APP_ROOT
ADD ./Gemfile.lock $APP_ROOT

RUN bundle install

COPY . /usr/src/
ENV TZ='Asia/Tokyo'

EXPOSE 3000
CMD rm -f tmp/pids/server.pid && \
  rails db:migrate RAILS_ENV=development && \
  rake db:seed && \
  sh -c 'RACK_ENV=development nohup bundle exec faktory-worker -q mailer &' && \
  RAILS_ENV=development RACK_ENV=development falcon serve -b http://0.0.0.0:3000 --threaded

## Run in hybrid mode when in staging and production

# CMD rm -f tmp/pids/server.pid && \
#   rails db:migrate RAILS_ENV=staging && \
#   rake db:seed && \
#   sh -c 'RACK_ENV=staging nohup bundle exec faktory-worker -q mailer &' && \
#   RAILS_ENV=staging RACK_ENV=staging falcon serve -b https://0.0.0.0:3000 --hybrid

# CMD rm -f tmp/pids/server.pid && \
#   rails db:migrate RAILS_ENV=production && \
#   rake db:seed && \
#   sh -c 'RACK_ENV=production nohup bundle exec faktory-worker -q mailer &' && \
#   RAILS_ENV=production RACK_ENV=production falcon serve -b https://0.0.0.0:3000 --hybrid
