default_user_params = {
  'first_name' => "FIRSTNAME", 
  'last_name' => "LASTNAME", 
  'email' => "example@gmail.com", 
  'academic_title' => "DEFAULT", 
  'major' => "MAJOR", 
  'residency' => "DEFAULT",
  'gender' => "GENDER", 
  'gender_preference' => "DEFAULT", 
  'fluent_languages' => ["english"], 
  'fluent_languages_other' => "DEFAULT", 
  'lang_additional_info' => "DEFAULT",
  'first_lang_preference' => "DEFAULT",
  'first_lang_proficiency' => "DEFAULT", 
  'second_lang_preference' => "DEFAULT",
  'second_lang_proficiency' => "DEFAULT",
  'group_leader' => 'No',
  'time_preference' => ["monday"],
  'hours_per_week' => "0",
  'user_motivation' => "DEFAULT",
  'user_plan' => "DEFAULT",
  'admin' => false,
  'active' => true,
  'facilitator' => false,
  'group_language' => "DEFAULT"
}

Given /the following students exist/ do |students|
  students.hashes.each do |student|
    student['fluent_languages'] = student['fluent_languages'].split(',')
    # puts default_user_params.merge(student_params)
    puts User.create(default_user_params.merge(student)).errors.messages
  end
end

Given /the following facilitators exist/ do |facilitators|
  facilitators.hashes.each do |f|

    @user = User.create(first_name: f['first_name'],  
                sid: f['sid'], 
                email: f['email'],
                fluent_languages: f['fluent_languages'].split(','), 
                first_lang_preference: f['first_lang_preference'],
                admin: false,
                active: true,
                facilitator: true,
                id: 1)
    #page.set_rack_session(id: 1)
    # print '***********************USER ID', @user.id
    # cookies[:stub_user_id] = @user.id
    # print  "*******************COOKIES IN STEPS", cookies[:stub_user_id]
  end
end

Given /^I have a "([^\"]+)" cookie set to "([^\"]+)"$/ do |key, value|
  headers = {}
  Rack::Utils.set_cookie_header!(headers, key, value)
  cookie_string = headers['Set-Cookie']

  Capybara.current_session.driver.browser.set_cookie(cookie_string)
end

Given /^I am logged in as "(.*)"$/ do |first_name|
	@user = User.find_by_first_name(first_name)
	# "/users/#{@user.id}"
	# puts page.current_path
	visit path_to("/users/#{@user.id}")
end

# given step definitions
Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user_params|
    params = default_user_params.merge(user_params)
    default_user_params['sid'] = rand.to_s[2..9]
    #default_user_params.merge(user_params)
    User.create!(default_user_params.merge(user_params))
  end
end

Given /the following timesheets exist/ do |timesheets_table|
  timesheets_table.hashes.each do |timesheet|
    Timesheet.create!(timesheet) end
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
  elsif user_type == "facilitator"
    OmniAuth.config.mock_auth[:google_oauth2] = 
      OmniAuth::AuthHash.new({:provider => 'google_oauth2',
        :uid => '27',
        :info => {
          :name => 'facilitator',
          :email => 'facilitator@berkeley.edu'
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
  if not_admin
    #!(page.should have_content('Admin'))
    !(page.should have_content('All Users'))
 else
    page.should have_content('All Users')
  end
end

Given /^I am viewing the LEP homepage$/ do
end

When /^I sign in$/ do
  visit "/auth/google_oauth2"
end

When /^I press submit for the form$/ do
  page.execute_script("$('#submit').submit()")
end

# When step definitions
When /^I view the LEP page$/ do
end

When /^I (de)?activate (.+)$/ do |deactivate, user|
  @other_user = User.find_by_first_name(user)
  if deactivate
    click_link('Deactivate')
  else
    click_link('Activate')
  end
end
  
Then /^that student should be (de)?activated$/ do |deactivated| 
  status = User.find(@other_user.id).active
  if deactivated
    status.should be_false
  else
    status.should be_true
  end
end

When /^I (make)?(remove)? (.+) as an admin$/ do |make, remove, user|
  @other_user = User.find_by_first_name(user)
  if make
    click_link('Grant Admin')
  else
    within find('tr', text: "#{@other_user.first_name}") do
      click_link('Revoke admin')
    end
  end
end

When /^I (make)?(remove)? (.+) as a facilitator$/ do |make, remove, user|
  @other_user = User.find_by_first_name(user)
  if make
    click_link('Grant Facilitator')
  else
    within find('tr', text: "#{@other_user.first_name}") do
      click_link('Revoke Facilitator')
    end
  end
end
  
Then /^that user should (not )?be an admin$/ do |not_admin| 
  status = User.find(@other_user.id).admin
  if not_admin
    status.should be_false
  else
    status.should be_true
  end
end

Then /^that user should (not )?be a facilitator$/ do |not_facil| 
  status = User.find(@other_user.id).facilitator
  if not_facil
    status.should be_false
  else
    status.should be_true
  end
end

When /^(?:|I )click "(.*)"$/ do |button|
  %{I click (button)}
end

# Then step definitions
Then /^I should be at the LEP (.*) home page$/ do |user_type|
end

When /^the following pairings have been generated:$/ do |pairs|
  pairs.hashes.each do |pair|
    Pair.create(member1: pair['member1'], member2: pair['member2'], member3: pair['member3'], languages: pair['languages'].split(','))
  end
end

When /^I view pairs$/ do
  visit '/admins'
end

Then /^I should see three pairs$/ do
  # including the headers, there should be 4 rows
  page.all('table#pairs.table tr').count.should == 4
end

Then /^there should be one pair$/ do
  page.all('table#pairs.table tr').count.should == 2
end

Then /^I should see the following pair ids:$/ do |ids|
=begin
  _ids = ids.gsub(' ', '').split(',')
  _ids.each do |id|
    puts id
    page.should have_content(id)
  end
=end
end

Given /^the following applications have been submitted:$/ do |users|
  users.hashes.each do |user|
    User.create(id: user['id'], first_name: user['first_name'], last_name: user['last_name'], fluent_languages: user['fluent_languages'].split(','), first_lang_preference: user['first_lang_preference'], first_lang_proficiency: user['first_lang_proficiency'], second_lang_preference: user['second_lang_preference'], second_lang_proficiency: user['second_lang_proficiency'], time_preference: user['time_preference'].split(','), hours_per_week: user['hours_per_week'])
  end
end

When /^I generate pairings$/ do
end


# Given(/^I am logged in as admin (\d+)$/) do |arg1|
#   @user = User.find_by_id(1)
#   puts @user
#   visit path_to("/admins/#{@user.id}")
#   puts page.current_path
# end

When(/^I set the deadline to "(.*)"$/) do |new_deadline|
  puts page.current_path
  page.execute_script("$('#deadline-datepicker').datepicker('setDate', '#{new_deadline}');")
end

When(/^I set the date to "(.*)"$/) do |date|
  puts page.current_path
  page.execute_script("$('#timesheet-datepicker').datepicker('setDate', '#{date}');")
end

When(/^I edit the application as "(.*)"$/) do |first_name|
  @user = User.find_by_first_name(first_name)
  puts @user.id
  visit path_to("/users/#{@user.id}/edit")
  puts page.current_path
end

When(/^I download the analytics$/) do
  click_link('Download users') 
end
