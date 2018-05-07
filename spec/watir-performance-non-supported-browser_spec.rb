uname=`uname -s`.chomp
if uname == 'Darwin'
  describe 'WatirPerformance-NonSupportedBrowser' do
    let!(:b) { @b }

    before(:all) do
      @b ||= Watir::Browser.new :safari
    end

    after(:all) do
      @b.close
    end

    pending 'should raise an error when a non supported' \
            'browser is encountered' do

      b.goto 'google.com'
      error = 'Could not collect performance metrics from your current browser'\
              '. Please ensure the browser you are using supports collecting ' \
              'performance metrics.'
      expect(-> { b.performance }).to raise_error RuntimeError, error
    end

    pending 'should return false for supported"'do
      b.goto 'google.com'
      expect(b).not_to be_performance_supported
    end

    pending 'should not support performance as block' do
      b.goto 'google.com'
      b.with_performance { |performance| expect(performance).not_to be_nil }
    end
  end
end
