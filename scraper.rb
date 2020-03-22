#!/usr/bin/env ruby

# A number of discharged COVID-19 patients in Japan from NHK(Japan Broadcasting Corporation)
# from ScraperWiki

require 'scraperwiki'
require 'nokogiri'

# Saving data:
# unique_keys = [ 'id' ]
# data = { 'id'=>12, 'name'=>'violet', 'age'=> 7 }
# ScraperWiki.save_sqlite(unique_keys, data)



url = "https://www3.nhk.or.jp/news/special/coronavirus/module/mod_site-info.html"

charset = nil
html = open(url) do |f|
  charset = f.charset
  f.read
end
doc = Nokogiri::HTML.parse(html, nil, charset)

doc.xpath('//*[@class="total"]//*[@class="tbody-td"][4]/text()').text =~ /(\d+)人/
p $1
ScraperWiki.save_sqlite(['id'], {
    'id' => Time.now.to_i,
    'number_blob' => $1,
    'time_blob' => Time.now.getlocal('+09:00').to_s
})


# This is a template for a Ruby scraper on morph.io (https://morph.io)
# including some code snippets below that you should find helpful

# require 'scraperwiki'
# require 'mechanize'
#
# agent = Mechanize.new
#
# # Read in a page
# page = agent.get("http://foo.com")
#
# # Find somehing on the page using css selectors
# p page.at('div.content')
#
# # Write out to the sqlite database using scraperwiki library
# ScraperWiki.save_sqlite(["name"], {"name" => "susan", "occupation" => "software developer"})
#
# # An arbitrary query against the database
# ScraperWiki.select("* from data where 'name'='peter'")

# You don't have to do things with the Mechanize or ScraperWiki libraries.
# You can use whatever gems you want: https://morph.io/documentation/ruby
# All that matters is that your final data is written to an SQLite database
# called "data.sqlite" in the current working directory which has at least a table
# called "data".
