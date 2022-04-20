#!/usr/bin/env bash

jq --null-input 'reduce inputs as $in (null; . + $in)' tex-*.json > tex.json
