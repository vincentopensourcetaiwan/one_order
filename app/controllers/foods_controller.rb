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
    Food.includes(:meals).order(name: :asc).find_in_batches(batch_size: 100).each do |foods|
      @foods = foods.map do |food|
        food_ids = food.meals.map { |m| m.foods.pluck(:food_id).uniq }.flatten.uniq.reject { |e| e == food.id }.compact
        { "Food Head" => food.name, "other_food" => foods.select { |f| food_ids.include?(f["id"]) }.map { |f| f.name }.sort }
      end.sort_by { |f| f["Food Head"] }
    end
    render :json => @foods
  end
end