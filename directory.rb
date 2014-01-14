#!/usr/bin/env ruby

require 'date'

def interactive_menu

	loop do 
		print_menu
		# - read the input and save it into a variable
		process(gets.chomp)
	end

end

#ask for user input
def input_students 
	puts "Please enter the names of the students and their cohorts (default is #{@default_cohort}).\nTo finish, just hit return two times."
	#get the first name
	print "Student name? "
	name = gets.chomp
	print "Student cohort month? (Usage: January or Jan, etc.)? " 
	cohort = validate(gets.chomp)

	#while name and cohort are both not empty repeat
	while !name.empty? do
		#add student hash to the array
		@students << {:name => name, :cohort => cohort}
		puts "Now, we have #{@students.length} student" + (@students.length == 1 ? "" : "s")  
		#get another name/cohort from user
		print "Student name? "
		name = gets.chomp
		print "Student cohort? "
		cohort = validate(gets.chomp)
	end
	# sort the hash
	@students.sort_by!{|hash| hash[:name]  }

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
def print_footer(print_counter)
	puts "Overall we have #{@students.length} great student" + (@students.length == 1 ? "" : "s" )
	puts '___________________________________________'
	puts "We have #{print_counter} student" + (print_counter == 1 ? "" : "s") + " whose name is fewer than\n#{@no_chars} characters."
	puts '___________________________________________'
end

def print_students_by_cohort
        print_counter = 0;
        Date::MONTHNAMES.each do |month|
                if !month.nil?
                        print_counter+=print_only_with_conds(@students.select{|entry| entry[:cohort] == month})
                end
        end
    return print_counter
end

def print_menu
	# - print the menu and ask the user what to do
	puts '___________________________________________'
	puts "1. Input the students."
	puts "2. Show the students."
	puts "3. Save the list to students.csv."
	puts "4. Load the list from students.csv."
	puts "9. Exit."
	puts '___________________________________________'
end

def show_students
	print_header
	print_counter = print_students_by_cohort
	print_footer(print_counter)
end

def process(selection)
	case selection
	when "1" # input students
		input_students
	when "2" # show students
		show_students
	when "3"
		save_students
	when "4"
		load_students
	when "9" 
		exit
	else 
		puts "I do not know what you mean. Try again."
	end 
end

def save_students
	# open the file for writing
	file=File.open("students.csv", "w") 
	@students.each do |student|
		student_data = [student[:name], student[:cohort]]
		csv_line = student_data.join(",")
		file.puts csv_line
	end 
	file.close
end

def load_students
	file = File.open("students.csv", "r")
	file.readlines.each do |line|
		name, cohort = line.chomp.split(",")
		@students << {:name => name, :cohort=> cohort}
	end
	file.close
end


@no_chars = 12
@default_cohort = "January"
print_counter = 0
@students = [] # an empty array accessible to all methods

# call the methods

interactive_menu



        
                

