#------------------------------------------------
# Requirements
#------------------------------------------------

# external dependencies
require 'tilt'
## Added since many files in this project require Nokogiri, and Nokogiri can't load without Rubygems having been activated
## - Nathan, Mon Mar 25 2024
require 'rubygems'
## When --enable-frozen-string-literal is activated, the rubyzip gem won't function properly
## - Nathan, Mon Mar 25 2024
if "".frozen?
  warn "\e[1;33mWarning: RubyZip doesn't work when frozen_string_literal is enabled\e[39;22m"
end

# odds & ends
require 'caracal/errors'
require 'caracal/utilities'
require 'caracal/version'

# document
require 'caracal/document'


#------------------------------------------------
# Extra Setup
#------------------------------------------------

# Convenience method for finding root directory.
#
module Caracal
  def self.root
    File.dirname __dir__
  end
end


# Add functions to table cell model. we do this here to
# avoid a circular require between Caracal::Core::Tables
# and Caracal::Core::Models::TableCellModel.
#
Caracal::Core::Models::TableCellModel.class_eval do
  include Caracal::Core::Images
  include Caracal::Core::Lists
  include Caracal::Core::Rules
  include Caracal::Core::Tables
  include Caracal::Core::Text
end
