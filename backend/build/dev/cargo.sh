#!/usr/bin/env bash

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
#                cargo-tarpaulin     \
#                cargo-valgrind      \

# Cook the dependencies
cargo chef prepare --recipe-path /backend/recipe.json
cargo chef cook --recipe-path /backend/recipe.json