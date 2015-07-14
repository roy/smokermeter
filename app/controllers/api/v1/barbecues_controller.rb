module Api
  module V1
    class BarbecuesController < ApplicationController
      before_filter :authorize, only: [:create, :update, :destroy]

      def index
        barbecues = Barbecue.all

        render json: barbecues
      end

      def show
        render json: find_barbecue(params[:id])
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
        barbecue = find_barbecue(params[:id])

        if barbecue.update(barbecue_params)
          render json: barbecue, status: :ok, location: [:api, :v1, barbecue]
        else
          render json: barbecue.errors, status: :unprocessable_entity
        end
      end

      def destroy 
        barbecue = find_barbecue(params[:id])

        barbecue.destroy
        head :no_content
      end

      private
      def find_barbecue(id)
        barbecue = Barbecue.find(id)
        authorizer(current_user, barbecue)
        barbecue
      end

      def barbecue_params
        params.require(:barbecue).permit(:name)
      end

      def authorizer(user, barbecue)
        authorizer = BarbecueAuthorizer.new(user, barbecue)

        unless authorizer.public_send("#{action_name}?")
          raise UnAuthorizedError
        end
      end
    end
  end
end
