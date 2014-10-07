require './lib/graphite'

Gem::Specification.new do |spec|
    spec.version = Graphite::VERSION
    spec.name = "graphite-sass"
    spec.rubyforge_project = "graphite"
    spec.licenses = ['MIT']
    spec.authors = ["Ezekiel Gabrielse"]
    spec.email = ["ezekg@yahoo.com"]
    spec.homepage = "https://github.com/ezekg/Graphite/"
    spec.summary = %q{Graphite allows you to import fonts into a syntax similar to Google Fonts. Quick and simple.}
    spec.description = %q{Graphite allows you to import fonts into your stylesheet in a syntax similar to Google Fonts. Quick and simple.}
    spec.files = Dir.glob("lib/**/*.*")
    spec.files += ["README.md"]
    spec.require_paths = ["lib"]
    spec.add_dependency("sass", [">= 3.3.0"])
end
