require "sass"
require "cgi/core"

module Graphite
    class Importer < Sass::Importers::Filesystem

        FONT_EXTENSIONS = [
            "eot",
            "woff2",
            "woff",
            "otf",
            "ttf",
            "svg"
        ]

        FONT_WEIGHTS = [
            "100",
            "200",
            "300",
            "400",
            "500",
            "600",
            "700",
            "800",
            "900"
        ]

        FONT_STYLES = [
            "normal",
            "italic",
            "oblique"
        ]

        def find(name, options)
            if options[:filename]
                if name.include? "?styles="
                    find_fonts(name, options[:filename], options)
                else
                    super(name, options)
                end
            else
                nil
            end
        end

        def key(name, options)
             ["Graphite:" + File.dirname(File.expand_path(name)), File.basename(name)]
        end

        def to_s
            "Graphite::Importer"
        end

        protected

        def find_fonts(name, base, options)

            # Directory path
            @font_family_path = strip_params(name)

            # Get font name
            @font_family_name = File.basename(@font_family_path)

            # Get params from URI
            @font_family_styles = get_params(name)

            # Hash of fonts
            @fonts = {
                "#{@font_family_name}" => {
                    "path" => @font_family_path,
                    "styles" => {}
                }
            }

            # Make sure path exists, else throw SyntaxError
            if File.exists?(@font_family_path)
                # Now loop through each weight and find match with ext
                @font_family_styles.each do |style|

                    # Keep array of matching extensions
                    extensions = []

                    # Empty path for font file
                    path = ""

                    # Loop over each extension
                    FONT_EXTENSIONS.each do |ext|
                        # Check if the file exists with passed param
                        if File.exists?("#{@font_family_path}/#{@font_family_name}-#{style}.#{ext}")
                            # Save ext
                            extensions << ext unless extensions.include? ext
                            # Grab path
                            path = "#{@font_family_path}/#{@font_family_name}-#{style}"
                        end
                    end

                    # Create hash of style and extensions
                    font = {
                        "#{style}" => {
                            "path" => path,
                            "extensions" => extensions,
                            "weight" => get_weight(style),
                            "style" => get_style(style) || "normal"
                        }
                    }

                    # Merge into main fonts hash
                    unless extensions.empty?
                        @fonts[@font_family_name]["styles"].merge!(font)
                    else
                        raise ArgumentError, "Font family contained no valid fonts for: #{@font_family_name}-#{style}. Import failed."
                    end
                end
            else
                raise ArgumentError, "Font family to import could not be found, or it's unreadable: #{@font_family_path}."
            end

            unless @fonts.nil?
                Sass::Engine.new(output_fonts(@fonts), options.merge(
                    :filename => Pathname.new(base).to_s,
                    :importer => self,
                    :syntax => :scss
                ))
            end
        end

        def get_weight(filename)
            FONT_WEIGHTS.any? do |weight|
                if filename.include? weight
                    return weight
                end
            end
        end

        def get_style(filename)
            FONT_STYLES.any? do |style|
                if filename.include? style
                    return style
                end
            end
        end

        def get_params(uri)
            CGI.parse(URI.parse(uri).query)["styles"].to_s[2..-3].split(",")
        end

        def strip_params(name)
            name.include?("?") ? name[0..name.rindex("?")-1] : name
        end

        private

        def output_fonts(fonts)
            content = ""

            fonts.each do |font, keys|
                keys["styles"].each do |style, atts|
                    content += "@font-face {\n"

                    # Font attributes
                    content += "\tfont-family: \"#{font}\";\n"
                    content += "\tfont-weight: #{atts["weight"]};\n"
                    content += "\tfont-style: #{atts["style"]};\n"

                    # Include this for IE9
                    if atts["extensions"].include? "eot"
                        content += "\tsrc: url('../#{atts["path"]}.eot');\n"
                    end

                    # Create array of src urls
                    src = []

                    # Push extensions to src arr if match
                    if atts["extensions"].include? "eot"
                        src << "url('../#{atts["path"]}.eot?#iefix') format('embedded-opentype')"
                    end
                    if atts["extensions"].include? "woff2"
                        src << "url('../#{atts["path"]}.woff2') format('woff2')"
                    end
                    if atts["extensions"].include? "woff"
                        src << "url('../#{atts["path"]}.woff') format('woff')"
                    end
                    if atts["extensions"].include? "otf"
                        src << "url('../#{atts["path"]}.otf') format('opentype')"
                    end
                    if atts["extensions"].include? "ttf"
                        src << "url('../#{atts["path"]}.ttf') format('truetype')"
                    end
                    if atts["extensions"].include? "svg"
                        src << "url('../#{atts["path"]}.svg##{font}') format('svg')"
                    end

                    # Join src together
                    unless src.empty?
                        content += "\tsrc: #{src.join(",")}\n;"
                    else
                        raise ArgumentError, "Font family contained no valid font extensions: #{font}. Import failed."
                    end

                    content += "}\n"
                end
            end

            content
        end
    end
end
