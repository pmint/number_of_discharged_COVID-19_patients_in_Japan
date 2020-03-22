#!/usr/bin/env ruby

# A number of discharged COVID-19 patients in Japan from NHK(Japan Broadcasting Corporation)
# from ScraperWiki

require 'scraperwiki'
require 'nokogiri'

url = "https://www3.nhk.or.jp/news/special/coronavirus/module/mod_site-info.html"

require 'scraperwiki'
require 'mechanize'

agent = Mechanize.new
page = agent.get(url)

page.at('.total tbody-td:nth-of-type(4)') =~ /(\d+)人/
p $1
ScraperWiki.save_sqlite(['id'], {
    'id' => Time.now.to_i,
    'discharged' => $1,
    'time_blob' => Time.now.getlocal('+09:00').to_s
})

# # Write out to the sqlite database using scraperwiki library
# ScraperWiki.save_sqlite(["name"], {"name" => "susan", "occupation" => "software developer"})

# # An arbitrary query against the database
# ScraperWiki.select("* from data where 'name'='peter'")
