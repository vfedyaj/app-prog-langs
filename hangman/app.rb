def hangman(count_attempts)

  picture = File.open(count_attempts.to_s + ".txt"){ |file| file.read }
  puts picture

end


words = File.open('words.txt'){ |file| file.read }
words = words.split
puts("================ HANGMAN ================")


loop do
  guess_word = words[rand(words.length - 1)]

  blanks = ''

  (0...guess_word.length).each { |i|
    blanks += '_'
  }

  attempts = 9
  hangman(attempts)

  loop do
    puts(blanks)
    letter = gets.chomp
    if guess_word.include? letter

      (0...guess_word.length).each { |i|
        if letter == guess_word[i]
          blanks[i] = letter
        end
      }
      if blanks == guess_word
        puts('You win')
        break
      end
    else
      puts('Wrong!')
      attempts -= 1

      hangman(attempts)

      if attempts == 0
        puts('Yoy lose!')
        puts('The word was -> ' + guess_word)
        break
      end
      print('Attempts left ')
      puts(attempts)
    end
  end

  print('Wanna play again? (Yes - 1, No - 0):  ')
  choice = gets.chomp

  if choice.to_i == 0
    break
  end
end




