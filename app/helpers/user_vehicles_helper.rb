module UserVehiclesHelper
  def set_user_vehicles
    if signed_in?
      @user_vehicles = UserVehicle.where(user_id: current_user.id).limit(5)
    end
  end
end
