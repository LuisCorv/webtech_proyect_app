class TagList < ApplicationRecord
  has_many :tags
  belongs_to :ticket
end
