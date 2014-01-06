#!/usr/bin/env ruby



#create an array of students

students_old = [
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

#ask for user inout
def input_students 
	puts "Please enter the names of the students.\nTo finish, just hit return twice."
	#create an empty array
	students = []
	#get the first name
	name = gets.chomp
	#while name is not empty repeat
	while !name.empty? do
		#add student hash to the array
		students << {:name => name, :cohort => :January}
		puts "Now, we have #{students.length} students."
		#get anothe rname from user
		name = gets.chomp 
	end
	#return the array of students
	students
end

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
students = input_students

print_header
print(students_old)
print_footer(students_old)

print_header
print(students)
print_footer(students)

