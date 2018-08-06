require 'rails_helper'

RSpec.describe Spree::Admin::Categories::Saving do
  subject { described_class.new(params) }

  let(:params) { { name: 'Test1', parent_id: nil, soft_position: 2 } }

  let(:category_last) { Spree::Category.last }

  describe 'service call' do
    it 'create new object' do
      expect { subject.save }.to change { Spree::Category.count }.from(0).to(1)
    end

    context 'when params is good' do
      before { subject.save }

      it 'have not parent' do
        expect(category_last.parent).to be nil
      end

      it 'have a correct name' do
        expect(category_last.name).to eq('Test1')
      end

      it 'have a soft position' do
        expect(category_last.soft_position).to eq(2)
      end
    end

    context 'when params not good' do
      let(:params) { {} }

      it 'not create new object' do
        subject.save
        expect(category_last).to be nil
      end
    end

    context 'when parent set' do
      let(:params) { { name: 'Test1', parent_id: Spree::Category.first.id, soft_position: 2 } }

      before do
        test_parent_category_create
        subject.save
      end

      it 'have a parent' do
        expect(category_last.parent).to eq(Spree::Category.first)
      end
    end
  end

  def test_parent_category_create
    category = Spree::Category.new(name: 'Parent cat', soft_position: 1)
    category.save
  end
end
