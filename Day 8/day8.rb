require 'byebug'

def input
  file = File.read('input.txt')
  input = file.split("\n").map do |line|
    line.split(" | ")
  end
  input = input.map do |line|
    line.map do |segment|
      segment.split
    end
  end
  input
end

def unqiue_segments(array)
  # num_of_letters_hash = {  0 => 0,
  #           1 => 0,
  #           2 => 0,
  #           3 => 0,
  #           4 => 0,
  #           5 => 0,
  #           6 => 0,
  #           7 => 0,
  # }
  count = 0
  num_of_letters = input.flatten.map do |letters|
    letters.length
  end
  num_of_letters.each do |num|
    count += 1 if num == 2 || num == 3 || num == 4 || num == 7
  end
  return count
end

def one(pattern)
  pattern.select { |letters| letters.length == 2 }
end

def seven(pattern)
  pattern.select { |letters| letters.length == 3 }
end

def four(pattern)
  pattern.select { |letters| letters.length == 4 }
end

def eight(pattern)
  pattern.select { |letters| letters.length == 7 }
end

def nine(pattern)
  pattern.select do |letters|
    (letters.chars - four(pattern).first.chars).length == 2 && letters.chars.length == 6
  end
end

# def six(pattern)
#   remianing = pattern - nine(pattern)
#   remianing.select do |letters|
#     letters.length == 6
#   end
# end

def three(pattern)
  pattern.select do |letters|
    (letters.chars - one(pattern).first.chars).length == 3 && letters.chars.length == 5
  end
end

def two(pattern)
  pattern.select do |letters|
    (letters.chars - three(pattern).first.chars - four(pattern).first.chars).length == 1 && letters.chars.length == 5
  end
end

def five(pattern)
  remianing = pattern - two(pattern) - three(pattern)
  remianing.select do |letters|
    letters.length == 5
  end
end

def six(pattern)
  pattern.select do |letters|
    (one(pattern).first.chars - letters.chars).length == 1 && letters.chars.length == 6
  end
end

def zero(pattern)
  remianing = pattern - six(pattern) - nine(pattern)
  remianing.select do |letters|
    letters.length == 6
  end
end


p six(input[0][0])

def line_score(line)
  score_array = []
  numbers = line[1].map do |letters|
    score_array << 1 if letters.chars.sort.join == one(line[0]).first.chars.sort.join
    score_array << 2 if letters.chars.sort.join == two(line[0]).first.chars.sort.join
    score_array << 3 if letters.chars.sort.join == three(line[0]).first.chars.sort.join
    score_array << 4 if letters.chars.sort.join == four(line[0]).first.chars.sort.join
    score_array << 5 if letters.chars.sort.join == five(line[0]).first.chars.sort.join
    score_array << 6 if letters.chars.sort.join == six(line[0]).first.chars.sort.join
    score_array << 7 if letters.chars.sort.join == seven(line[0]).first.chars.sort.join
    score_array << 8 if letters.chars.sort.join == eight(line[0]).first.chars.sort.join
    score_array << 9 if letters.chars.sort.join == nine(line[0]).first.chars.sort.join
    score_array << 0 if letters.chars.sort.join == zero(line[0]).first.chars.sort.join
  end
  score_array.join.to_i
end


def output_by_line(lines)
  # line_scores = []
  lines.map do |line|
    line_score(line)
  end
end

def total

end

p line_score(input[0])

p output_by_line(input).sum
