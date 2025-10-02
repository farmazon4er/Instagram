FROM ruby:2.7.6-slim-buster

# Чиним старые репозитории Debian
RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i 's|http://security.debian.org/debian-security|http://archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    apt-get update -o Acquire::Check-Valid-Until=false

ENV BUNDLER_VERSION=2.1.4

# Устанавливаем зависимости
RUN apt-get clean && apt-get update --fix-missing -qq \
    && apt-get install -qq -y \
    build-essential \
    libpq-dev \
    nodejs \
    npm \
    git \
    curl \
    wget \
    libxml2-dev \
    libxslt1-dev \
    libgcrypt20-dev \
    python3 \
    postgresql-client \
    imagemagick \
    libvips \
    && npm install -g yarn \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем нужный bundler
RUN gem install bundler -v 2.1.4

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY package.json yarn.lock ./
RUN yarn install --check-files

COPY . .

RUN bundle exec rails webpacker:install \
 && bundle exec rails webpacker:compile

# Entrypoint: ждём Postgres и запускаем Rails
RUN echo '#!/bin/bash\n\
set -e\n\
rm -f /app/tmp/pids/server.pid\n\
until pg_isready -h ${POSTGRES_HOST:-database} -p 5432 -U ${POSTGRES_USER:-postgres}; do\n\
  echo "Waiting for database...";\n\
  sleep 2;\n\
done\n\
exec "$@"' > /usr/bin/entrypoint.sh \
    && chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh"]

EXPOSE 3000

CMD ["bash", "-c", "bundle exec rails server -b 0.0.0.0 -p 3000"]
