require 'byebug'

def input
  file = File.read('input.txt')
  input = file.split("\n")
  input
end

def delete(string)
  if string.gsub(/(\[\]|<>|\{\}|\(\))/, "").length < string.length
    removed = string.gsub(/(\[\]|<>|\{\}|\(\))/, "")
    delete(removed)
  else
    return string
  end
end

def find_pair(string)
  string[/(.>)|(.})|(.])|(.[)])/]
end

def illegal_char(string)
  string[1]
end

def corruptions(array)
  corrupt_chars = []
  array.each do |string|
    if find_pair(delete(string))
      corrupt_chars << illegal_char(find_pair(delete(string)))
    end
  end
  corrupt_chars
end

def syntax_error(array)
  scores = {
      ')' => 3,
      ']' => 57,
      '}' => 1197,
      '>' => 25137
}
  score_array = array.map do |char|
    scores[char]
  end
  score_array.sum
end

def incomplete(array)
  incomplete_strings = array.reject { |string| find_pair(delete(string)) }
  deleted = incomplete_strings.map do |string|
    delete(string)
  end
  deleted
end

def incomplete_endings(array)
  opposite = {
      '(' => ')',
      '[' => ']',
      '{' => '}',
      '<' => '>'
  }

  endings = array.map do |string|
    string.chars.reverse.map do |char|
      opposite[char]
    end.join
  end
  return endings
end

def ending_score(ending)
  scores = {
      ')' => 1,
      ']' => 2,
      '}' => 3,
      '>' => 4
  }

  total_score = 0
  ending.chars.each do |char|
    total_score *= 5
    total_score += scores[char]
  end
  return total_score
end

def ending_scores(array)
  endings = incomplete_endings(incomplete(array))
  scores = endings.map do |ending|
    ending_score(ending)
  end
  scores
end

def middle_score(input)
  index = (input.length + 1) / 2
  input.sort[index -1]
end
