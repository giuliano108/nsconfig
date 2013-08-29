require 'yaml'
require 'nsconfig/version'

module NSConfig
    attr_accessor :config_path

    def self.extended(base)
        base.instance_variable_set :@config_path, './'
        base.instance_variable_set :@config, nil
    end

    def []=(key, value)
        @config[key.to_sym] = value
    end

    def get_environment
        (@config && self[:environment]) || ENV["#{self.to_s.upcase}_ENV"] || ENV['RACK_ENV'] || 'development'
    end
    
    # taken from http://devblog.avdi.org/2009/07/14/recursively-symbolize-keys/
    def symbolize_keys(hash)
        hash.inject({}){|result, (key, value)|
            new_key = case key
                      when String then key.to_sym
                      else key
                      end
        new_value = case value
                    when Hash then symbolize_keys(value)
                    else value
                    end
        result[new_key] = new_value
        result
        }
    end

    # idea taken from here: http://www.railstips.org/blog/archives/2009/11/10/config-so-simple-your-mama-could-use-it/
    def load_config
        env = get_environment
        config_path = @config_path
        raw_config = ''
        begin
            Dir[config_path + '/*.yaml'].sort.each { |file| raw_config << IO.read(file) << "\n"}
        rescue
            raise 'Cannot load config, maybe wrong environment?'
        end
        @config = symbolize_keys(YAML.load(raw_config)[env] || {})
        raise 'Config is empty, maybe wrong environment?' unless @config and !@config.empty?
        self[:environment] = env
    end

    def [](key)
        load_config unless @config
        @config[key]
    end
end
