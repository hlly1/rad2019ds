module ApplicationHelper

  # According to the page, return the correct title
  def full_title(page_title = '')
    base_title = "RAD Assignment 1"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end