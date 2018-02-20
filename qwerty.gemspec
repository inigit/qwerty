Gem::Specification.new do |s|
  s.name = %q{qwerty}
  s.version = "0.0.6"
  s.date = %q{2017-09-27}
  s.summary = %q{rails utilities dump}
  s.author= %q{Possum}
  s.files = [
    "app/models/concerns/qwerty/loggable/base.rb",
    "app/controllers/concerns/qwerty/api/loggable.rb"
  ]
  s.require_paths = [
    "app/controllers",
    "app/controllers/concerns",
    "app/models",
    "app/models/concerns"
  ]
end
