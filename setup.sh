#!/usr/bin/env bash

mix deps.get && mix ecto.create && mix ecto.migrate && gem install gosleap
