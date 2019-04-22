#!/usr/bin/env bash

mix test && mix credo && git commit -v
