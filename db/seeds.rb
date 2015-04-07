# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

jane = {first_name: 'Jane', 
		last_name: 'Doe', 
		sid: '12345678', 
		email: 'example@gmail.com',
		academic_title: 'Undergraduate',
		major: 'Computer Science', 
		residency: 'Domestic', 
		gender: 'Female', 
		gender_preference: 'Female',
		fluent_languages: ['English'],
		lang_additional_info: '',
		first_lang_preference: 'French', 
		first_lang_proficiency: 'elementary', 
		second_lang_preference: 'Arabic', 
		second_lang_proficiency: 'elementary',
		time_preference: ['Monday', 'Tuesday'], 
		hours_per_week: '1',
		user_motivation: 'I will be studying abroad.', 
		user_plan: 'I will set a regular meeting time with them.',
		group_leader: 'Yes',
		admin: false,
		active: true,
		facilitator: false
		}

shana = {first_name: 'Shana',
    	email: 'shanahu@berkeley.edu',
    	admin: true,
    	facilitator: false}

iris = {first_name: 'Iris',
	    email: 'iriswang@berkeley.edu',
	    admin: true,
		facilitator: false}

robyn = {first_name: 'Robyn', 
		last_name: 'Zhang', 
		sid: '22223333', 
		email: 'robynz@berkeley.edu',
		academic_title: 'Undergraduate',
		major: 'Computer Science', 
		residency: 'Domestic', 
		gender: 'Female', 
		gender_preference: 'Female',
		fluent_languages: ['English'], 
		lang_additional_info: '',
		first_lang_preference: 'Chinese', 
		first_lang_proficiency: 'intermediate', 
		second_lang_preference: 'Spanish', 
		second_lang_proficiency: 'elementary',
		time_preference: ['Monday', 'Tuesday'], 
		hours_per_week: '2',
		user_motivation: 'I will be studying abroad.', 
		user_plan: 'I will set a regular meeting time with them.',
		admin: true,
		active: true,
		facilitator: false
		}

admin = { first_name: 'Admin', email: 'admin@berkeley.edu', admin: true, facilitator: false}

admin2 = { first_name: 'adminmeister', 
  		sid: '223333', 
		email: 'swchoi727@berkeley.edu',
		academic_title: 'Undergraduate',
		major: 'Computer Science', 
		residency: 'Domestic', 
		gender: 'Female', 
		gender_preference: 'Female',
		fluent_languages: ['English'], 
		lang_additional_info: '',
		first_lang_preference: 'Chinese', 
		first_lang_proficiency: 'intermediate', 
		second_lang_preference: 'Spanish', 
		second_lang_proficiency: 'elementary',
		time_preference: ['Monday'],
		hours_per_week: '2',
		user_motivation: 'I will be studying abroad.', 
		user_plan: 'I will set a regular meeting time with them.',
		active: true,
	    admin: true,
	    facilitator: false
		}

jason = { first_name: 'Jason',
   	 	last_name: 'Jia',
  		sid: '12345678',
  		email: 'jasonjia@berkeley.edu',
  		academic_title: 'Undergraduate',
      major: 'Computer Science', 
      residency: 'Domestic', 
      gender: 'Male', 
      gender_preference: 'Female',
      fluent_languages: ['English, Mandarin'],
      lang_additional_info: '',
      first_lang_preference: 'French', 
      first_lang_proficiency: 'intermediate', 
      second_lang_preference: 'Spanish', 
      second_lang_proficiency: 'elementary',
      time_preference: ['Monday'], 
      hours_per_week: '2',
      user_motivation: 'I will be studying abroad.', 
      user_plan: 'I will set a regular meeting time with them.',
      active: true,
	    admin: false,
	    facilitator: false
		}

users = User.create!([robyn, jane, admin2, iris, jason])

russian = {language: 'Russian',
           day: 'Monday',
           time: '2-3PM',
           location: 'FSM'}
english1 = {language: 'English',
            day: 'Wednesday',
            time: '5-6PM',
            location: '201B Chavez'}
mandarin = {language: 'Mandarin',
            day: 'Wednesday',
            time: '6-7PM',
            location: '2 Evans'}
english2 = {language: 'English',
            day: 'Thursday',
            time: '2-3PM',
            location: '201B Chavez'}
korean =  {language: 'Korean',
            day: 'Friday',
            time: '4-5PM',
            location: '201B Chavez'}
swedish =  {language: 'Swedish',
            day: 'Friday',
            time: '4-5PM',
            location: 'SLC Atrium'}
german =  {language: 'German',
            day: 'Friday',
            time: '6-7PM',
            location: '151 Chavez'}
groups = Group.create!([russian, english1, mandarin, english2, korean, swedish, german])

