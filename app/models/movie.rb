class Movie < ActiveRecord::Base
	belongs_to :genre
	belongs_to :writer

	acts_as_taggable
	acts_as_taggable_on :genres, :writers

	serialize :genre_id, JSON
	serialize :writer_id, JSON

	validates :title, :presence => {message: "Empty title"}
	validates :short_desc, :presence => {message: "Empty short_desc"}
	validates :genre_list, :presence => {message: "Empty genres"}
	validates :writer_list, :presence => {message: "Empty writers"}

	def get_genre_names
		@ech_result = nil
		@final_result = []
		genre_list.each do |gr|
			@ech_result = Genre.select(:name).where(id: gr.to_i).pluck(:name)
			@final_result += @ech_result
		end

		return @final_result.join(", ")
	end

	def get_writer_names
		@each_name = nil
		@each_last = nil
		@final_name = []

		writer_list.each do |cr|
			@each_name = Writer.select(:first_name).where(id: cr.to_i).pluck(:first_name).join(" ").to_s
			@each_last = Writer.select(:last_name).where(id: cr.to_i).pluck(:last_name).join(" ").to_s
			@final_name.push(@each_name + " " + @each_last)
		end

		return @final_name.join(", ")
	end	
end
