#!/usr/bin/env bash

cargo install cargo-binstallca
cargo binstall cargo-binstall

cargo binstall  --no-confirm        \
                cargo-expand        \
                cargo-outdated      \
                cargo-watch         \
                cargo-geiger        \
                cargo-chef          \
                cargo-about         \
                cargo-valgrind      \
                cargo-spellcheck    \
                cargo-inspect       \
                cargo-audit         \
                cargo-tarpaulin     \
