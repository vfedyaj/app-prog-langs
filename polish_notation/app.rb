def operator?(str)
  !str.match?(/[[:digit:]]/)
end

def operand?(str)
  !operator?(str) && str != ')'
end

def left_paren?(str)
  str.eql? '('
end

def right_paren?(str)
  str.eql? ')'
end

def stack_precedence(operator)
  if operator == '+' or operator == '-'
    1
  elsif operator == '*' or operator == '/' or operator == '%'
    return 2
  elsif operator == '^'
    return 3
  elsif operator == "cos" or operator == "sin" or operator == "tan" or operator == "cot"
    return 4
  else
    0
  end
end

def trigonometric?(str)
  str == "c" || str == "o" || str == "s" || str == "i" || str == "n" || str == "t" || str == "a"
end

def infix_to_prefix(str)

  Array stack = Array.new
  Array output = Array.new

  need_to_merge = false
  trigonometric = ""

  str.split(//).reject { |x| x == " " }.each { |i|
    case
    when left_paren?(i)
      stack << trigonometric + " " unless trigonometric.empty?
      stack << i

      trigonometric = ""
      need_to_merge = false
    when right_paren?(i)
      while stack.length != 0 && !left_paren?(stack.last) do
        el1 = output.pop
        el2 = output.pop
        el = stack.pop

        output.push(el + el2 + el1)
      end
      stack.pop
      need_to_merge = false

    when !operator?(i)
      output << output.pop.strip + i + " " if need_to_merge

      output << i + " " unless need_to_merge

      need_to_merge = true
    else

      if trigonometric?(i)
        trigonometric << i
        next
      end

      while stack.length != 0 && stack_precedence(i.to_s) <= stack_precedence(stack.last&.strip) do
        el1 = output.pop
        el2 = output.pop
        el = stack.pop

        output.push(el + el2 + el1)
      end

      stack.push(i + " ")
      need_to_merge = false
    end
  }

  while stack.length != 0 do

    el1 = output.pop
    el2 = output.pop
    el = stack.pop

    tmp = ""
    tmp << el unless el.nil?
    tmp << el2 unless el2.nil?
    tmp << el1 unless el1.nil?
    output.push(tmp)
  end

  output.last
end

def evaluate_equation(expr_str)
  Array stack = Array.new
  split_str = expr_str.split.reverse
  count = 0
  while (str = split_str[count]) != nil do
    if operand?(str)
      stack.push(str)
    elsif str == "cos" || str == "sin" || str == "tan" || str == "cot"
      x = stack.pop
      y = 0
      result = apply_operator(x, y, str)
      stack.push(result)
    else
      y = stack.pop
      x = stack.pop

      result = apply_operator(x, y, str)
      stack.push(result)
    end
    count += 1
  end
  stack.pop
end

def apply_operator(num1, num2, opr)
  if opr == '+'
    num1.to_i + num2.to_i
  elsif opr == '-'
    num1.to_i - num2.to_i
  elsif opr == '*'
    num1.to_i * num2.to_i
  elsif opr == '/'
    num1.to_i / num2.to_i
  elsif opr == '%'
    num1.to_i % num2.to_i
  elsif opr == '^'
    num1.to_i ** num2.to_i
  elsif opr == 'cos'
    Math.cos(num1)
  elsif opr == 'sin'
    Math.sin(num1)
  elsif opr == 'tan'
    Math.tan(num1)
  elsif opr == 'cot'
    1 / Math.tan(num1)
  end
end

result = infix_to_prefix("cos(10+1)")
res1 = evaluate_equation(result)
puts result
puts res1