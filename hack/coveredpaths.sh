#!/bin/bash
set -e

COVERED_PATHS="\
pkg/instancetype \
pkg/libvmi \
pkg/network/admitter \
pkg/network/namescheme \
pkg/network/domainspec \
pkg/network/deviceinfo \
pkg/virtctl/credentials \
tests/console \
tests/libnet \
tests/libnode \
tests/libconfigmap \
tests/libpod \
tests/libvmifact \
tests/libsecret \
tests/libinstancetype \
tests/instancetype \
${NULL}"
