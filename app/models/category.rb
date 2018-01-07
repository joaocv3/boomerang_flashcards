class Category < ApplicationRecord
  has_many :subjects

  validates_presence_of :name
end
