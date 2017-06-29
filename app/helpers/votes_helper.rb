module VotesHelper

  def existing_vote(item)
    if signed_in?
      existing_vote = item.votes.where(user_id: current_user.id).first
    else
      existing_vote = item.votes.where(ip_address: request.remote_ip).first
      existing_vote ||= item.votes.where(session_id: request.session_options[:id]).first
    end
  end

  def get_vote_type_by_name(name)
    VoteType.find_by(name: name)
  end

  def confirm_vote_type
    @confirm_vote_type ||= get_vote_type_by_name('Confirm')
  end

  def reject_vote_type
    @reject_vote_type ||= get_vote_type_by_name('Reject')
  end

  # The original design for votes was to split them up into different models, these helpers will count up the different models
  # until the design can be changed and the votes moved
  def total_vote_count_for_user(user)
    count = Vote.where(user: user).count
    # count += ModelYearServiceInterval.where(user_id: user.id).count # This was moved to the Vote model
    count += ModelYearServiceRequirementVote.where(user_id: user.id).count
  end

  def confirm_vote_count_for_user(user)
    if user && confirm_vote_type
      count = Vote.where(user: user, vote_type: confirm_vote_type).count
      # count += ModelYearServiceInterval.where(user_id: user.id, vote_type_id: confirm_vote_type.id).count # This was moved to the Vote model
      count += ModelYearServiceRequirementVote.where(user: user, vote_type: confirm_vote_type).count
    else
      count = 0
    end
    return count
  end

  def reject_vote_count_for_user(user)
    if user && reject_vote_type
      count = Vote.where(user: user, vote_type: reject_vote_type).count
      # count += ModelYearServiceInterval.where(user_id: user.id, vote_type_id:  reject_vote_type.id).count # This was moved to the Vote model
      count += ModelYearServiceRequirementVote.where(user: user, vote_type_id: reject_vote_type).count
    else
      count = 0
    end
    return count
  end

end
