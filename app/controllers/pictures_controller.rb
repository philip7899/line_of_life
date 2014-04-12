class PicturesController < ApplicationController

	def new
		@pic = Picture.new
	end

	def create
		@uploaded_pic = Picture.new(picture_params)
		if @uploaded_pic.save
			puts 'picture saved'
		else
			puts 'save did not work'
		end
		@pic = Picture.new
		render 'new'
	end

	private

	def picture_params
		params.require(:picture).permit(:pic, :color)
	end
end
