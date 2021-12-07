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

FROM ruby:2.7.2

ENV APP_HOME /rails-app-docker
ARG APP_USER=kaliguys
ARG APP_GROUP=kaliguys
ARG APP_USER_UID=1000
ARG APP_GROUP_GID=1000
# throw errors if Gemfile has been modified since Gemfile.lock
# RUN bundle config --global frozen 1

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
#RUN apt-get update
#RUN apt-get install -y yarn

RUN apt-get update && apt-get install -y nodejs yarn --no-install-recommends && rm -rf /var/lib/apt/lists/* && apt-get autoremove
RUN apt-get update && apt-get install -y mysql-common postgresql sqlite3 --no-install-recommends && rm -rf /var/lib/apt/lists/* && apt-get autoremove
#RUN apt add --update --no-cache \
RUN addgroup -gid $APP_GROUP_GID --system $APP_GROUP && \
    adduser --system -shell /sbin/nologin -uid $APP_USER_UID -gid $APP_GROUP_GID $APP_USER
#RUN addgroup -S $APP_GROUP && adduser -S appuser -G appgroup
#RUN npm install -g yarn
COPY --chown=$APP_USER:$APP_USER Gemfile $APP_HOME

# Uncomment the line below if Gemfile.lock is maintained outside of build process
COPY --chown=$APP_USER:$APP_USER Gemfile.lock $APP_HOME

RUN bundle install

USER $APP_USER
COPY --chown=$APP_USER:$APP_USER . $APP_HOME
CMD RAILS_ENV=${RAILS_ENV} bundle exec rails db:migrate db:seed && bundle exec rails s -p ${PORT} -b '0.0.0.0'

