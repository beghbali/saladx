class Order < ActiveRecord::Base
  obfuscate_id

  acts_as_mappable :default_units => :miles,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude
  belongs_to :recipe, autosave: true
  belongs_to :customer, class_name: 'User', foreign_key: :customer_id
  belongs_to :cook, class_name: 'User', foreign_key: :cook_id
  belongs_to :courier, class_name: 'User', foreign_key: :courier_id

  scope :unfulfilled, -> { where(fulfilled_at: nil) }

  before_validation :set_zone
  before_save :charge

  alias_method :fulfilled_by, :cook
  alias_method :pickedup_by, :courier
  alias_method :delivered_by, :courier

  PRICE = 1095

  %w(started fulfilled pickedup delivered).each do |stage|
    define_method :"#{stage}_by=" do |actor, what_time=Time.now|
      self.send("#{actor_for(stage)}=", actor)
      self.send("#{stage}_at=", what_time)
    end

    define_method :"#{stage}_by!" do |actor|
      self.send("#{stage}_by=", actor)
      save
    end
  end

  JSON_ATTRIBUTES = [:recipe_id, :customer_id, :street_address, :city, :state, :zip_code,
      :started_at, :ordered_at, :cook_id, :pickedup_at, :courier_id]

  def as_json(options=nil)
    attributes.with_indifferent_access.slice(*JSON_ATTRIBUTES).merge(recipe: recipe.as_json)
  end

  def charge
    charge = Stripe::Charge.create(
        :amount => Order::PRICE,
        :currency => "usd",
        :customer => customer.stripe_customer_id
      )
    self.stripe_charge_id = charge.id if charge.paid
  end

  def payed?
    self.stripe_charge_id.present?
  end

  def set_zone
    self.zone = determine_zone
  end

  def determine_zone
    possible_zones = Zone.within(1, origin: self)
    possible_zones.detect {|zone| zone.boundary.contains? self }
  end

  private
  def stage_actors
    {
      started:   :cook,
      fulfilled: :cook,
      pickedup:  :courier,
      delivered: :courier
    }
  end

  def actor_for(stage)
    stage_actors[stage.to_sym]
  end
end
