# require_relative '../../lib/tokenable'

class Todo < ActiveRecord::Base
  include Tokenable
  has_many :taggings
  has_many :tags, through: :taggings
  validates :name, presence: true
  belongs_to :user
  # validates :description, presence: true


  def name_only?
    description.blank?
  end

  def save_with_tags
    if save
      create_location_tags
      true
    else
      false
    end
  end

  def to_param
    token
  end

  def decorator
    TodoDecorator.new(self)
  end


  private
    def create_location_tags
      location_string = name.slice(/.*\bAT\b(.*)/,1).try(:strip)

      if location_string
        locations = location_string.split(/\,|and/).map(&:strip)
        locations.each do |location|
          tags.create(name: "location:#{location}")
        end
      end
    end
end
