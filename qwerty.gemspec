# Gem::Specification.new do |s|
#   s.name = %q{qwerty}
#   s.version = "0.0.6"
#   s.date = %q{2017-09-27}
#   s.summary = %q{rails utilities dump}
#   s.author= %q{Possum}
#   s.files = [
#     "app/models/concerns/qwerty/loggable/base.rb",
#     "app/controllers/concerns/qwerty/api/loggable.rb"
#   ]
#   s.require_paths = [
#     "app/controllers",
#     "app/controllers/concerns",
#     "app/models",
#     "app/models/concerns"
#   ]
# end
#

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "qwerty/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "qwerty"
  s.version     = Qwerty::VERSION
  s.authors     = ["Possum"]
  s.email       = ["soh.zi.haur@gmail.com"]
  # s.homepage    = "TODO"
  s.summary     = "Possum Rails utilities dump"
  # s.description = "TODO: Description of Qwerty2."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.3"

  # s.add_development_dependency "sqlite3"
end
