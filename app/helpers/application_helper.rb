module ApplicationHelper
  def title
    base_title = "Social network"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
    end
end
