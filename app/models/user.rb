class User < ActiveRecord::Base
  obfuscate_id

  attr_accessor :stripe_card_token
  attr_accessible :email, :password
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :create_stripe_customer, unless: :stripe_customer_id

  def create_stripe_customer
    customer = Stripe::Customer.create(
      card: self.stripe_card_token,
      metadata: { phone_number: self.phone_number }
    )
    self.stripe_customer_id = customer.id
  end

end
