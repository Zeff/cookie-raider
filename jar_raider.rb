#!usr/bin/env ruby

require 'selenium-webdriver'
require 'csv'

# def wait(seconds)     
#   Selenium::WebDriver::Wait.new(timeout: seconds).until { yield }
# end

stash = "cookie_stash_test.csv"

# def steal_cookies(driver, custio_url, csv)
#   driver = Selenium::WebDriver.for :firefox
#   driver.get custio_url
#   driver.manage.all_cookies.each do |cookie|
#     puts "#{cookie[:name]}: #{cookie[:value]}"
#     row = [custio_url]
#     row << cookie[:name]
#     row << cookie[:value]
#     csv << row
#     row.clear
#   end
# end

if !File.exist? stash
  CSV.open(stash, "wb") do |csv|
    headers = ['target', 'name', 'value', 'path', 'domain', 'expires', 'secure']
    csv << headers
  end
end

CSV.open(stash, "ab") do |csv|
  while input = ARGF.gets
    input.each_line do |custio_url|
      driver = Selenium::WebDriver.for :firefox
      driver.get custio_url
      driver.manage.all_cookies.each do |cookie|
        row = [custio_url]
        cookie.each_key do |key|
          row << cookie[key]
        end
        csv << row
        row.clear
      end
      driver.quit
    end
  end
end
