class FoodsController < ApplicationController
  def no_food_meal
    @meals = Meal.includes(:foods).select { |m| m if m.foods.size == 0 }.map { |m| { "No Food Meal" => m.name } }
    render :json => @meals
  end

  def max_foods
    @foods = Food.includes(:meals).select { |f| f.meals.any? }.map { |f| { "Food" => f.name, "Meal #" => f.meals.size } }.sort_by { |f| f["Meal #"] }.reverse
    render :json => @foods
  end

  def other_food
    @foods = Food.includes(:meals).order(name: :asc).map do |food|
      food_ids = food.meals.map { |m| m.foods.pluck(:food_id).uniq }.flatten.uniq.reject { |e| e == food.id }.compact
      { "Food Head" => food.name, "other_food" => Food.where(id: food_ids).map { |f| f.name }.sort }
    end
    render :json => @foods.sort_by { |f| f["Food Head"] }
  end
end