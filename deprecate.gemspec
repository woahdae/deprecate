# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{deprecate}
  s.version = "1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Woody Peterson"]
  s.autorequire = %q{deprecate}
  s.date = %q{2009-01-29}
  s.description = %q{Very simple gem/rails plugin to help with deprecating methods in your code}
  s.email = %q{woody.peterson@gmail.com}
  s.extra_rdoc_files = ["README.markdown", "LICENSE"]
  s.files = ["LICENSE", "README.markdown", "Rakefile", "lib/deprecate.rb", "spec/depricate_spec.rb", "spec/spec_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/woahdae/deprecate}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Very simple gem/rails plugin to help with deprecating methods in your code}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
