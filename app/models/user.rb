class User < ActiveRecord::Base

  acts_as_follower
  acts_as_followable
  acts_as_mentionable
  acts_as_mentioner

  searchkick
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pins, dependent: :destroy

  has_many :comments, dependent: :destroy
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

  
#avatar image
  has_attached_file :avatar, :styles => { :medium => "619x223>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


# bgphoto image
has_attached_file :bgphoto, :styles => { :normal => "718x237>" }, :default_url => "/images/:style/missing.png"
validates_attachment_content_type :bgphoto, :content_type => /\Aimage\/.*\Z/

  acts_as_mentionable
  acts_as_follower
  acts_as_followable
  acts_as_liker
  acts_as_likeable
         
end
