FROM alpine:3.13.1

# https://github.com/detekt/detekt/releases
ARG DETEKT_VERSION="1.19.1"
# https://github.com/reviewdog/reviewdog/releases
ARG REVIEWDOG_VERSION="0.11.0"

ARG DETEKT_FILE_NAME="detekt-cli-${DETEKT_VERSION}-all.jar"
ARG DETEKT_URL="https://github.com/detekt/detekt/releases/download/v${DETEKT_VERSION}/${DETEKT_FILE_NAME}"

ARG DETEKT_FORMATTING_FILE_NAME="detekt-formatting-${DETEKT_VERSION}.jar"
ARG DETEKT_FORMATTING_URL="https://github.com/detekt/detekt/releases/download/v${DETEKT_VERSION}/${DETEKT_FORMATTING_FILE_NAME}"

RUN apk --no-cache --update add git curl openjdk11 bash \
    && rm -rf /var/cache/apk/*

RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/v${REVIEWDOG_VERSION}/install.sh | sh -s -- -b /usr/local/bin/
RUN curl -sSLO $DETEKT_URL \
    && mv $DETEKT_FILE_NAME /opt/detekt.jar

RUN curl -sSLO $DETEKT_FORMATTING_URL \
    && mv $DETEKT_FORMATTING_FILE_NAME /opt/detekt-formatting.jar

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
