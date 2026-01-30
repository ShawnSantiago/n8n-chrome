FROM docker.n8n.io/n8nio/n8n:latest

USER root

# Install Chromium + required libs (Alpine)
RUN apk add --no-cache \
  chromium \
  nss \
  freetype \
  harfbuzz \
  ca-certificates \
  ttf-freefont \
  font-noto \
  libstdc++ \
  udev

# Tell Playwright to NOT download its own Chromium (we use system Chromium)
ENV PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1
ENV PLAYWRIGHT_BROWSERS_PATH=/home/node/.cache/ms-playwright
ENV CHROME_BIN=/usr/bin/chromium-browser
ENV PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH=/usr/bin/chromium-browser

RUN mkdir -p /home/node/.cache/ms-playwright \
  && chown -R node:node /home/node/.cache/ms-playwright

USER node

# Install Playwright (library only) so your node can require it
RUN npm_config_loglevel=warn npm i -g playwright@latest
