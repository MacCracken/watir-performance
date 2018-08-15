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
      timing = hash[:timing]
      hash[:summary][:redirect] = redirect_timer(timing)
      hash[:summary][:app_cache] = app_cache(timing)
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
      hash
    end

    private

    def underscored(camel_cased_word)
      word = camel_cased_word.to_s.dup
      word.gsub!(/::/, '/')
      word.gsub!(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      word.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
      word.tr!('-', '_')
      word.downcase!
      word
    end

    def timer_checks(timers, hash)
      timers.each do |timer|
        return hash[:timing][timer] if hash[:timing][timer] > 0
      end
    end

    def timer_summerize(t_start, t_end, standard, hash)
      case standard
      when true
        hash[t_end] - hash[t_start] if hash[t_end] > 0
      else
        hash[t_end] - hash[t_start] if hash[t_start] > 0
      end
    end

    def redirect_timer(hash)
      hash[:redirect_end] - hash[:redirect_start] if hash[:redirect_end] > 0
    end

    def app_cache(hash)
      hash[:domain_lookup_start] - hash[:fetch_start] if hash[:fetch_start] > 0
    end

    def earliest_timestamp(hash)
      timers = %i[navigation_start redirect_start redirect_end fetch_start]
      timer_checks(timers, hash)
    end

    def latest_timestamp(hash)
      timers = %i[load_event_end load_event_start dom_complete
                  dom_content_loaded_event_end dom_content_loaded_event_start
                  dom_interactive response_end]
      timer_checks(timers, hash)
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
