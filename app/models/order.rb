class Order < ActiveRecord::Base
  obfuscate_id

  belongs_to :recipe
  belongs_to :customer, class_name: 'User', foreign_key: :customer_id
  belongs_to :cook, class_name: 'User', foreign_key: :cook_id
  belongs_to :courier, class_name: 'User', foreign_key: :courier_id

  scope :unfulfilled, -> { where(fulfilled_at: nil) }

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

  def as_json(options=nil)
    attributes.with_indifferent_access.slice(:recipe_id, :customer_id, :street_address, :city, :state, :zip_code,
      :started_at, :ordered_at, :cook_id, :pickedup_at, :courier_id)
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
