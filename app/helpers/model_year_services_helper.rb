module ModelYearServicesHelper
  
  def video_container(video_url, video_src)
    if video_src == "youtube"
      tag("iframe", src: video_url, frameborder: "0", allowfullscreen: "")
    else
      return false
    end
  end
  
  def get_item(id)
    RequirementItem.find(id)
  end
  
  def get_reject_vote_type
    @reject_vote_type ||= VoteType.find_by(name: "Reject")
  end
  
  def get_confirm_vote_type
    @confirm_vote_type ||= VoteType.find_by(name: "Confirm")
  end
  
  def get_visitor_vote(model_year_service_requirement_id, ip_address)
    ModelYearServiceRequirementVote.with_ip_address(ip_address).
                                    where(model_year_service_requirement_id: model_year_service_requirement_id)
  end
  
end
