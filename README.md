Mobility
========

Installation
------------

Add this line to your application's Gemfile:

```ruby
source 'https://rubygems.pkg.github.com/ramp106' do
  gem 'mobility', '~> 1.3.0.omr'
end


```

### Description

This is a mobility fork to allow jsonb column to be used as a backend. This is a temporary solution until the PR is merged into the main gem.
The change is in the `Mobility::Backends::Json` class, where the `read` method is changed to return the value of the column directly, instead of the hash.
and to support mysql as database.

The mobility config is :

```diff

Mobility.configure do
  plugins do
    backend :json

    reader
    writer
    locale_accessors
    fallbacks
    active_record
    dirty
    query
    ransack
  end
end

```

### Manual release

Can't be release with gh actions because is a public fork and only private forks can be released with gh actions. 

To release a new version, you need to:

1. Bump the version in the `lib/mobility/version.rb` file.
2. Commit the changes.
3. run script in terminal
```ruby
  rm mobility-*.gem
  mkdir -p ~/.gem
  touch ~/.gem/credentials
  chmod 600 ~/.gem/credentials
  printf -- "---\n:github: Bearer ${{ GITHUB_TOKEN }}\n" > ~/.gem/credentials
  gem build mobility
  gem push mobility-*.gem --key github --host https://rubygems.pkg.github.com/ramp106
```

GITHUB_TOKEN must have write access to the repo.