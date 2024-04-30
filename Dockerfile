FROM ruby:3.3.1

# 環境変数の設定
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

# 必要なパッケージのインストール
RUN apt-get update -qq && apt-get install -y ca-certificates curl gnupg build-essential libpq-dev

# Node.jsとBunのリポジトリと鍵の追加
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list

# Node.jsのインストール
RUN apt-get update && apt-get install -y nodejs

# アプリケーションディレクトリの作成
WORKDIR /app

# Bunのインストール
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/root/.bun/bin:${PATH}"

# Gemの依存関係の解決
COPY Gemfile* /app/
RUN gem update --system
RUN gem install bundler && bundle install

# Railsのインストール
RUN gem install rails
RUN which rails
RUN echo $PATH
RUN /usr/local/bundle/bin/rails --version
ENV PATH="/usr/local/bundle/bin:${PATH}"

# アプリケーションのファイルをコピー
COPY . /app

# package.json と bun.lockb をコピー
COPY package.json bun.lockb /app/

# 依存関係のインストール
RUN bun install

# ReactとBulmaのインストール
RUN bun add react react-dom
RUN bun add bulma

# ポート3000を公開
EXPOSE 3000

# Railsサーバーを起動
CMD ["rails", "server", "-b", "0.0.0.0"]
