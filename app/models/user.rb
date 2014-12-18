class User < ActiveRecord::Base
  ROLES = %w(consumer cook courier admin)

  attr_accessor :stripe_card_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders
  before_save :create_stripe_customer, if: -> { stripe_customer_id.nil? && consumer? }

  scope :consumers, -> { where(role: 'consumer') }
  scope :cooks, -> { where(role: 'cook') }
  scope :couriers, -> { where(role: 'courier') }
  scope :admins, -> { where(role: 'admin') }

  ROLES.each do |role|
    define_method "#{role}?" do
      self.role == role
    end
  end

  def as_json(options=nil)
    attributes.with_indifferent_access.slice(:id, :full_name, :email, :phone_number)
  end

  def create_stripe_customer
    customer = Stripe::Customer.create(
      card: self.stripe_card_token,
      metadata: { phone_number: self.phone_number }
    )
    self.stripe_customer_id = customer.id
  end

  def email_required?
    false
  end

  def password_required?
    false
  end
end
