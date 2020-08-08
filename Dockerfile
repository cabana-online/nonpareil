FROM cabanaonline/dev:1.0

ARG USER=cabana
ENV HOME /home/$USER

USER root

# Installs R.
RUN set -xe; \
    \
    apk add --update --no-cache R

# Builds tool.
RUN set -xe; \
    \
    git clone git://github.com/lmrodriguezr/nonpareil.git && \
    cd nonpareil && \
    make && \
    make install

# Removes build tools.
RUN set -xe; \
    \
    apk del \
        build-base \
        zlib-dev \
        make; \
        rm -rf /var/cache/apk/*

# Reverts to standard user.
USER cabana

# Entrypoint to keep the container running.
ENTRYPOINT ["tail", "-f", "/dev/null"]