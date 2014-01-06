#!/usr/bin/env ruby



#create an array of students

students = [
 { :name =>'Andrey', 	:cohort => :January},
 { :name =>'James', 	:cohort => :January},
 { :name =>'Peter', 	:cohort => :January},
 { :name =>'Berta', 	:cohort => :January},
 { :name =>'Megan', 	:cohort => :January},
 { :name =>'Jorja', 	:cohort => :January},
 { :name =>'Nabin', 	:cohort => :January},
 { :name =>'Biwek', 	:cohort => :January},
 { :name =>'Colin', 	:cohort => :January},
 { :name =>'Abraham', 	:cohort => :January},
 { :name =>'Ayaz', 		:cohort => :January},
 { :name =>'Rolando', 	:cohort => :January},
 { :name =>'Kalle', 	:cohort => :January},
 { :name =>'Roy', 		:cohort => :January},
 { :name =>'Liviu', 	:cohort => :January},
 { :name =>'Makis', 	:cohort => :January}
]

# print the header
def print_header
	puts '___________________________________________'
	puts 'The students of my cohort at Makers Academy'
	puts '___________________________________________'
end

# print the body of the table with student names
def print(students)
	students.each do |student| 
		puts "#{student[:name]}		(#{student[:cohort]} cohort)" 
	end
end

# print the footer
def print_footer(students)
	puts '___________________________________________'
	puts "Overall we have #{students.length} great students"
	puts '___________________________________________'
end

# call the methods
print_header
print(students)
print_footer(students)

