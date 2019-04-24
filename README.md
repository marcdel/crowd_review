# Crowd Review

[![Travis](https://img.shields.io/travis/marcdel/crowd_review.svg)](https://travis-ci.org/marcdel/crowd_review)
[![Codecov](https://img.shields.io/codecov/c/github/marcdel/crowd_review.svg)](https://codecov.io/gh/marcdel/crowd_review)
[![Inch](http://inch-ci.org/github/marcdel/crowd_review.svg)](http://inch-ci.org/github/marcdel/crowd_review)

## 🚧 WIP 🚧
![Crowd Review Landing Page](Crowd%20Review%20Landing%20Page.png "Crowd Review Landing Page")

## Setup
* `./setup.sh`

## Pre-commit steps
* `./pre-commit.sh`

## Heroku Setup

* `heroku apps:create crowd-review-staging --buildpack "https://github.com/HashNuke/heroku-buildpack-elixir.git"`
* `heroku buildpacks:add https://github.com/gjaldon/heroku-buildpack-phoenix-static.git`
* `heroku addons:create heroku-postgresql:hobby-dev`
* `heroku config:set POOL_SIZE=18`
* `heroku config:set SECRET_KEY_BASE="$(mix phx.gen.secret)"`

## Gigalixir Setup
* `gigalixir set_config crowd-review-stg TWITTER_CONSUMER_SECRET supersecret`
* ...etc.

## Key generation
* `mix phx.gen.secret`
* or? `:crypto.strong_rand_bytes(32) |> Base.encode64()`

## PCF
* `cf login`
* `cf ssh crowd-review`
* `/tmp/lifecycle/shell`
* `mix run -e 'CrowdReview.Repo.query("select * from users", []) |> IO.inspect()'`
* `mix run -e 'CrowdReview.Repo.query("TRUNCATE users cascade", [])'`
