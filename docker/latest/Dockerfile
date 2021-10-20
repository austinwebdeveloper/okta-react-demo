FROM nginx:1.17.1-alpine

LABEL image=codejamninja/nginx:latest \
  maintainer="Jam Risser <jam@codejam.ninja>" \
  base=alpine:3.9

RUN apk add --no-cache --virtual build-deps \
  nodejs \
  npm \
  # yarn \
  g++ gcc libgcc libstdc++ linux-headers make python && \
  npm install --quiet node-gyp -g

COPY docker/latest/entrypoint.sh /usr/local/sbin/entrypoint.sh
COPY docker/latest/nginx.conf /etc/nginx/conf.d/default.conf

WORKDIR /tmp/app

COPY package.json /tmp/app
RUN npm install
COPY . /tmp/app
RUN npm run build && \
  mv /tmp/app/build /opt/app && \
  chmod +x /usr/local/sbin/entrypoint.sh && \
  apk del build-deps && \
  rm -rf /tmp/*

WORKDIR /opt/app

RUN CLIENT_ID='0oa2tf8scutCJanMj696' \
  ISSUER='https://nuevesolutions.okta.com/oauth2/default'

EXPOSE 80 8080

ENTRYPOINT ["/bin/sh", "/usr/local/sbin/entrypoint.sh"]
