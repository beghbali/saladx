class User < ActiveRecord::Base
  obfuscate_id

  attr_accessible :email, :password
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

end
