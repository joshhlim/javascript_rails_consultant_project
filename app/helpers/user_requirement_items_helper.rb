module UserRequirementItemsHelper
  def set_recent_user_requirement_items
    if signed_in?
      @recent_user_requirement_items = UserRequirementItem.where(user_id: current_user.id).order('updated_at DESC').limit(3)
    end
  end
end
