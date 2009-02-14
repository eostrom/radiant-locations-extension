When /^I visit the "(.+)" admin page$/ do |page|
  visit page_edit_path(Page.find_by_title(page))
end

When /^I add a child to the "(.+)" page$/ do |page|
  visit page_new_path(:parent_id => Page.find_by_title(page))
end

# TODO: "fill in title" should automatically set slug/breadcrumb if they're blank
