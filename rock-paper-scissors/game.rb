def game
  moves = %w[Rock Paper Scissors]

  puts "Choose your move: 1 - Rock, 2 - Paper, 3 - Scissors"
  user_move = gets.to_i - 1
  if user_move >= 0 && user_move <= 2
    pc_move = rand(3)
    puts "Rock, Paper, Scissors!"
    puts "Your choice: " + moves[user_move]
    puts "PC's choice: " + moves[pc_move]
    if user_move === 0 && pc_move === 2 || user_move === 1 && pc_move === 0 || user_move === 2 && pc_move === 1
      puts "You won!"
    elsif user_move === 0 && pc_move === 1 || user_move === 1 && pc_move === 2 || user_move === 2 && pc_move === 0
      puts "You lose!"
    else
      puts "Draw. Let's try again"
      game
    end
  else
    puts "Wrong symbol! Try again"
    game
  end
end

game