module Api
  module V1
    class BarbecuesController < ApplicationController

      def index
        barbecues = Barbecue.all
        render json: barbecues
      end

      def show
        barbecue = Barbecue.find(params[:id])
        render json: barbecue
      end

    end
  end
end
