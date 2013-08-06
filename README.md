# NSConfig

Simple per-environment configuration management.

## Example

Say that you have these YAML files: 

```
config_example/00-defaults.yaml
config_example/01-development.yaml
config_example/01-production.yaml
```

The first one defines defaults common to every environment,
the remaining two override some values as needed (using YAML inheritance/hash merge).
Keys for the resulting hash need to correspond to your environments' names.

```
$ cat config_example/*
DEFAULTS: &DEFAULTS
  key1: 'default value 1'
  key2: 'default value 2'
development:
  <<: *DEFAULTS
  key2: 'overridden value 2 in development'
production:
  <<: *DEFAULTS
  key1: 'overridden value 1 in production'
```

The module that extends NSConfig can be used like a hash whose keys represent the actual config data:

```ruby
require 'nsconfig'

module ConfigTest
    extend NSConfig

    # Where to look for config YAML files
    self.config_path= File.expand_path(File.dirname(__FILE__), 'config_example')

    # Config data gets automatically loaded...
    puts self[:environment]
    puts self[:key1]
    puts ConfigTest[:key2] # This syntax obviously also works
end
```

The above code yields:

```
$ ruby example.rb 
development
default value 1
overridden value 2 in development
```

Or:

```
$ CONFIGTEST_ENV='production' ruby example.rb    # RACK_ENV would've worked too
production
overridden value 1 in production
default value 2
```
