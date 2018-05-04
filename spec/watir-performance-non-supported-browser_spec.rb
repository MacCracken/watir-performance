require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "WatirPerformance-NonSupportedBrowser" do

  let!(:b) { @b }

  before(:all) do
    @b ||= Watir::Browser.new :safari
  end

  after(:all) do
    @b.close
  end

  pending "should raise an error when a non supported browser is encountered" do
    b.goto "google.com"
    expect(lambda { b.performance }).to raise_error RuntimeError, 'Could not collect performance metrics from your current browser. Please ensure the browser you are using supports collecting performance metrics.'
  end

  pending "should return false for supported" do
    b.goto "google.com"
    expect(b).not_to be_performance_supported
  end

  pending "should not support performance as block" do
    b.goto "google.com"
    b.with_performance {|performance| expect(performance).not_to be_nil }
  end
end
