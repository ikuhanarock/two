FROM nginx:1.19.2-alpine
SHELL ["/bin/sh", "-c"]
ENV LANG C.UTF-8

RUN apk update && \
    apk --update add --no-cache \
      tzdata=2021e-r0 && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    rm -rf /var/cache/apk/*

RUN rm -f /etc/nginx/conf.d/*

COPY nginx.conf /etc/nginx/nginx.conf
COPY conf.d/webapp.conf /etc/nginx/conf.d/webapp.conf
RUN mkdir /etc/nginx/certs
COPY certs/ /etc/nginx/certs

CMD ["/usr/sbin/nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]
