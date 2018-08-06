module Spree
  module Admin
    module Categories
      class Saving
        attr_reader :category

        def initialize(params)
          @params   = params
          @category = params[:id].nil? ? Spree::Category.new : Spree::Category.find(params[:id])
        end

        def save
          category.attributes = prepared_attributes
          category.save
        end

        private

        attr_reader :params

        def prepared_attributes
          {
              name:          params[:name],
              parent_id:     params[:parent_id],
              soft_position: params[:soft_position]
          }
        end
      end
    end
  end
end
