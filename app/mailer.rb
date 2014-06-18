require 'rubygems'
require 'mail'
require 'singleton'

class Mailer
    include Singleton

    def initialize()
      Mail.defaults do
        delivery_method :smtp, {
            :address => 'robert-i.com',
            :port => '587',
            :user_name => 'bazy@robert-i.com',
            :password => 'olamakota123',
            :authentication => :plain,
            :enable_starttls_auto => false
        }
      end
    end

    def createMail(to, subject, body)
      @mail = Mail.new do
        from     'bazy@robert-i.com'
        to       "#{to}"
        subject "#{subject}"
        body "#{body}"
      end
      @mail.deliver!
  end
end