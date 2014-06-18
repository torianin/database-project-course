require 'rubygems'
require 'mail'
require 'singleton'

class Mailer
    include Singleton

    def initialize()
      Mail.defaults do
        delivery_method :smtp, {
            :address => 'poczta.o2.pl',
            :port => '587',
            :user_name => 'prawdziwy-mail@o2.pl',
            :password => 'olamakota123',
            :authentication => :login,
            :enable_starttls_auto => true
        }
      end
    end

    def createMail(to, subject, body)
      @mail = Mail.new do
        from     'prawdziwy-mail@o2.pl'
        to       "#{to}"
        subject "#{subject}"
        body "#{body}"
      end
      @mail.deliver!
  end
end