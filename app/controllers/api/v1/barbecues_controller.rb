module Api
  module V1
    class BarbecuesController < ApplicationController
      before_filter :authorize, only: [:create]

      def index
        barbecues = Barbecue.all
        render json: barbecues
      end

      def show
        barbecue = Barbecue.find(params[:id])
        render json: barbecue
      end

      def create
        barbecue = current_user.barbecues.new(barbecue_params)

        if barbecue.save
          render json: barbecue, status: :created
        else
          render json: barbecue.errors, status: :unprocessable_entity
        end
      end

      private
      def barbecue_params
        params.require(:barbecue).permit(:name)
      end
    end
  end
end
