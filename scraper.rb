#!/bin/env ruby
# encoding: utf-8

require 'colorize'
require 'csv'
require 'scraperwiki'
require 'pry'

# require 'open-uri/cached'
# OpenURI::Cache.cache_path = '.cache'

def reprocess_csv(file)
  raw = open(file).read.force_encoding("UTF-8")
  csv = CSV.parse(raw, headers: true, header_converters: :symbol)
  csv.each do |row|
    data = row.to_hash.each { |k, v| v = v.to_s.gsub(/[[:space:]]+/, ' ').strip }
    data[:area_id] = data[:area].downcase
    data[:gender] = data[:gender].downcase
    data[:term] = '2013'
    %i(num).each { |i| data.delete i }
    ScraperWiki.save_sqlite([:name, :name, :term], data)
  end
end

csv_data = reprocess_csv('https://docs.google.com/spreadsheets/d/1scGGzyv7jN2TtDfZEg5oIrsGS_d844gC9t6-1mBuIr0/export?format=csv&gid=1540758946')
