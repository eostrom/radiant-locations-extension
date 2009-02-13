When /^I visit the "(.+)" admin page$/ do |page|
#  visit '/admin/pages?show_all=true'
#  click_link page
  visit page_edit_path(Page.find_by_title(page))
end

