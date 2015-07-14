module Api
  module V1
    class RegistrationsController < ApplicationController

      def create
        registration = Registration.new(registration_params)

        if registration.save
          render json: registration, status: :created
        else
          render json: registration.errors, status: :unprocessable_entity
        end
      end

      private
      def registration_params
        params.require(:registration).permit(
          :name,
          :email,
          :password,
          :password_confirmation
        )
      end

    end
  end
end
