# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{active_record_defaults}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["C. Jason Harrelson (midas)"]
  s.date = %q{2009-08-09}
  s.description = %q{}
  s.email = ["jason@lookforwardenterprises.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc"]
  s.files = ["History.txt", "MIT-LICENSE", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "lib/active_record/defaults.rb", "lib/active_record_defaults.rb", "script/console", "script/destroy", "script/generate", "test/abstract_unit.rb", "test/database.yml", "test/fixtures/address.rb", "test/fixtures/group.rb", "test/fixtures/people.yml", "test/fixtures/person.rb", "test/fixtures/person_with_default_school.rb", "test/fixtures/person_with_default_school_id.rb", "test/fixtures/school.rb", "test/fixtures/schools.yml", "test/schema.rb", "test/test_active_record_defaults.rb", "test/test_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{If you find this plugin useful, please consider a donation to show your support!}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{active_record_defaults}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{}
  s.test_files = ["test/test_active_record_defaults.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<newgem>, [">= 1.3.0"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<newgem>, [">= 1.3.0"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<newgem>, [">= 1.3.0"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
