# Graphite [![Gem Version](https://badge.fury.io/rb/Graphite.svg)](http://badge.fury.io/rb/Graphite)

Graphite imports a folder of fonts and automagically outputs font-face directives for each font into your stylesheet.

## Installation

1. `gem install Graphite`
2. Add `require "graphite"` to your `config.rb`
3. Import into your stylesheet with `@import "graphite";`

## Documentation

#### File naming convention

In order for Graphite to successfully import your fonts, please follow this convention for naming your font files: `name-weightnum-style.extension`
