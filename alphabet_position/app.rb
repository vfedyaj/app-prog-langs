class App

  def self.start
    menu
  end

  def self.alph
    puts "\nEnter your sentence"
    res = gets
    res = res.delete(" " "'" "." ",").downcase
    indexes = ('a'..'z').each_with_index.map{|l,i| [l, i+1]}.to_h
    res = res.chars.map{|l| indexes[l]}
    puts "\nResult: #{res.join(" ")}"

    puts "\nAgain?\n"
    menu
  end

  def self.menu
    puts "Choose: 1 - Enter string, 2 - Exit"

    choice = gets.to_i

    if choice == 1
      alph
    elsif choice == 2
      exit
    else
      puts "\nWrong symbol. Try again"
      menu
    end

  end

end

x = App
x.start