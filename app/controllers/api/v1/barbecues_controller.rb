module Api
  module V1
    class BarbecuesController < ApplicationController

      def index
        barbecues = Barbecue.all
        render json: barbecues, each_serializer: BarbecueSerializer
      end

    end
  end
end
