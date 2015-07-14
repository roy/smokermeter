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
          render json: barbecue, status: :created, location: [:api, :v1, barbecue]
        else
          render json: barbecue.errors, status: :unprocessable_entity
        end
      end

      def update
        barbecue = current_user.barbecues.find(params[:id])

        if barbecue.update(barbecue_params)
          render json: barbecue, status: :ok, location: [:api, :v1, barbecue]
        else
          render json: barbecue.errors, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: ['Unauthorized'], status: 401
      end

      private
      def barbecue_params
        params.require(:barbecue).permit(:name)
      end
    end
  end
end
