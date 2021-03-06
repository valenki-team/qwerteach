module Admin
  class ReviewsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # simply overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Review.all.paginate(10, params[:page])
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Review.find_by!(slug: param)
    # end

    # See https://administrate-docs.herokuapp.com/customizing_controller_actions
    # for more information
    private

    def search
      @search ||= Review.ransack(search_params)
    end

    def scoped_resource
      search.result
    end

    def search_params
      params[:q]
    end

  end
end
