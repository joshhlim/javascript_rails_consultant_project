module ModelYearServiceRequirementsHelper
  def amazon_link(name, detail)
    uri = URI.parse("http://www.amazon.com/s/")
    if detail.present?
      keywords = "#{detail} #{name}"
    else
      keywords = "#{name}"
    end
    uri.query = URI.encode_www_form([["keywords", keywords], ["tag", amazon_associate_id]])
    return uri.to_s
  end
end
