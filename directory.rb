#!/usr/bin/env ruby



#create an array of students

students = [
'Andrey',
 'James',
 'Peter',
 'Berta',
 'Megan',
 'Jorja',
 'Nabin',
 'Biwek',
 'Colin',
 'Abraham',
 'Ayaz',
 'Rolando',
 'Kalle',
 'Roy',
 'Liviu',
 'Makis'
]

# print the header
def print_header
	puts '___________________________________________'
	puts 'The students of my cohort at Makers Academy'
	puts '___________________________________________'
end

# print the body of the table with student names
def print(names)
	names.each {|name| puts name} 
end

# print the footer
def print_footer(names)
	puts '___________________________________________'
	puts "Overall we have #{names.length} great students"
	puts '___________________________________________'
end

# call the methods
print_header
print(students)
print_footer(students)

