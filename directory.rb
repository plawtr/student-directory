#!/usr/bin/env ruby

require 'date'


def interactive_menu
	
	students = []

	loop do 
		# - print the menu and ask the user what to do
		puts '___________________________________________'
		puts "1. Input the students."
		puts "2. Show the students."
		puts "9. Exit."
		puts '___________________________________________'

		# - read the input and save it into a variable
		selection = gets.chomp

		# - do what the user has asked

		case selection
		when "1" # input students
			students = input_students(students)
		when "2" # show students
			print_header
			print_counter = print_by_cohort(students)
			print_footer(students, print_counter)
		when "9" 
			exit
		else 
			puts "I do not know what you mean. Try again."
		end 

	end

end


#ask for user input
def input_students(students) 
	puts "Please enter the names of the students and their cohorts (default is #{@default_cohort}).\nTo finish, just hit return two times."
	#get the first name
	print "Student name? "
	name = new_chomp(gets)
	print "Student cohort month? (Usage: January or Jan, etc.)? " 
	cohort = validate(gets.chomp)

	#while name and cohort are both not empty repeat
	while !name.empty? do
		#add student hash to the array
		students << {:name => name, :cohort => cohort}
		puts "Now, we have #{students.length} student" + (students.length == 1 ? "" : "s")  
		#get another name/cohort from user
		print "Student name? "
		name = gets.chomp
		print "Student cohort? "
		cohort = validate(gets.chomp)
	end
	# sort the hash
	students.sort_by!{|hash| hash[:name]  }
	#return the hash of students
	students
end

def validate(cohort)
	cohort = @default_cohort if cohort.empty?
	cohort.capitalize!
	while !Date::ABBR_MONTHNAMES.include? cohort and !Date::MONTHNAMES.include? cohort do
		print "Your month does not appear to be valid. Usage: January or Jan, etc. Please reenter: "
		cohort = gets.chomp
		cohort.capitalize!
	end
	cohort = Date::MONTHNAMES[Date::ABBR_MONTHNAMES.index(cohort)] if Date::ABBR_MONTHNAMES.include? cohort
	cohort
end

# print the header
def print_header
	puts '___________________________________________'
	puts 'The students of my cohort at Makers Academy'
	puts 'No  '+ "Name".ljust(@no_chars+2)+'Cohort'.center(@no_chars+17)
	puts '___________________________________________'
end

# print the body of the table with student names
def print_only_with_conds(students)
	print_counter = 1
	array_counter = 0
	while array_counter < students.length do
		if students[array_counter][:name].length <= @no_chars #check the student name is shorter than @no_chars
				puts "#{print_counter}.  " + "#{students[array_counter][:name]}".ljust(@no_chars+2, '.') + "#{students[array_counter][:cohort]}".rjust(@no_chars+6, '.') 
				print_counter+=1
		end	
		array_counter+=1			
	end
	puts '___________________________________________' unless students.empty?
	print_counter-=1
end

# print the footer
def print_footer(students, print_counter)
	puts "Overall we have #{students.length} great student" + (students.length == 1 ? "" : "s" )
	puts '___________________________________________'
	puts "We have #{print_counter} student" + (print_counter == 1 ? "" : "s") + " whose name is fewer than\n#{@no_chars} characters."
	puts '___________________________________________'
end

def print_by_cohort(students)
        print_counter = 0;
        Date::MONTHNAMES.each do |month|
                if !month.nil?
                        print_counter+=print_only_with_conds(students.select{|entry| entry[:cohort] == month})
                end
        end
    return print_counter
end

def new_chomp(input)
        is_penultimate_char_carriage = (input[-2] == "\r") or (input[-2] == "\n")
        #chop off the last character and penultimate character if it is a carriage return
        input.slice(0...(-1*(is_penultimate_char_carriage ? 2 : 1)))

end


@no_chars = 12
@default_cohort = "January"
print_counter = 0

# call the methods



interactive_menu



        
                

