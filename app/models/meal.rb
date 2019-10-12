# == Schema Information
#
# Table name: meals
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Meal < ApplicationRecord
  has_many :meal_foods, dependent: :destroy
  has_many :foods, through: :meal_foods
end
