class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pins, dependent: :destroy

  # has_many :comments, dependent: :destroy
  # attr_accessor :login
  # validates_uniqueness_of :username
  validates_presence_of :username
  validates :username, length: { in: 4..20 }

  # def self.find_first_by_auth_conditions(warden_conditions)
  #   conditions = warden_conditions.dup
  #   if login = conditions.delete(:login)
  #     where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login }]).first
  #   else
  #     where(conditions).first
  #   end
  # end
         
end
