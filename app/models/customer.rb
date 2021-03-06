class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, :omniauth_providers => [:facebook]

  validates :customername, presence: true

  has_many :orders

  has_many :pins, :dependent => :destroy

 def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |customer|
    customer.email = auth.info.email
    customer.password = Devise.friendly_token[0,20]
    customer.customername = auth.info.name   # assuming the user model has a name
    #customer.image = auth.info.image # assuming the user model has an image
  end
 end

end
