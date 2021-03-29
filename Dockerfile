#FROM ruby:2.7.1 AS rails-toolbox
#
#ARG USER_ID
#ARG GROUP_ID
#
#RUN addgroup --gid $GROUP_ID user
#RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user
#
#ENV INSTALL_PATH /opt/app
#RUN mkdir -p $INSTALL_PATH
#
#RUN gem install rails bundler
#RUN chown -R user:user $INSTALL_PATH
#WORKDIR $INSTALL_PATH
#
#USER $USER_ID
#CMD ["/bin/sh"]
#
#FROM ruby:2.7.0
#ENV APP_HOME /rails-docker
#    # Installation of dependencies
#RUN apt-get update -qq \
#  && apt-get install -y \
#      # Needed for certain gems
#    build-essential \
#         # Needed for postgres gem
#    libpq-dev \
#    # The following are used to trim down the size of the image by removing unneeded data
#  && apt-get clean autoclean \
#  && apt-get autoremove -y \
#  && rm -rf \
#    /var/lib/apt \
#    /var/lib/dpkg \
#    /var/lib/cache \
#    /var/lib/log# Create a directory for our application
## and set it as the working directory
#RUN mkdir $APP_HOME
#WORKDIR $APP_HOME
#    # Add our Gemfile and install gems
#ADD Gemfile* $APP_HOME/
#RUN bundle install# Copy over our application code
#ADD . $APP_HOME
#    # Run our app
#CMD RAILS_ENV=${RAILS_ENV} bundle exec rails db:create db:migrate db:seed && bundle exec rails s -p ${PORT} -b '0.0.0.0'

FROM ruby:2.7.0

# throw errors if Gemfile has been modified since Gemfile.lock
# RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y mysql postgresql-client sqlite3 --no-install-recommends && rm -rf /var/lib/apt/lists/*

COPY Gemfile /usr/src/app/

# Uncomment the line below if Gemfile.lock is maintained outside of build process
# COPY Gemfile.lock /usr/src/app/


RUN bundle install

COPY . /usr/src/app