# Graphite [![Gem Version](https://badge.fury.io/rb/graphite-sass.svg)](http://badge.fury.io/rb/graphite-sass)

Graphite allows you to import fonts into your stylesheet in a syntax similar to Google Fonts. Quick and simple. _Graphite is completely Ruby-based, so if you're not using a Ruby compiler (like libsass), then the plugin will not work without a Ruby wrapper._

## Requirements

* Sass `~> 3.3.0` _(have not tested earlier versions)_

## Installation

1. `gem install graphite-sass` / `bower install graphite-sass`
2. Add `require "graphite"` to your `config.rb`
3. Import into your stylesheet with `@import "graphite"`

## Documentation

### Directory tree

Each font-family should have it's own folder inside of the top-level fonts directory. The font-family directory name should match the name specified in the actual font filename.

```
root/
├── fonts/
│   ├── helvetica-neue/
│   │   ├── helvetica-neue-400-italic.woff
│   │   ├── helvetica-neue-400-normal.woff
│   │   ├── helvetica-neue-700-italic.woff
│   │   ├── helvetica-neue-700-normal.woff
│   │   ├── ...
│   ├── another-font-family/
│   │   ├── ...
├── sass/
│   ├── style.scss
├── css/
│   ├── style.css
...
```

### File naming convention

In order for Graphite to successfully import your fonts, please follow this convention for naming your font files:

> ###### name: \<string\>
> ###### weight: \<100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900\>
> ###### style: \<normal | italic | oblique\> (defaults to normal if blank)
> ###### extension: \<woff | woff2 | ttf | eot | svg | otf\>

#### name-weight-style.extension

Example,
`helvetica-neue-400-italic.woff`, `helvetica-neue-400-normal.ttf`, `helvetica-neue-100.svg`

### Usage

Font paths are relative to your `config.rb` or your `$LOAD_PATH`, so not necessarily the Sass file you're importing from. Graphite will automatically exit your Sass directory with `../` when outputting your fonts.

```scss
@import "fonts/lato?styles=200,700,200-italic,700-italic";
@import "fonts/helvetica-neue?styles=500";
```

### Output

The output is similar to what Google Fonts does with their CSS. All fonts share the same font-family, and each fonts style and weight is assigned appropriately.

```scss
@font-face {
  font-family: "lato";
  font-weight: 200;
  font-style: normal;
  src: url("../fonts/lato/lato-200.ttf") format("truetype");
}
@font-face {
  font-family: "lato";
  font-weight: 700;
  font-style: normal;
  src: url("../fonts/lato/lato-700.ttf") format("truetype");
}
@font-face {
  font-family: "lato";
  font-weight: 200;
  font-style: italic;
  src: url("../fonts/lato/lato-200-italic.ttf") format("truetype");
}
@font-face {
  font-family: "lato";
  font-weight: 700;
  font-style: italic;
  src: url("../fonts/lato/lato-700-italic.ttf") format("truetype");
}
@font-face {
  font-family: "helvetica-neue";
  font-weight: 500;
  font-style: normal;
  src: url("../fonts/helvetica-neue/helvetica-neue-500.eot");
  src: url("../fonts/helvetica-neue/helvetica-neue-500.eot?#iefix") format("embedded-opentype"), url("../fonts/helvetica-neue/helvetica-neue-500.woff") format("woff"), url("../fonts/helvetica-neue/helvetica-neue-500.ttf") format("truetype"), url("../fonts/helvetica-neue/helvetica-neue-500.svg#helvetica-neue") format("svg");
}
```

## Authors

[Ezekiel Gabrielse](http://ezekielg.com)

## License

Graphite is available under the [MIT](http://opensource.org/licenses/MIT) license.
