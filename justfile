#!/usr/bin/env just --justfile

hello:
  echo "hello world"

full: clean export-proto generate
clean:
  rm -rf lib/pb

export-proto:
  buf export buf.build/protocolbuffers/wellknowntypes --path google/protobuf/compiler/plugin.proto -o proto

generate:
  buf generate --include-imports --include-wkt
  dart format lib/pb
