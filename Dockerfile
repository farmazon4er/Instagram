FROM ruby:2.7.6-slim-buster
# Fix expired repo URLs
RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i 's|http://security.debian.org/debian-security|http://archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    apt-get update -o Acquire::Check-Valid-Until=false

ENV BUNDLER_VERSION=2.1.4

RUN apt-get clean && apt-get update --fix-missing -qq \
    && apt-get install -qq -y locales \
    && rm -rf /var/lib/apt/lists/* \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && echo "LANG=en_US.UTF-8" > /etc/default/locale \
    && locale-gen


RUN apt-get update -qq && apt-get install -y \
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
    && npm install -g yarn \
    && rm -rf /var/lib/apt/lists/*

RUN gem install bundler -v 2.1.4

WORKDIR /app

COPY Gemfile Gemfile.lock ./

# Устанавливаем гемы
RUN bundle install

# Копируем весь код приложения
COPY . .

# Создаем entrypoint
RUN echo '#!/bin/bash\nset -e\nrm -f /app/tmp/pids/server.pid\n\n# Ждем готовности базы данных (опционально)\nuntil pg_isready -h database -p 5432; do\n  echo "Waiting for database...";\n  sleep 2;\ndone\n\nexec "$@"' > /usr/bin/entrypoint.sh \
    && chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh"]

EXPOSE 3000


#RUN bundle config build.nokogiri --use-system-libraries
#
#RUN bundle check || bundle install
#
#COPY package.json yarn.lock ./
#
#RUN yarn install --check-files
#
#COPY . ./
#
#ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]