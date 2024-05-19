#!/usr/bin/env just --justfile

hello:
  echo "hello world"

export-proto:
  buf export buf.build/protocolbuffers/wellknowntypes --path google/protobuf/compiler/plugin.proto -o proto

generate:
  buf generate --include-imports --include-wkt
  dart format lib/src/pb
