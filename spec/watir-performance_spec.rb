browsers = if ENV['SAUCELABS'] == 'true'
             %i[edge internet_explorer]
           else
             %i[chrome firefox]
           end

browsers.each do |browser|
  describe "WatirPerformance-#{browser.upcase}" do
    let!(:b) { @b }

    before(:all) do
      opt = case browser
            when :chrome
              Selenium::WebDriver::Chrome::Options.new(args: %w[no-sandbox
                                                                headless
                                                                disable-gpu])
            when :firefox
              Selenium::WebDriver::Firefox::Options.new(args: %w[no-sandbox
                                                                 headless
                                                                 disable-gpu])
            when :edge
              Selenium::WebDriver::Remote::Capabilities.edge
              opt['platform'] = 'Windows 10'
              opt['version'] = '17.17134'
              opt['build'] = ENV['TRAVIS_JOB_NUMBER']
            when :internet_explorer
              Selenium::WebDriver::Remote::Capabilities.internet_explorer(
                platform: 'Windows 10', version: '11.103',
                device: 'Desktop', build: ENV['TRAVIS_JOB_NUMBER']
              )
            end

      @b ||= if ENV['SAUCELABS'] == 'true'
               test_url = "http://#{ENV['SAUCE_USERNAME']}:#{ENV['SAUCE_ACCESS_KEY']}@ondemand.saucelabs.com/wd/hub"
               Watir::Browser.new(browser, url: test_url, options: opt)
             else
               Watir::Browser.new(browser, options: opt)
             end
    end

    after(:all) do
      @b.close
    end

    it 'should open get performance metrics from the browser' do
      b.goto 'google.com'
      expect(b.performance).to be_an_instance_of(OpenStruct)
    end

    it 'should get summary data from the performance metrics' do
      # Summary metrics based on Processing Model of NavigationTiming
      # http://w3c-test.org/webperf/specs/NavigationTiming/#processing-model
      included = %i[app_cache dns tcp_connection request response dom_processing]
      included.each { |item| expect(b.performance.summary).to include(item) }
    end

    it 'should get the summary metrics such as Response Time, TTLB and TTFB' do
      # time_to_first_byte aka "server time"
      # time_to_last_byte aka "network + server time"
      included = %i[time_to_first_byte time_to_last_byte response_time]
      included.each { |item| expect(b.performance.summary).to include(item) }
    end

    it 'should return true for supported' do
      b.goto 'google.com'
      expect(b).to be_performance_supported
    end

    it 'should support performance as block' do
      b.goto 'google.com'
      b.with_performance { |performance| expect(performance).not_to be_nil }
    end
  end
end
