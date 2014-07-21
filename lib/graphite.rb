require 'compass'
require 'sassy_hash'

extension_path = File.expand_path(File.join(File.dirname(__FILE__), ".."))
Compass::Frameworks.register('graphite', :path => extension_path)

module Graphite
    VERSION = "0.1.0"
    DATE = "2014-07-21"
end

# Graphite : import fonts from font_dir into map
# ----------------------------------------------------------------------------------------------------
# @param font_dir [string] : path to top-level font directory
# @param legacy_ie [bool] : support legacy versions of ie
# ----------------------------------------------------------------------------------------------------
# @return map of fonts, variable for each font

module Sass::Script::Functions
    def graphite(font_dir, legacy_ie = false)

        def opts(value)
            value.options = options
            value
        end

        # Set Sass variable to environment
        def set_sass_var(literal, name = literal)
            environment.global_env.set_var("#{name}", Sass::Script::Value::String.new(literal))
        end

        # Get weights and styles for passed font
        def font_has_weights?(font)
            # Keep hash of weights found
            weights = {}
            # Valid weights
            valid_weights = ["100", "200", "300", "400", "500", "600", "700", "800", "900"]
            # valid styles
            valid_styles = ["normal", "italic"]
            # Get weights for font
            valid_weights.each do |weight|
                # Check filename for weight
                if font.include?(weight)
                    # Get styles for weight
                    styles = []
                    # Check filename for style
                    valid_styles.each do |style|
                        if font.include?(style)
                            # Save to styles
                            styles << style
                        end
                    end
                    # Keep hash of each weight
                    w = {
                        weight => {
                            "styles" => styles
                        }
                    }
                    # Merge weight into weights hash
                    weights.merge!(w)
                end
            end
            # Return weights
            return weights
        end

        # Add style to passed weight
        def set_font_style(font, style)
            font.merge!(style) do |k, old, new|
                # Merge styles
                if old.is_a?(Hash)
                    # Get key => value of old map
                    old.each do |key, value|
                        # Does new map have key?
                        if new.has_key?(key)
                            # Then concat values
                            new.each do |k, v|
                                value.concat(v)
                            end
                        end
                    end
                end
            end
        end

        # Check if passed dir has fonts
        def dir_has_fonts?(dir)
            # Keep hash of all fonts found
            fonts = {}
            # Valid font extensions
            valid_extensions = ["eot", "otf", "woff", "ttf", "svg"]
            # Change dir to font_dir
            Dir.chdir(dir) do
                # Search each dir
                Dir.glob("**/") do |d|
                    # Check if dir has fonts
                    Dir.chdir(d) do
                        path = d
                        # Clean up font name
                        family = d.delete("/")
                        # Get matched extensions
                        extensions = []
                        # Get matched weights and styles
                        variations = {}
                        # Check dir for matching extensions
                        valid_extensions.each do |ext|
                            Dir.glob("*.#{ext}") do |filename|
                                if filename.size > 0
                                    # Check if filename has weights
                                    w = font_has_weights?(filename.to_s)
                                    # Merge weights and styles
                                    set_font_style(variations, w)
                                    # Save extensions that exist
                                    if extensions.include?(ext) === false
                                        extensions << ext
                                    end
                                end
                            end
                        end
                        # Build out font hash
                        font = {
                            "#{family}" => {
                                "path" => path,
                                "extensions" => extensions,
                                "weights" => variations
                            }
                        }
                        # Merge into fonts hash
                        fonts = fonts.merge(font)
                        # Set Sass variable for font family
                        set_sass_var(family)
                    end
                end
            end
            # Return hash of all fonts
            return fonts
        end

        # Assert types
        assert_type font_dir, :String, :font_dir

        # Define root path up to current working directory
        root = Dir.pwd

        # Clean up font_dir
        font_dir = unquote(font_dir).to_s

        # Define dir path
        dir_path = root
        dir_path += font_dir

        # Normalize windows path
        dir_path = Sass::Util.pathname(dir_path)

        # Create Sass variable for font path
        set_sass_var(font_dir, 'graphite_font_dir')

        # Font naming convention : name-weight[-variant].extension
        fonts = {
            "legacy-ie" => legacy_ie,
        }

        # Get all fonts in dir
        f = dir_has_fonts?(dir_path)

        # Merge results into fonts
        fonts = fonts.merge(f)

        # Convert hash to map, return
        Sass::Script::Value::Map.new(SassyHash[fonts])
    end
    declare :Graphite, [:font_dir]
end
