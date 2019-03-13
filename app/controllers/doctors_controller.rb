class DoctorsController < ApplicationController

	def index
		@doctors = doctor.all

		if search_term
		  @doctors = @doctors.where("name iLIKE ?", "%#{search_term}%"                     ) 
		end 

		if sort_order && sort_attribute
		  @doctors = @doctorss.order(sort_attribute => sort_order)
		elsif sort_attribute
		  @doctors = @doctors.order(sort_attribute)
		end 

		render 'index.json.jbuilder'
	end

	def create
		@doctor = doctor.new(
								type: params[:type],
								description: params[:description]
								)
		if @doctor.save
			render 'show.json.jbuilder'
		else
			render json: {errors: @doctor.errors.full_messages}, status: :unprocessable_entity
		end
	end

	def show
		@doctor = Doctor.find(params[:id])
		render 'show.json.jbuilder'
	end

	def update
		@doctor = Doctor.find(params[:id])

		@doctor.type = params[:type] || @doctor.type
		@doctor.description = params[:description] || @doctor.description

		if @doctor.save
		  render "show.json.jbuilder"
		else
		  render json: {errors: @doctor.errors.full_messages}, status: :unprocessable_entity
		end 
	end

	def destroy 
		@doctor = Doctor.find(params[:id])
		@doctor.destroy
		render json: {message: "Doctor successfully destroyed."}

	end 
end

end
