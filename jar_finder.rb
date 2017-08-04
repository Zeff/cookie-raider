#!usr/bin/env ruby

require 'sitemap-parser'

sitemap = SitemapParser.new(ARGV[0])
url_list = sitemap.to_a

url_list.each do |url|
  begin
    $stdout.puts url
  rescue Errno::EPIPE
    exit(74)
  end
end
