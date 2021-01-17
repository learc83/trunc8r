FROM ruby:2.7.1

WORKDIR /home/app

ENV PORT 3000

EXPOSE $PORT

# Add Yarn to the sources list
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

# RUN gem install rails bundler
# RUN gem install rails
RUN apt-get update -qq && apt-get install -y nodejs yarn

ADD production/start.sh /
RUN chmod +x /start.sh

# COPY trunc8r /home/app/trunc8r

# Add sudo user
RUN apt-get update \
 && apt-get install -y sudo

RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER docker

COPY --chown=docker trunc8r /home/app/trunc8r

# ENTRYPOINT [ "/bin/bash" ]
# ENTRYPOINT /bin/bash

CMD ["/start.sh"]
