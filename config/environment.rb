# Load the Rails application.
require File.expand_path('../application', __FILE__)

if $0 =~ /(rake|railroady|erd)$/
  Rails.logger = Logger.new("/dev/null")
end

# Initialize the Rails application.
Rails.application.initialize!
