FROM hexpm/elixir:1.18.4-erlang-28.0.2-alpine-3.22.1 AS dev

RUN apk add --no-cache build-base git curl nodejs npm inotify-tools postgresql-client && mkdir -p /app


WORKDIR /app

RUN set -x && \
    mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install hex phx_new --force

ENV MIX_ENV=dev

COPY . .

RUN mix deps.get && \ 
    mix deps.compile && \
    mix compile

WORKDIR /app/apps/rtspt_web/assets
RUN npm install && npm run deploy || true

WORKDIR /app

CMD mix reset && mix phx.server
