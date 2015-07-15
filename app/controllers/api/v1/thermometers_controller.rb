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

      private
      def thermometer_params
        params.require(:thermometer).permit(:location)
      end

      def find_barbecue
        Barbecue.find(params[:barbecue_id])
      end
    end
  end
end
