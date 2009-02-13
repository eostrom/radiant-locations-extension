Given /I am logged in as "(\w+)"/ do |name|
  visit '/admin/login'
  fill_in 'Username', :with => name.downcase
  fill_in 'Password', :with => name.downcase
  click_button 'Login'
end

Given "I am logged out" do
  visit '/logout' rescue nil # Radiant barfs on logging out when you're not logged in
end
