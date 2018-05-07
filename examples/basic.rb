require 'watir'
require 'watir-performance'
b = Watir::Browser.new :chrome
b.goto "altentee.com"
p b.performance
b.close
