# Phoenix Boilerplate

[![Travis](https://img.shields.io/travis/marcdel/phoenix_boilerplate.svg)](https://travis-ci.org/marcdel/phoenix_boilerplate)
[![Codecov](https://img.shields.io/codecov/c/github/marcdel/phoenix_boilerplate.svg)](https://codecov.io/gh/marcdel/phoenix_boilerplate)
[![Inch](http://inch-ci.org/github/marcdel/phoenix_boilerplate.svg)](http://inch-ci.org/github/marcdel/phoenix_boilerplate)

## Setup
* `./setup.sh`

## Pre-commit steps
* `./pre-commit.sh`

## Heroku Setup

* `heroku apps:create phoenix-boilerplate-staging --buildpack "https://github.com/HashNuke/heroku-buildpack-elixir.git"`
* `heroku buildpacks:add https://github.com/gjaldon/heroku-buildpack-phoenix-static.git`
* `heroku addons:create heroku-postgresql:hobby-dev`
* `heroku config:set POOL_SIZE=18`
* `heroku config:set SECRET_KEY_BASE="$(mix phx.gen.secret)"`

## Gigalixir Setup
* `gigalixir set_config phoenix-boilerplate-stg TWITTER_CONSUMER_SECRET supersecret`
* ...etc.

## Key generation
* `mix phx.gen.secret`
* or? `:crypto.strong_rand_bytes(32) |> Base.encode64()`

## PCF
* `cf login`
* `cf ssh phoenix-boilerplate`
* `/tmp/lifecycle/shell`
* `mix run -e 'PhoenixBoilerplate.Repo.query("select * from users", []) |> IO.inspect()'`
* `mix run -e 'PhoenixBoilerplate.Repo.query("TRUNCATE users cascade", [])'`
