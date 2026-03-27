# frozen_string_literal: true

require_relative "lib/Go_Game_Gem/version"

Gem::Specification.new do |spec|
  spec.name = "Go_Game_Gem"
  spec.version = GoGameGem::VERSION
  spec.authors = ["Tiverkaeva Eva", "Vlasova Emma", "Тухтеева Елена"]
  spec.email = ["tiverkaevaeva2005@mail.ru", "vlasova.emma0004@mail.ru", "tuhteeeva59@gmail.com" ]

  spec.summary = "Мини-игры для отдыха от го: виселица, крестики-нолики, судоку"
  spec.description = "Коллекция мини-игр (виселица, крестики-нолики, судоку), разработанная как дополнение к библиотеке для игры в го. Позволяет отвлечься и переключить внимание между партиями или задачами"
  spec.homepage = "https://github.com/evchonok/Ruby_Go_Game_Gem.git"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"
  spec.metadata["allowed_push_host"] = "'https://example.com'"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/evchonok/Ruby_Go_Game_Gem.git"
  spec.metadata["changelog_uri"] = "https://github.com/evchonok/Ruby_Go_Game_Gem/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore test/ .github/])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
