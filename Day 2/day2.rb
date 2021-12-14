def read_input
  file = File.open('input.txt')
  input = file.readlines.map(&:chomp)
  file.close
  input
end

# p read_input

array_test = ["forward 2", "down 7", "down 8", "forward 9", "down 8", "forward 9", "forward 8"]

def forward(array)
  forward = 0
  depth = 0
  array.each do |direction|
   letters = direction.chars
    if letters.first == "f"
      forward += letters.last.to_i
    elsif  letters.first ==  "d"
      depth += letters.last.to_i
    else
      depth -= letters.last.to_i
    end
  end
  return (forward*depth)
end

def aim(array)
  forward = 0
  depth = 0
  aim = 0
  array.each do |direction|
   letters = direction.chars
    if  letters.first ==  "d"
      aim += letters.last.to_i
    elsif letters.first ==  "u"
      aim -= letters.last.to_i
    else letters.first == "f"
      distance = letters.last.to_i
      forward += distance
      depth += distance*aim
    end
  end
  return (forward*depth)
end

p aim(read_input)
