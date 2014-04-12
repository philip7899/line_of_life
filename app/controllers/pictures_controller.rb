class PicturesController < ApplicationController

	def new
		@pic = Picture.new
	end

	def create
		@pic = Picture.new(picture_params)
		if @pic.save
			puts 'picture saved'
		else
			puts 'save did not work'
		end
		render 'new'
	end

	private

	def picture_params
		params.require(:picture).permit(:pic, :color)
	end
end
