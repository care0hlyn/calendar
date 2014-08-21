require 'active_record'
require './lib/event'
require 'pry'

database_configuration = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configuration["development"]
ActiveRecord::Base.establish_connection(development_configuration)

def whitespace
  puts "\n"
end

def header
  system 'clear'
end

def main_menu
  loop do
    puts "Press 1 to create a new event"
    puts "Press 2 to delete an event"
    puts "Press 3 to edit an event"
    puts "Press 4 to list all events"
    puts "Press 'x' to exit the program"
    menu_choice = gets.chomp
    if menu_choice == '1'
      create_event
    elsif menu_choice == '2'
      delete_event
    elsif menu_choice == '3'
      edit_event
    elsif menu_choice == '4'
      list_events
    elsif menu_choice == 'x'
      puts "Goodbye!"
      exit
    else
      puts "Please input a valid option"
      main_menu
    end
  end
end

def create_event
  header
  puts "What is the description of your event?"
  description = gets.chomp
  puts "What is the location of your event?"
  location = gets.chomp
  puts "What is the start date and time of your event? (YYYY-MM-DD HH:MM)"
  start_time = gets.chomp
  puts "What is the end date and time of your event? (YYYY-MM-DD HH:MM)"
  end_time = gets.chomp
  event = Event.create(description: description, location: location, start: start_time, :end => end_time)
  puts "#{event.description} | #{event.location} | #{event.start} | #{event.end}"
end

def list_events
  header
  Event.all.each { |event| puts "#{event.id}" + " | " + "#{event.description}" }
end

def delete_event
  header
  list_events
  puts "Enter index # of event to delete:"
  delete = Event.find_by(id: gets.chomp.to_i)
  delete.destroy
  puts "#{delete.description} has been deleted."
end

def edit_event
  header
  list_events
  whitespace
  puts "Ender the index # of the event you would like to edit:"
  @chosen_event = Event.find_by(id: gets.chomp.to_i)
    # binding.pry
  puts "Would you like to edit the description? Y or N"
  desc_choice = gets.chomp.downcase
  if desc_choice ==  'y'
    edit_description
  elsif desc_choice == 'n'
    puts "Would you like to edit the location? Y or N"
    loc_choice = gets.chomp.downcase
    if loc_choice == 'y'
      edit_location
    elsif loc_choice == 'n'
      puts "Would you like to edit the start date and time? Y or N"
      start_choice = gets.chomp.downcase
      if start_choice == 'y'
        edit_start
      elsif start_choice == 'n'
        puts "Would you like to edit the end time? Y or N"
        end_choice = gets.chomp
        if end_choice == 'y'
          edit_end
        elsif end_choice == 'n'
          main_menu
        end
      end
    end
  end
end

def edit_description
  header
  puts "What would you like the new description to be?"
  whitespace
  @chosen_event.update(description: gets.chomp)
  puts "Thanks! Your event is now: #{@chosen_event.description} | #{@chosen_event.location} | #{@chosen_event.start} | #{@chosen_event.end}"
  main_menu
end

def edit_location
  header
  puts "What would you like the new location to be?"
  whitespace
  @chosen_event.update(location: gets.chomp)
  puts "Thanks! Your event is now: #{@chosen_event.description} | #{@chosen_event.location} | #{@chosen_event.start} | #{@chosen_event.end}"
  main_menu
end

def edit_start
  header
  puts "What would you like the new start time to be? (YYYY-MM-DD HH:MM)"
  whitespace
  @chosen_event.update(start: gets.chomp)
  puts "Thanks! Your event is now: #{@chosen_event.description} | #{@chosen_event.location} | #{@chosen_event.start} | #{@chosen_event.end}"
  main_menu
end

def edit_end
  header
  puts "What would you like the new end time to be? (YYYY-MM-DD HH:MM)"
  whitespace
  @chosen_event.update(:end => gets.chomp)
  puts "Thanks! Your event is now: #{@chosen_event.description} | #{@chosen_event.location} | #{@chosen_event.start} | #{@chosen_event.end}"
  main_menu
end

main_menu
