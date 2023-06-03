class Tag < ApplicationRecord
  belongs_to :tag_list

  validates :name, presence: true
end
