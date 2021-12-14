require 'byebug'

def input
  file = File.read('input.txt')
  input = file.split("\n").map do |line|
    line.chars.map do |height|
      height.to_i
    end
  end
  input
end

p input

# choose number if number is less than +1 and -1 index and less than previous and next array at same index

def lowest_heights(input)
  levels =[]
  input.each_with_index do |line, line_index|
    if line_index == 0
      line.each_with_index do |height, height_index|
        if height_index == 0
          if height < line[height_index + 1] && height < input[line_index + 1][height_index]
            levels << height
          end
        elsif height_index == (line.length - 1)
          if height < line[height_index - 1] && height < input[line_index + 1][height_index]
            levels << height
          end
        else
          if height < line[height_index - 1] && height < line[height_index + 1] && height < input[line_index + 1][height_index]
            levels << height
          end
        end
      end
    elsif line_index == (input.length - 1)
      line.each_with_index do |height, height_index|
        if height_index == 0
          if height < line[height_index + 1] && height < input[line_index - 1][height_index]
            levels << height
          end
        elsif height_index == (line.length - 1)
          if height < line[height_index - 1] && height < input[line_index - 1][height_index]
            levels << height
          end
        else
          if height < line[height_index - 1] && height < line[height_index + 1] && height < input[line_index - 1][height_index]
            levels << height
          end
        end
      end
    else
      line.each_with_index do |height, height_index|
        if height_index == 0
          if height < line[height_index + 1] &&  height < input[line_index - 1][height_index] && height < input[line_index + 1][height_index]
            levels << height
          end
        elsif height_index == (line.length - 1)
          if height < line[height_index - 1] && height < input[line_index - 1][height_index] && height < input[line_index + 1][height_index]
            levels << height
          end
        else
          if height < line[height_index - 1] && height < line[height_index + 1] && height < input[line_index - 1][height_index] && height < input[line_index + 1][height_index]
            levels << height
          end
        end
      end
    end
  end
  return levels
end




p lowest_heights(input)

def risk_levels(input)
  risk = input.map do |height|
    height + 1
  end
  return risk.sum
end

p risk_levels(lowest_heights(input))
