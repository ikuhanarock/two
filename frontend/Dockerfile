FROM node:16.3.0-alpine3.13
ENV LANG="ja_JP.UTF-8"\
    YARN_VERSION="1.22.5"

RUN apk update && \
    apk --update add --no-cache --virtual \
      .build-deps-yarn \
      curl=7.79.1-r0 \
      tzdata=2022a-r0 && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" && \
    tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/ && \
    ln -snf /opt/yarn-v$YARN_VERSION/bin/yarn /usr/local/bin/yarn && \
    ln -snf /opt/yarn-v$YARN_VERSION/bin/yarnpkg /usr/local/bin/yarnpkg && \
    rm yarn-v$YARN_VERSION.tar.gz && \
    apk del .build-deps-yarn && \
    rm -rf /var/cache/apk/*

RUN mkdir /frontend
WORKDIR /frontend

COPY ./package.json ./yarn.lock ./
RUN yarn install

COPY . ./

CMD ["yarn", "start:dev"]
