class RockPaperScissors

  def self.start
    menu
  end
  def self.game

    moves = %w[Rock Paper Scissors]

    puts "\nChoose your move: 1 - Rock, 2 - Paper, 3 - Scissors"
    user_move = gets.to_i - 1

    if user_move >= 0 && user_move <= 2
      pc_move = rand(3)
      puts "\nRock, Paper, Scissors!"
      puts "\nYour choice: " + moves[user_move]
      puts "PC's choice: " + moves[pc_move]

      if user_move === 0 && pc_move === 2 || user_move === 1 && pc_move === 0 || user_move === 2 && pc_move === 1
        puts "\nYou won!"
      elsif user_move === 0 && pc_move === 1 || user_move === 1 && pc_move === 2 || user_move === 2 && pc_move === 0
        puts "\nYou lose!"
      else
        puts "\nDraw. Let's try again"
        game
      end

    else
      puts "\nWrong symbol! Try again\n"
      game
    end

    puts "\nWanna play again?\n"
    menu

  end

  def self.menu
    puts "Choose: 1 - Play, 2 - Exit"

    choice = gets.to_i

    if choice == 1
      game
    elsif choice == 2
      exit
    else
      puts "\nWrong symbol. Try again"
      menu
    end

  end

end

x = RockPaperScissors
x.start