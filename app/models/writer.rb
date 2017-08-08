class Writer < ActiveRecord::Base
	has_many :movies

	def get_full_name
		first_name.to_s + " " + last_name.to_s
	end
end
