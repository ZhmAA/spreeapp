class Spree::Category < ApplicationRecord
  has_many :items, dependent: :destroy

  belongs_to :parent, class_name: 'Category', optional: true
  has_many :childrens, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy

  validates :name, :soft_position, presence: true

  def has_parent?
    parent.present?
  end

  def has_children?
    children.exists?
  end
end
