class String
	def letters?(value)
		value.split("").each do |char|
  			char =~ /[[:alpha:]]/
  		end
	end
end

class Hangman
	def initialize
		puts "Hangman initialized!"
		new_game
	end

	def new_game
		choose_word
		play
	end

	#choose a word
	def choose_word
		dictionary = File.open ('5desk.txt')
		selection = Array.new
		dictionary.each do |word|
			if word.length >= 5 && word.length <= 12
				selection << word
			end
		end
		@@word = selection.sample.split("")
		@@progress = Array.new
		@@word[0..-2].length.times do
			@@progress << "_"
		end
	end

	def play
		until @@progress.none? {|space| space == "_"}
			puts @@word.join("") #debug
			print @@progress.join(" ") + "\r\n"
			puts "Guess a letter or full word"
			guess = gets.chomp
			if guess.length > 0
				if guess.length == 1
					@@word.each_with_index do |letter,index|
						if guess == letter
							@@progress[index] = guess
						end
					end
				else # guess.length > 1
					if guess == @@word.join
						@@word.each_with_index do |letter,index|
							@@progress[index] = @@word[index]
						end
					else
						puts "Incorrect!"
					end
				end
			else
				puts "Input error: not a letter or word."
			end
		end
	end
	
end

game = Hangman.new