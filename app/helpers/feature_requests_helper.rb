module FeatureRequestsHelper
  def get_feature_id_from_name(name)
    Feature.find_by(name: name).id
  end
  
  def get_feature_from_name(name)
    Feature.find_by(name: name)
  end
  
  def existing_feature_request(feature)
    if signed_in?
      feature_request = FeatureRequest.find_by(feature: feature, user_id: current_user.id)
    else
      feature_request = FeatureRequest.find_by(feature: feature, ip_address: request.remote_ip)
      feature_request ||= FeatureRequest.find_by(feature: feature, session_id: request.session_options[:id])
    end
  end
  
end
