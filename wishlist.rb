#!/usr/bin/ruby

# Copyright (c) 2008 Simone Dall'Angelo
# 
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#

require 'rubygems'
require 'yaml'

# This is the place where the script stores data
FILE_PATH = './wishlist_data.yml'

begin
  if File.exists?(FILE_PATH)
    @items = File.open(FILE_PATH) { |yf| YAML::load( yf ) }
  else
    @items = Array.new
  end
  case ARGV[0]
  when 'add':
    if ARGV[1]
      @items << [ARGV[1], (ARGV[2] || nil), (ARGV[3] || nil)]
      puts 'Item added'
    else
      puts 'Missing argument(s)'
    end
  when 'rm':
    if ARGV[1]
      @items.delete_at((ARGV[1].to_i - 1))
      puts "Item #{ARGV[1].to_i} deleted"
    else
      puts 'Missing argument(s)'
    end
  when 'ls':
    puts 'Wishlist:'
    if @items.any?
      @items.each_with_index do |item, index|
        print " #{index + 1} - #{item[0]}"
        print " (#{item[1]})" if item[1]
        print "\n\t#{item[2]}" if item[2]
        print "\n"
      end
    else
      puts "No items in your wishlist."
    end
  else
    puts "Wishlist usage:"
    puts "Add an item:\n\twishlist add <ItemName> <ItemPrice (optional)> <ItemUrl (optional)>"
    puts "Remove an item:\n\twishlist rm <ItemID>"
    puts "List items:\n\twishlist ls"
  end
  File.open(FILE_PATH, 'w' ) do |out|
    YAML.dump( @items, out )
  end
  
end