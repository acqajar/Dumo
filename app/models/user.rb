class User < ActiveRecord::Base

  searchkick autocomplete: [:title]  

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

  

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
        :default_url => "/images/:style/missing.png"
        :url  => ":s3_domain_url",
        :path => "public/avatars/:id/:style_:basename.:extension",
        :storage => :fog,
        :fog_credentials => {
            provider: 'AWS',
            aws_access_key_id: "AKIAIRPKLJNSDO23425",
            aws_secret_access_key: "9LXV/GWagu/CJ4DoMLKSmdasdaZeUyuax/Ei92hL7"
        },
        fog_directory: "memento-env"


  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


  acts_as_mentionable
  acts_as_follower
  acts_as_followable
  acts_as_liker
  acts_as_likeable



  def autocomplete
      render json: User.search(params[:query], autocomplete: true, limit: 10).map(&:title)
  end

  def search
    if params[:search].present?
      @users = User.search(params[:search])
    else
      @users = User.all
    end
  end


         
end
