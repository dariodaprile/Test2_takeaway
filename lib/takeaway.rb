require 'twilio-ruby'

ACCOUNT_SID = ENV['TWILIO_ID']
AUTH_TOKEN = ENV['TWILIO_TOKEN']

class Takeaway

  attr_accessor :estimate_price

  def initialize
    @dishes = {
      :lasagne    => 1,
      :bolognese  => 2,
      :burger     => 2,
      :fishpie    => 3,
    }

    @client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
  end

  def request(items)
    @total = items.map{|dish, quantity| quantity* @dishes[dish]}.inject(:+)
  end

  def compare(estimate_price, total)
    estimate_price == total ? confirm_order : raise("It is a wrong estimate")
  end

  def confirm_order
    message = %Q[Thank you! Your order was placed and will be delivered before #{(Time.now + 3600).strftime("%H:%M")}]
    send(message)
  end

  def send(text)
  @account = @client.account
  @account.sms.messages.create({:from => '+441752395736', :to => '+447554438544', :body => text})
  end
end