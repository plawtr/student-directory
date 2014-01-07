#!/usr/bin/env ruby

require 'date'

#create an array of students

=begin students_old = [
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
=end

#ask for user inout
def input_students (default_cohort)
	puts "Please enter the names of the students and their cohorts (default is January).\nTo finish, just hit return two times."
	#create an empty array
	students = []
	#get the first name
	print "Student name? "
	name = gets.chomp
	print "Student cohort? " 
	cohort = validate(gets.chomp, default_cohort)

	#while name and cohort are both not empty repeat
	while !name.empty? do
		#add student hash to the array
		students << {:name => name, :cohort => cohort}
		puts "Now, we have #{students.length} student" + (students.length == 1 ? "" : "s")  
		#get another name/cohort from user
		print "Student name? "
		name = gets.chomp
		print "Student cohort? "
		cohort = validate(gets.chomp, default_cohort)
	end
	# sort the hash
	students.sort_by!{|hash| hash[:name]  }
	#return the hash of students
	students
end

def validate(cohort, default_cohort)
	cohort = default_cohort if cohort.empty?
	while !Date::ABBR_MONTHNAMES.include? cohort and !Date::MONTHNAMES.include? cohort do
		print "Your month does not appear to be valid. Usage: January or Jan, etc. Please reenter: "
		cohort = gets.chomp
	end
	cohort
end

# print the header
def print_header
	puts '___________________________________________'
	puts 'The students of my cohort at Makers Academy'
	puts 'No  '+ "Name".ljust(14)+'Cohort'.center(35)
	puts '___________________________________________'
end

# print the body of the table with student names
def print_only_with_conds(students, no_chars)
	print_counter = 1
	array_counter = 0

	while array_counter < students.length do
		if students[array_counter][:name].length <= no_chars #check the student name is shorter than no_chars
				puts "#{print_counter}.  " + "#{students[array_counter][:name]}".ljust(14, '.') + "#{students[array_counter][:cohort]}".rjust(20, '.') 
				print_counter+=1
		end	
		array_counter+=1			
	end
	print_counter-1
end

# print the footer
def print_footer(students, number_with_conds, no_chars)
	puts '___________________________________________'
	puts "Overall we have #{students.length} great student" + (students.length == 1 ? "" : "s" )
	puts '___________________________________________'
	puts "We have #{number_with_conds} student" + (number_with_conds == 1 ? "" : "s") + " whose name is fewer than\n#{no_chars} characters."
	puts '___________________________________________'
end

no_chars = 12
default_cohort = "January"

# call the methods
students = input_students(default_cohort)


#print_header
#print(students_old)
#print_footer(students_old)

print_header
number_with_conds = print_only_with_conds(students, no_chars)
print_footer(students, number_with_conds, no_chars)

