When /^I visit the "(.+)" admin page$/ do |page|
  visit page_edit_path(Page.find_by_title(page))
end

