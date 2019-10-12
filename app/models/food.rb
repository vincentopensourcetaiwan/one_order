# == Schema Information
#
# Table name: foods
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Food < ApplicationRecord
  has_many :meal_foods, dependent: :destroy
  has_many :meals, through: :meal_foods
end
