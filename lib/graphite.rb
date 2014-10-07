require 'sass'
require_relative "graphite/version"
require_relative "graphite/importer"
require_relative "graphite/monkeypatch"

base_directory = File.expand_path(File.join(File.dirname(__FILE__), '..'))
graphite_stylesheets_path = File.join(base_directory, 'stylesheets')

if (defined? Compass)
    Compass::Frameworks.register('graphite', :path => base_directory)
else
    ENV["SASS_PATH"] = [ENV["SASS_PATH"], graphite_stylesheets_path].compact.join(File::PATH_SEPARATOR)
end

module Graphite
    Sass::Script::Functions.send(:include, Graphite)
end
