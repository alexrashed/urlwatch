# https://hub.docker.com/_/python
FROM python:3.12.0-alpine3.18

# Optional python modules for additional functionality
# https://urlwatch.readthedocs.io/en/latest/dependencies.html#optional-packages
ARG OPT_PYPKGS="beautifulsoup4 jsbeautifier cssbeautifier aioxmpp chump"
ENV HOME="/home/user"

RUN adduser -D user
USER user
WORKDIR $HOME

COPY --chown=user . $HOME/urlwatch

RUN pip install \
  --no-cache-dir \
  ./urlwatch \
  $OPT_PYPKGS \
  && rm -rf urlwatch

RUN mkdir -p "/home/user/.config/urlwatch/" && chmod 700 "/home/user/.config/urlwatch/"
ADD entrypoint.sh /home/user/.local/bin/entrypoint.sh

ENV PATH="$HOME/.local/bin:$PATH"
ENTRYPOINT ["/home/user/.local/bin/urlwatch"]
