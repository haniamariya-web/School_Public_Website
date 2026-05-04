module InquiriesHelper
  def truncate_with_hover(text, length = 15)
    return "" if text.blank?
    
    if text.length > length
      # Truncate and add native title attribute for hover tooltip
      content_tag(:span, truncate(text, length: length), title: text, class: "cursor-help underline decoration-dotted decoration-gray-300")
    else
      text
    end
  end
end