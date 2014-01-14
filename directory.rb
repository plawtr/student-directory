#!/usr/bin/env ruby

require 'date'
require 'csv' 

def interactive_menu

	loop do 
		print_menu
		# - read the input and save it into a variable
		process(STDIN.gets.chomp)
	end

end

#ask for user input
def input_students 
	puts "Please enter the names of the students and their cohorts (default is #{@default_cohort}).\nTo finish, just hit return two times."
	#get the first name
	print "Student name? "
	name = STDIN.gets.chomp
	print "Student cohort month? (Usage: January or Jan, etc.)? " 
	cohort = validate(STDIN.gets.chomp)

	#while name and cohort are both not empty repeat
	while !name.empty? do
		#add student hash to the array
		add_students(name, cohort)
		puts "Now, we have #{@students.length} student" + (@students.length == 1 ? "" : "s")  
		#get another name/cohort from user
		print "Student name? "
		name = STDIN.gets.chomp
		print "Student cohort? "
		cohort = validate(STDIN.gets.chomp)
	end
	# sort the hash
	@students.sort_by!{|hash| hash[:name]  }

end

def validate(cohort)
	cohort = @default_cohort if cohort.empty?
	cohort.capitalize!
	while !Date::ABBR_MONTHNAMES.include? cohort and !Date::MONTHNAMES.include? cohort do
		print "Your month does not appear to be valid. Usage: January or Jan, etc. Please reenter: "
		cohort = STDIN.gets.chomp
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
	puts "3. Save the list to a file."
	puts "4. Load the list from a file."
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
	when "1" 
		input_students
	when "2" 
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

def save_students(filename=get_filename)
	# open the file for writing
	File.open(filename, "w") do |file| 
		@students.each do |student|
			student_data = [student[:name], student[:cohort]]
			csv_line = student_data.join(",")
			file.puts csv_line
		end 
	puts "Saved #{@students.length} student" + (@students.length == 1 ? "" : "s") + " to #{filename}"
	end
end

def load_students(filename=get_filename)
	filename = @default_filename if !File.exists?(filename)
	CSV.foreach(filename) do |line|
		name, cohort = line
		add_students(name, cohort)
	end
	puts "Loaded #{@students.length} students" + (@students.length == 1 ? "" : "s") + " from #{filename}"
end


def try_load_students
	filename = ARGV.first #first argument from the command line
	return if filename.nil?
	if File.exists?(filename)
		load_students(filename)
		
	else 
		puts "Sorry, #{filename} does not exist."
		exit
	end
end

def add_students(name, cohort)
	@students << {:name => name, :cohort => cohort}
end

def get_filename
	print "File name? Press return for default #{@default_filename}:  "
	filename = STDIN.gets.chomp
	puts "#{filename} does not exist" if !File.exists?(filename)
	return @default_filename if filename.nil? 
	return filename
end


@no_chars = 12  #upper character limit for student name display 
@default_cohort = "January"
@default_filename = "students.csv"
print_counter = 0
@students = [] # an empty array accessible to all methods


try_load_students #try to load the file passed by ARGV
# call the methods

interactive_menu

