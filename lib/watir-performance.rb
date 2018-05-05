require 'ostruct'

module Watir
  # Adds helper for window.performance to Watir::Browser.
  # @see http://dev.w3.org/2006/webapi/WebTiming/
  class PerformanceHelper
    def initialize(data)
      @data = data
      @hash = {}
    end

    def munge
      OpenStruct.new(summarized_hash(data_to_hash))
    end

    def data_to_hash
      @data.each_key do |key|
        next if key == '__fxdriver_unwrapped'
        @hash[key.to_sym] = {}
        next unless @data[key].respond_to? :each
        @data[key].each do |k, v|
          next if k == '__fxdriver_unwrapped'
          @hash[key.to_sym][underscored(k).to_sym] = v
        end
      end
      @hash
    end

    def summarized_hash(hash)
      hash[:summary] = {}
      hash[:summary][:redirect] = hash[:timing][:redirect_end] -
        hash[:timing][:redirect_start] if hash[:timing][:redirect_end] > 0
      hash[:summary][:app_cache] = hash[:timing][:domain_lookup_start] -
        hash[:timing][:fetch_start] if hash[:timing][:fetch_start] > 0
      hash[:summary][:dns] = hash[:timing][:domain_lookup_end] -
        hash[:timing][:domain_lookup_start] if hash[:timing][:domain_lookup_start] > 0
      hash[:summary][:tcp_connection] = hash[:timing][:connect_end] -
        hash[:timing][:connect_start] if hash[:timing][:connect_start] > 0
      hash[:summary][:tcp_connection_secure] = hash[:timing][:connect_end] -
        hash[:timing][:secure_connection_start] if
          ((hash[:timing][:secure_connection_start] != nil) and
           (hash[:timing][:secure_connection_start] > 0))
      hash[:summary][:request] = hash[:timing][:response_start] -
        hash[:timing][:request_start] if hash[:timing][:request_start] > 0
      hash[:summary][:response] = hash[:timing][:response_end] -
        hash[:timing][:response_start] if hash[:timing][:response_start] > 0
      hash[:summary][:dom_processing] = hash[:timing][:dom_content_loaded_event_start] -
        hash[:timing][:dom_loading] if hash[:timing][:dom_loading] > 0
      hash[:summary][:time_to_first_byte] = hash[:timing][:response_start] -
        hash[:timing][:domain_lookup_start] if hash[:timing][:domain_lookup_start] > 0
      hash[:summary][:time_to_last_byte] = hash[:timing][:response_end] -
        hash[:timing][:domain_lookup_start] if hash[:timing][:domain_lookup_start] > 0
      hash[:summary][:response_time] = latest_timestamp(hash) - earliest_timestamp(hash)
      hash # Return
    end

    private

    def underscored(camel_cased_word)
      word = camel_cased_word.to_s.dup
      word.gsub!(/::/, '/')
      word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
      word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
      word.tr!("-", "_")
      word.downcase!
      word
    end

    def earliest_timestamp(hash)
      return hash[:timing][:navigation_start] if hash[:timing][:navigation_start] > 0
      return hash[:timing][:redirect_start] if hash[:timing][:redirect_start] > 0
      return hash[:timing][:redirect_end] if hash[:timing][:redirect_end] > 0
      return hash[:timing][:fetch_start] if hash[:timing][:fetch_start] > 0
    end

    def latest_timestamp(hash)
      return hash[:timing][:load_event_end] if hash[:timing][:load_event_end] > 0
      return hash[:timing][:load_event_start] if hash[:timing][:load_event_start] > 0
      return hash[:timing][:dom_complete] if hash[:timing][:dom_complete] > 0
      return hash[:timing][:dom_content_loaded_event_end] if hash[:timing][:dom_content_loaded_event_end] > 0
      return hash[:timing][:dom_content_loaded_event_start] if hash[:timing][:dom_content_loaded_event_start] > 0
      return hash[:timing][:dom_interactive] if hash[:timing][:dom_interactive] > 0
      return hash[:timing][:response_end] if hash[:timing][:response_end] > 0
    end
  end

  PERFORMS = 'return window.performance || window.webkitPerformance || '\
             'window.mozPerformance || window.msPerformance;'.freeze
  ERRORMESSAGE = 'Could not collect performance metrics from your current ' \
                'browser. Please ensure the browser you are using supports ' \
                'collecting performance metrics.'.freeze

  # Extending Watir Browser
  # See Documentation Here
  # https://www.rubydoc.info/gems/watir/
  class Browser
    def performance
      data = case driver.browser
             when :internet_explorer
               script = 'return JSON.stringify(window.performance.toJSON());'
               cmd = driver.execute_script(script)
               ::Object::JSON.parse(cmd)
             else
               driver.execute_script(PERFORMS)
             end
      raise ERRORMESSAGE if data.nil?
      PerformanceHelper.new(data).munge
    end

    def performance_supported?
      driver.execute_script(PERFORMS)
    end
    alias performance_data performance_supported?

    def with_performance
      yield PerformanceHelper.new(performance_data).munge if performance_supported?
    end
  end
end
