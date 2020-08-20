FROM alpine:3.11

# https://github.com/detekt/detekt/releases
ENV DETEKT_VERSION "1.11.2"

RUN apk --no-cache --update add git curl openjdk11 \
    && rm -rf /var/cache/apk/*

RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- -b /usr/local/bin/

RUN curl -sSLO https://github.com/detekt/detekt/releases/download/v${DETEKT_VERSION}/detekt \
    && chmod a+x detekt \
    && mv detekt /usr/local/bin/

RUN curl -sSLO https://repo1.maven.org/maven2/io/gitlab/arturbosch/detekt/detekt-formatting/${DETEKT_VERSION}/detekt-formatting-${DETEKT_VERSION}.jar \
    && mv detekt-formatting-${DETEKT_VERSION}.jar /opt/detekt-formatting.jar

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
