require_relative "importer"

# Taken from https://github.com/chriseppstein/sass-css-importer/blob/master/lib/sass/css_importer/monkey_patches.rb
# TODO: This feels wrong, surely there must be a better way to handle this

class Sass::Engine
    alias initialize_without_graphite_importer initialize

    def initialize(template, options={})
        initialize_without_graphite_importer(template, options)

        graphite_importer = self.options[:load_paths].find {|lp| lp.is_a?(Graphite::Importer) }

        unless graphite_importer
            root = File.dirname(options[:filename] || ".")
            self.options[:load_paths] << Graphite::Importer.new(root)
        end
    end
end
