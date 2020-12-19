class MessageValidation
  include ActiveModel::Validations

  attr_accessor :receiver
  attr_accessor :messages

  validates_presence_of :receiver, message: 'receiver can\'t be blank'
  validates_presence_of :messages, message: 'message can\'t be blank'
end