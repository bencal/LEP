Given /the following students exist/ do |students|
  students.hashes.each do |student|
    User.create(first_name: student['first_name'], 
		last_name: student['last_name'], 
		sid: student['sid'], 
		email: student['email'],
		gender: student['gender'], 
		fluent_languages: student['fluent_languages'], 
		first_lang_preference: student['first_lang_preference'], 
		admin: false)
  end
end

Given /^I am logged in as "(.*)"$/ do |first_name|
	@user = User.find_by_first_name(first_name)
	# "/users/#{@user.id}"
	# puts page.current_path
	visit path_to("/users/#{@user.id}")
end


# given step definitions
Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create!(user)
  end
end

Given /^I am an? (.*) user$/ do |user_type|
  OmniAuth.config.mock_auth[:google_oauth2] = nil
  if user_type == "existing"
    OmniAuth.config.mock_auth[:google_oauth2] = 
      OmniAuth::AuthHash.new({:provider => 'google_oauth2',
        :uid => '0',
        :info => {
          :name => 'existing',
          :email => 'existing@berkeley.edu'
        }
      })
  elsif user_type == "admin"
    OmniAuth.config.mock_auth[:google_oauth2] = 
      OmniAuth::AuthHash.new({:provider => 'google_oauth2',
        :uid => '1',
        :info => {
          :name => 'admin',
          :email => 'admin@berkeley.edu'
        }
      })
  elsif user_type == "non-existing"
    OmniAuth.config.mock_auth[:google_oauth2] = 
      OmniAuth::AuthHash.new({:provider => 'google_oauth2',
        :uid => '2',
        :info => {
          :name => 'non-existing',
          :email => 'non-existing@berkeley.edu'
        }
      })
  elsif user_type == "invalid"
    OmniAuth.config.mock_auth[:google_oauth2] = 
      OmniAuth::AuthHash.new({:provider => 'google_oauth2',
        :uid => '3',
        :info => {
          :name => 'invalid',
          :email => 'invalid@gmail.com'
        }
      })
  else 
    flunk "Not a valid user type"
  end 
end

Given /^I am (not )?an admin$/ do |not_admin|
end

Given /^I am viewing the LEP homepage$/ do
end

When /^I sign in$/ do
  visit "/auth/google_oauth2"
end

# When step definitions
When /^I view the LEP page$/ do
end

# Then step definitions
Then /^I should be at the LEP (.*) home page$/ do |user_type|
end

