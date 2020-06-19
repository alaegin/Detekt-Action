FROM alpine:3.11

RUN apk --no-cache --update add git curl openjdk11 \
    && rm -rf /var/cache/apk/*

RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- -b /usr/local/bin/

RUN curl -sSLO https://github.com/detekt/detekt/releases/download/v1.10.0-RC1/detekt \
    && chmod a+x detekt \
    && mv detekt /usr/local/bin/

RUN curl -sSLO https://repo1.maven.org/maven2/io/gitlab/arturbosch/detekt/detekt-formatting/1.10.0-RC1/detekt-formatting-1.10.0-RC1.jar \
    && mv detekt-formatting.jar /opt/

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
