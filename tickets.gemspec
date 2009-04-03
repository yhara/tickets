# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tickets}
  s.version = "0.0.9.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Yutaka HARA"]
  s.date = %q{2009-04-02}
  s.description = %q{}
  s.email = %q{yutaka.hara+github at gmail.com}
  s.extra_rdoc_files = ["README"]
  s.files = ["README", "TODO", "db/migrate/001_create_tickets.rb", "db/migrate/002_add_deleted_to_tickets.rb", "model/ticket.rb", "public/js/builder.js", "public/js/controls.js", "public/js/dragdrop.js", "public/js/effects.js", "public/js/scriptaculous.js", "public/js/slider.js", "public/js/sound.js", "public/js/unittest.js", "public/scm/main.scm", "public/scm/ticket.scm", "server.rb", "view/index.xhtml", "public/biwascheme/MIT-LICENSE.txt", "public/biwascheme/README", "public/biwascheme/lib/biwascheme.js", "public/biwascheme/lib/extra_lib.js", "public/biwascheme/lib/io.js", "public/biwascheme/lib/prototype.js", "public/biwascheme/lib/r6rs_lib.js", "public/biwascheme/lib/stackbase.js", "public/biwascheme/lib/webscheme_lib.js"]
  s.homepage = %q{http://github.com/yhara/tickets/}
  s.rdoc_options = ["--title", "tickets documentation", "--charset", "utf-8", "--opname", "index.html", "--line-numbers", "--main", "README", "--inline-source", "--exclude", "^(examples|extras)/"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ramaze>, [">= 0"])
    else
      s.add_dependency(%q<ramaze>, [">= 0"])
    end
  else
    s.add_dependency(%q<ramaze>, [">= 0"])
  end
end
