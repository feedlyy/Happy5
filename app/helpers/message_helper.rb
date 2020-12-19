class MessageHelper
  def isvalid(m, r)
    validator = MessageValidation.new
    validator.messages = m
    validator.receiver = r
    validator.valid?

    if validator.valid? == false
      validator.errors
    end
  end

  def checkreceiver(sender, receiver)
    if sender == receiver
      true
    end
  end

  def getid(receiver)
    @user = User.find_by(username: receiver)
  end
end