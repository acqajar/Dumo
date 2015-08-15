class User < ActiveRecord::Base



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
has_attached_file :bgphoto, :styles => { :normal => "718x237" }, :default_url => "/images/:style/missing.png"
validates_attachment_content_type :bgphoto, :content_type => /\Aimage\/.*\Z/



# Follower/followed
#relationships - followers
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy                                  
  # has_many followeds is unusual so redefine via source                                
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower




# News Feed of followers


  #follow methods
def follow (other_user)
  active_relationships.create(followed_id: other_user.id)
end


def unfollow (other_user)
  active_relationships.find_by(followed_id: other_user.id).destroy
end

def following?(other_user)
  following.include?(other_user)
end
       
def logged_in?
    current_user != nil
end

end
