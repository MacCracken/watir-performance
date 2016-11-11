require 'watir-performance'
require 'watir'
b = Watir::Browser.new :chrome
b.goto "altentee.com"
p b.performance
b.close
