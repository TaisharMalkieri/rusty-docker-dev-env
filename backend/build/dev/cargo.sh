#!/usr/bin/env bash
rustup default stable

cargo install cargo-binstall
cargo install --locked cargo-chef
cargo binstall cargo-binstall --no-confirm

cargo binstall  --no-confirm        \
                cargo-expand        \
                cargo-outdated      \
                cargo-watch         \
                cargo-geiger        \
                cargo-about         \
                cargo-spellcheck    \
                cargo-inspect       \
                cargo-audit         \
                cargo-clippy        \
#                cargo-tarpaulin
#                cargo-valgrind
