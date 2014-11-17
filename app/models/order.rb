class Order < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :customer, class_name: 'User', foreign_key: :customer_id
  belongs_to :cook, class_name: 'User', foreign_key: :cook_id
  belongs_to :courier, class_name: 'User', foreign_key: :courier_id

  alias_method :fulfilled_by, :cook
  alias_method :pickedup_by, :courier
  alias_method :delivered_by, :courier

  def fulfilled_by=(cook, what_time=Time.now)
    self.cook = cook
    self.fulfilled_at = what_time
  end

  def pickedup_by=(courier, what_time=Time.now)
    self.courier = courier
    self.fulfilled_at = what_time
  end

  def delivered_by=(courier, what_time=Time.now)
    self.fulfilled_at = what_time
  end

end
