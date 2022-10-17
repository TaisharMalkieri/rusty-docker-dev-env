#!/usr/bin/env bash

cargo install cargo-binstall --bin
cargo binstall cargo-binstall

cargo binstall  cargo-expand    --no-confirm    \
                cargo-outdated  --no-confirm    \
                cargo-watch     --no-confirm    \
                cargo-geiger    --no-confirm    \
                cargo-chef      --no-confirm    \
                cargo-about     --no-confirm    \
                cargo-valgrind  --no-confirm    \
                cargo-spellcheck --no-confirm   \
                cargo-inspect   --no-confirm    \
                cargo-audit     --no-confirm    \
                cargo-tarpaulin --no-confirm    \
