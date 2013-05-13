require 'nokogiri'

class SpiderController
  def initalize()
    xml_doc = Nokogiri::Slop(File.read("SpiderConfig.xml"))
    @maximum_depth = xml_doc.configuration.setting("[id='MaximumDepth']").content
    @excluded_file_types = xml_doc.configuration.setting("[id='ExcludedFileTypes']").content.split('|')
    @excluded_domains = xml_doc.configuration.setting("[id='ExcludedDomains']").content.split(/,|\s|\r|\n/).reject(&:empty?)
  end
end