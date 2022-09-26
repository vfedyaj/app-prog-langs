class Calculator

  def self.start
    menu
  end

  def self.calc
    puts "\nEnter first value"
    a = gets
    while a.count("a-zA-Z") > 0 do
      puts "\nWrong symbol. Try again"
      a = gets
    end
    a = a.to_i
    puts "\nEnter second value"
    b = gets
    while b.count("a-zA-Z") > 0 do
      puts "\nWrong symbol. Try again"
      b = gets
    end

    b = b.to_i

    def self.action
      puts "\nChoose action: (+) (-) (*) (/)"
      i = gets.chomp
      if i == "+" || i == "-" || i == "*" || i == "/"
        return i
      else
        puts "\nWrong symbol. Try again"
        action
      end

    end

    sign = action

    if sign == "+"
      puts "\nResult: #{a + b}"
    elsif sign == "-"
      puts "\nResult: #{a - b}"
    elsif sign == "*"
      puts "\nResult: #{a * b}"
    else
      if a == 0 || b == 0
        puts "Error. You cannot divide by zero"
      else
        puts "\nResult: #{a / b}"
      end

    end

    puts "\nAgain?\n"
    menu

  end

  def self.menu
    puts "Choose: 1 - Calculate, 2 - Exit"

    choice = gets.to_i

    if choice == 1
      calc
    elsif choice == 2
      exit
    else
      puts "\nWrong symbol. Try again"
      menu
    end

  end

end

x = Calculator
x.start