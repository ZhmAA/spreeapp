require 'rails_helper'

RSpec.describe Spree::Admin::Items::Saving do
  subject { described_class.new(params) }

  let(:params) { { name: 'Test1', category_id: Spree::Category.last.id } }

  let(:item_last) { Spree::Item.last }

  describe 'service call' do
    before { test_category_create }

    it 'create new object' do
      expect { subject.save }.to change { Spree::Item.count }.from(0).to(1)
    end

    context 'when params is good' do
      before { subject.save }

      it 'belongs to category' do
        expect(item_last.category).to eq(Spree::Category.last)
      end

      it 'have a correct name' do
        expect(item_last.name).to eq('Test1')
      end
    end

    context 'when params not good' do
      let(:params) { {} }

      it 'not create new object' do
        subject.save
        expect(item_last).to be nil
      end
    end
  end

  def test_category_create
    category = Spree::Category.new(name: 'Category test', soft_position: 1)
    category.save
  end
end
