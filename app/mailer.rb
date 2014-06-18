=begin
require 'rubygems'
require 'mail'

options = { :address              => "robert-i.com",
            :port                 => 465,
            :domain               => 'robert-i.com',
            :user_name            => 'bazy@robert-i.com',
            :password             => 'olamakota123',
            :authentication       => 'login',
            :enable_starttls_auto => false  }

Mail.defaults do
  delivery_method :smtp, options
end

Mail.deliver do
  to 'tori@robert-i.com'
  from 'bazy@robert-i.com'
  subject 'testing sendmail'
  body 'testing sendmail'
end
=end

require 'rubygems'
require 'mail'

# Set up delivery defaults to use Gmail
a = gets.chomp

Mail.defaults do
  delivery_method :smtp, {
      :address => 'poczta.o2.pl',
      :port => '465',
      :user_name => 'prawdziwy-mail@o2.pl',
      :password => 'olamakota123',
      :authentication => :login,
      :enable_starttls_auto => true
  }
end

# Send email with attachment.
mail = Mail.new do
  from     'prawdziwy-mail@o2.pl'
  to       'tori@robert-i.com'
  subject 'testing sendmail'
  body 'testing sendmail'
end

# Don't forget delivery
mail.deliver!
