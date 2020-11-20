module ApplicationHelper
  def full_title(plus_title="")
    base_title = "CodeCampMarket"
    if plus_title.empty?
      base_title
    else
      plus_title + ' | ' + base_title
    end
  end
end
