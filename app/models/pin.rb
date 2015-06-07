class Pin < ActiveRecord::Base

	searchkick autocomplete: [:title]

	acts_as_votable
	
	belongs_to :user

  	acts_as_mentioner
  	acts_as_likeable

	has_many :comments, dependent: :destroy

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" },
	 :default_url => "/images/:style/missing.png",
        :url  => ":s3_domain_url",
        :path => "public/avatars/:id/:style_:basename.:extension",
        :storage => :fog,
        :fog_credentials => {
            provider: 'AWS',
            aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
            aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
        },
        fog_directory: ENV["FOG_DIRECTORY"]


  	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end

