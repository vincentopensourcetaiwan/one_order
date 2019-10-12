# == Schema Information
#
# Table name: meal_foods
#
#  meal_id :integer
#  food_id :integer
#

class MealFood < ApplicationRecord
  belongs_to :meal
  belongs_to :food
end
