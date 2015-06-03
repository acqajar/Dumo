class Pin < ActiveRecord::Base

	searchkick
	acts_as_votable
	
	belongs_to :user

  	acts_as_mentioner
  	acts_as_likeable

	has_many :comments, dependent: :destroy

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
