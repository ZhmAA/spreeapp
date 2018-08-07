module Spree
  module Admin
    module Items
      class Saving
        attr_reader :item

        def initialize(params)
          @params = params
          @item   = params[:id].nil? ? Spree::Item.new : Spree::Item.find(params[:id])
        end

        def save
          item.attributes = prepared_attributes
          item.save
        end

        private

        attr_reader :params

        def prepared_attributes
          {
              name:        params[:name],
              category_id: params[:category_id],
              image:       params[:image]
          }
        end
      end
    end
  end
end
