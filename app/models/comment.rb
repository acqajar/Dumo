class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :pin
  	acts_as_mentioner

end
