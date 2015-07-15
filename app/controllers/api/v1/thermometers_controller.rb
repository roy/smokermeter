module Api
  module V1
    class ThermometersController < ApplicationController
      before_filter :authorize, only: [:create, :update, :destroy]

      def index
        thermometers = find_barbecue.thermometers

        render json: thermometers
      end

      def show
        thermometer = find_barbecue.thermometers.find(params[:id])

        render json: thermometer
      end

      def create
        thermometer = find_barbecue.thermometers.new(thermometer_params)

        if thermometer.save
          render json: thermometer, status: :created, location: [:api, :v1, find_barbecue, thermometer]
        end
      end

      def update
        thermometer = find_barbecue.thermometers.find(params[:id])
        authorizer(find_barbecue, thermometer)

        if thermometer.update(thermometer_params)
          render json: thermometer, status: :ok, location: [:api, :v1, find_barbecue, thermometer]
        else
          render json: thermometer.errors, status: :unprocessable_entity
        end
      end

      def destroy
        thermometer = find_barbecue.thermometers.find(params[:id])
        authorizer(find_barbecue, thermometer)

        thermometer.destroy
        head :no_content
      end

      private
      def authorizer(barbecue, thermometer)
        authorizer = ThermometerAuthorizer.new(current_user, barbecue, thermometer)

        unless authorizer.public_send("#{action_name}?")
          raise UnAuthorizedError
        end
      end
      def thermometer_params
        params.require(:thermometer).permit(:location)
      end

      def find_barbecue
        Barbecue.find(params[:barbecue_id])
      end
    end
  end
end
