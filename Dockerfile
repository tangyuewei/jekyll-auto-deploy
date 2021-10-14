FROM ruby:2.6.6

# install a modern bundler version
RUN gem install bundler

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
