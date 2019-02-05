class PerformanceReader
  ## Only send Browser Object Through
  def self.response_time(browser)
    no_safari = 'No Safari Performance Support'
    return no_safari if browser.name == :Safari || browser.name == :safari

    perf_summary(browser, :response_time)
  end

  ## consider consolidation with other functions, if keys empty return
  def self.summary(browser)
    browser.performance.summary
  end

  def self.navigation(browser)
    browser.performance.navigation
  end

  def self.memory(browser)
    browser.performance.memory
  end

  def self.timing(browser)
    browser.performance.timing
  end

  # Performance Summary: Keys
  #
  # :redirect, :app_cache, :dns, :tcp_connection, :tcp_connection_secure,
  # :request, :response, :dom_processing, :response_time,
  # :time_to_first_byte, :time_to_last_byte
  def self.perf_summary(browser, keys)
    if keys.class == Array
      perf_summary_mutli_keys(keys)
    else
      perf_summary_str(keys.to_s.tr('_', ' ').upcase,
                       browser.performance.summary[keys])
    end
  end

  # Performance Summary: Multi_Keys w/String
  #
  # Loops through an Array of Keys producing
  # key: timing 'seconds' strings
  def self.perf_summary_mutli_keys(keys)
    summary = []
    keys.each do |k|
      key_time = browser.performance.summary[k[:key]]
      key_str = k[:key].to_s.tr('_', ' ').upcase
      summary << perf_summary_str(key_str, key_time)
    end
    summary
  end

  # Performance Summary: Keys String
  #
  # Creates Performance String with given
  # key and time / 1000 to produce seconds
  def self.perf_summary_str(key, time)
    "#{key}: #{time / 1000} seconds"
  end

  # Performance Memory: Keys
  #
  # :total_js_heap_size, :js_heap_size_limit, :used_js_heap_size
  def self.perf_memory(browser, keys)
    if keys.class == Array
      perf_memory_multi_keys(keys)
    else
      perf_memory_str(keys.to_s.tr('_', ' ').upcase,
                      browser.performance.memory[keys] / 1_048_576)
    end
  end

  # Performance Memory: Multi_Keys w/String
  #
  # Loops through an Array of Keys producing
  # key: memory 'mb' strings
  def self.perf_memory_multi_keys(keys)
    memory = []
    keys.each do |k|
      key_time = browser.performance.memory[k[:key]] / 1_048_576
      key_str = k[:key].to_s.tr('_', ' ').upcase
      memory << perf_memory_str(key_str, key_time)
    end
    memory
  end

  # Performance Memory: Key String
  #
  # Creates Performance String with given
  # key and memory in megabites
  def self.perf_memory_str(key, memory)
    "#{key}: #{memory} MB"
  end

  # Performance Navigation: Keys
  #
  # :type, :type_back_forward, :redirect_count, :type_reserved,
  # :type_navigate, :type_reload
  def self.perf_nav(browser, keys)
    perf_nav = []
    if keys.class == Array
      perf_nav << perf_nav_multi_keys(keys)
    else
      load_nav = browser.performance.navigation[keys]
      perf_nav << "#{keys.to_s.tr('_', ' ').upcase}: #{load_nav}"
    end
    perf_nav
  end

  # Performance Nav: Multi_Keys w/String
  #
  # Loops through an Array of Keys producing
  # key: nav info string
  def self.perf_nav_multi_keys(keys)
    nav = []
    keys.each do |k|
      key_time = browser.performance.navigation[k[:key]]
      key_str = k[:key].to_s.tr('_', ' ').upcase
      nav << perf_memory_str(key_str, key_time).delete(' MB')
    end
    nav
  end

  # Performance Timing: Keys
  #
  # :domain_lookup_start, :load_event_end, :connect_end, :response_end,
  # :dom_loading, :navigation_start, :redirect_end, :unload_event_start,
  # :secure_connection_start, :connect_start, :dom_content_loaded_event_end,
  # :domain_lookup_end, :dom_interactive, :load_event_start, :request_start,
  # :response_start, :dom_complete, :fetch_start,
  # :dom_content_loaded_event_start, :redirect_start, :unload_event_end
  def self.perf_timing(browser, keys)
    perf_timing = []
    if keys.class == Array
      perf_timing << perf_time_multi_keys(keys)
    else
      key_time = browser.performance.timing[keys]
      perf_timing << perf_time_str(key_time)
    end
    perf_timing
  end

  # Performance Time: Multi_Keys w/String
  #
  # Loops through an Array of Keys producing
  # key: time info string
  def self.perf_time_multi_keys(keys)
    timing = []
    keys.each do |k|
      key_time = browser.performance.timing[k[:key]]
      timing << perf_time_str(key_time)
    end
    timing
  end

  # Performance Time: Key String
  #
  # Creates Performance String with given
  # Epoch Time in seconds
  def self.perf_time_str(key_time)
    "Time: #{key_time} seconds"
  end
end
