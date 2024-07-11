$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your wagon's version:
require "hitobito_skv/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "hitobito_skv"
  s.version = HitobitoSkv::VERSION
  s.authors = ["Luca Brügger"]
  s.email = ["lbruegger@puzzle.ch"]
  s.summary = "Skv organization specific features"
  s.description = "Skv organization specific features"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile"]

  s.add_dependency "globalize-accessors"
end
