# frozen_string_literal: true

require_relative "lib/S3FileManager/version"

Gem::Specification.new do |spec|
  spec.name = "S3FileManager"
  spec.version = S3FileManager::VERSION
  spec.authors = ["Kleytonmr"]
  spec.email = ["kleytonmatosramos@gmail.com"]

  spec.summary = "WIP Write a short summary, because RubyGems requires one."
  spec.description = "WIP Write a longer description or delete this line."
  spec.homepage = "https://github.com/kleytonmr/S3FileManager"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir["lib/**/*", "LICENSE.txt", "README.md", "CHANGELOG.md"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "aws-sdk-s3", "~> 1.5.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
