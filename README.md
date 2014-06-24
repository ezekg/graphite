# Graphite [![Gem Version](https://badge.fury.io/rb/graphite-sass.svg)](http://badge.fury.io/rb/graphite-sass)

Graphite imports a folder of fonts and automagically outputs font-face directives for each font into your stylesheet. Will write up better documentation soon.

## Installation

1. `gem install graphite-sass`
2. Add `require "graphite"` to your `config.rb`
3. Import into your stylesheet with `@import "graphite";`

## Documentation

### Directory tree

Each font-family should have it's own folder inside of the top-level fonts directory. Font-family directory name should match the name specified in the actual font filename.

```
root
├── fonts
│   ├── helvetica-neue
│   │   ├── helvetica-neue-400-normal.woff
```

### File naming convention

In order for Graphite to successfully import your fonts, please follow this convention for naming your font files:

```
name <string>
weight <100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900>
style <normal | italic>
extension <woff | ttf | eot | svg | otf>

name-weight-style.extension
```

Example,
`helvetica-neue-400-italic.woff`, `helvetica-neue-400-normal.ttf`, `helvetica-neue-100-normal.svg`

### Configuration

These global variables can be changed according to your needs.

```scss
// Filename seperator
// ----
$graphite_seperator: "-" !global;

// Prepend directory path
// ----
$graphite_chdir: ".." !global;
```

### Usage

```scss
@include graphite("/fonts");
```

Graphite will also create local variables for each font, so with the example above we would have a `$helvetica-neue: "helvetica-neue";` variable to use within out stylesheet. Graphite does not handle creating font stacks; that is left up to you.
