require_relative "Spider"
require "nokogiri"

Spider.new().go("http://www.net-cafe.hu/fantasy.php?ct=160")