json.array!(@user_vehicles) do |user_vehicle|
  json.extract! user_vehicle, :model_year_id, :user_id, :name, :mileage, :image_url, :video_url, :privacy_id, :rating, :views, :touches
  json.url user_vehicle_url(user_vehicle, format: :json)
end