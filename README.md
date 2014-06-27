# Graphite [![Gem Version](https://badge.fury.io/rb/graphite-sass.svg)](http://badge.fury.io/rb/graphite-sass)

Graphite imports a folder of fonts and automagically outputs font-face directives for each font into your stylesheet. Will write up better documentation soon.

##Requirements

* Sass ~> 3.3.0
* Compass ~> 1.0.0.alpha.19

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
│   │   ├── helvetica-neue-400-italic.woff
│   │   ├── helvetica-neue-400-normal.woff
│   │   ├── helvetica-neue-700-italic.woff
│   │   ├── helvetica-neue-700-normal.woff
│   │   ├── ...
│   ├── font-family...
│   │   ├── fonts...
├── sass
│   ├── style.scss
```

### File naming convention

In order for Graphite to successfully import your fonts, please follow this convention for naming your font files:

###### name: \[\<string\>\]
###### weight: \[\<100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900\>\]
###### style: \[\<normal | italic\>\]
###### extension: \[\<woff | ttf | eot | svg | otf\>\]

##### name-weight-style.extension

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
// Import fonts from $dir
// ----
// @param $dir [string] : directory to import fonts
// @param $legacy-ie [bool] : support legacy ie
// ----
// @return $fonts [map] : imports fonts from $dir and creates
//   a $var for each font family containing [string] name

@include graphite("/fonts", true);
```

Graphite will also create a local Sass variable for each font-family, so with the example above we would have a `$helvetica-neue: "helvetica-neue"` variable to use within the stylesheet, such as for a font stack. Graphite does not handle creating font stacks; that is left up to you. Graphite will import the correct filetypes for each font-family. This check is run on a family-to-family basis, and not a font-to-font basis; be sure to include the same filetypes for each font in your font-family folder to avoid any 404 request errors.

### Output

The output is similar to what Google Fonts does with their CSS. All fonts share the same font-family, and each fonts style and weight is assigned appropriately.

```scss
$helvetica-neue: "helvetica-neue";

@font-face {
  font-family: "helvetica-neue";
  font-weight: 200;
  font-style: italic;
  src: url("../fonts/helvetica-neue/helvetica-neue-200-italic.eot");
  src: url("../fonts/helvetica-neue/helvetica-neue-200-italic.eot?#iefix") format("embedded-opentype"), url("../fonts/helvetica-neue/helvetica-neue-200-italic.woff") format("woff"), url("../fonts/helvetica-neue/helvetica-neue-200-italic.ttf") format("truetype"), url("../fonts/helvetica-neue/helvetica-neue-200-italic.svg#helvetica-neue") format("svg");
}

@font-face {
  font-family: "helvetica-neue";
  font-weight: 200;
  font-style: normal;
  src: url("../fonts/helvetica-neue/helvetica-neue-200-normal.eot");
  src: url("../fonts/helvetica-neue/helvetica-neue-200-normal.eot?#iefix") format("embedded-opentype"), url("../fonts/helvetica-neue/helvetica-neue-200-normal.woff") format("woff"), url("../fonts/helvetica-neue/helvetica-neue-200-normal.ttf") format("truetype"), url("../fonts/helvetica-neue/helvetica-neue-200-normal.svg#helvetica-neue") format("svg");
}

@font-face {
  font-family: "helvetica-neue";
  font-weight: 700;
  font-style: italic;
  src: url("../fonts/helvetica-neue/helvetica-neue-700-italic.eot");
  src: url("../fonts/helvetica-neue/helvetica-neue-700-italic.eot?#iefix") format("embedded-opentype"), url("../fonts/helvetica-neue/helvetica-neue-700-italic.woff") format("woff"), url("../fonts/helvetica-neue/helvetica-neue-700-italic.ttf") format("truetype"), url("../fonts/helvetica-neue/helvetica-neue-700-italic.svg#helvetica-neue") format("svg");
}

@font-face {
  font-family: "helvetica-neue";
  font-weight: 700;
  font-style: normal;
  src: url("../fonts/helvetica-neue/helvetica-neue-700-normal.eot");
  src: url("../fonts/helvetica-neue/helvetica-neue-700-normal.eot?#iefix") format("embedded-opentype"), url("../fonts/helvetica-neue/helvetica-neue-700-normal.woff") format("woff"), url("../fonts/helvetica-neue/helvetica-neue-700-normal.ttf") format("truetype"), url("../fonts/helvetica-neue/helvetica-neue-700-normal.svg#helvetica-neue") format("svg");
}
```

## Authors

[Ezekiel Gabrielse](http://ezekielg.com)

## License

Graphite is available under the [MIT](http://opensource.org/licenses/MIT) license.
