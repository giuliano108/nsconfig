$LOAD_PATH.unshift('lib')
require 'nsconfig'

module ConfigTest
    extend NSConfig

    # Where to look for config YAML files
    self.config_path= File.expand_path(File.dirname(__FILE__), 'config_example')

    # Config data gets automatically loaded...
    puts self[:environment]
    puts self[:key1]
    puts ConfigTest[:key2] # You can use the module name, if you prefer
end
