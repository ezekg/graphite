require './lib/Graphite'

Gem::Specification.new do |s|
    # Release Specific Information
    s.version = Graphite::VERSION
    s.date = Graphite::DATE

    # Gem Details
    s.name = "Graphite"
    s.rubyforge_project = "graphite"
    s.licenses = ['MIT']
    s.authors = ["Ezekiel Gabrielse"]
    s.email = ["ezekg@yahoo.com"]
    s.homepage = "https://github.com/ezekg/Graphite/"

    # Project Description
    s.summary = %q{Graphite imports a folder of fonts and automagically outputs their font-face directives.}
    s.description = %q{Graphite imports a folder of fonts and automagically outputs font-face directives for each font into your stylesheet.}

    # Library Files
    s.files += Dir.glob("lib/**/*.*")

    # Sass Files
    s.files += Dir.glob("stylesheets/**/*.*")

    # Add to require
    s.require_paths = ["lib", "stylesheets"]

    # Other files
    s.files += ["README.md"]

    # Gem Bookkeeping
    s.required_rubygems_version = ">= 1.3.6"
    s.rubygems_version = %q{1.3.6}

    # Gems Dependencies
    s.add_dependency("sass", [">=3.3.0"])
    s.add_dependency("compass", [">= 0.12.1"])
    s.add_dependency("sassy_hash", [">=0.0.6"])
end
