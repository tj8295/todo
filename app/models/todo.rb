class Todo < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings
  validates :name, presence: true
  validates :description, presence: true

  def name_only?
    description.blank?
  end
end
