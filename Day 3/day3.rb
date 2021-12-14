require 'byebug'

def read_input
  file = File.open('inputday3.txt')
  input = file.readlines.map(&:chomp)
  file.close
  input
end

test_array = [ '00100',
'11110',
'10110',
'10111',
'10101',
'01111',
'00111',
'11100',
'10000',
'11001',
'00010',
'01010' ]

# # test_array = ["11110", "10110", "10111", "10101", "11100", "10000", "11001"]

def gamma(array, position)
  common = 0
  array.each do |bin|
    if bin[position].to_i == 1
      common += 1
    else
      common -= 1
    end
  end

  if common >= 0
    return '1'
  else
    return '0'
  end
end

# p 'here'
# p gamma(test_array, 1)

# def most_common_array

#   bin_array = [ gamma(read_input, 0), gamma(read_input, 1), gamma(read_input, 2), gamma(read_input, 3), gamma(read_input, 4),
#                     gamma(read_input, 5), gamma(read_input, 6), gamma(read_input, 7), gamma(read_input, 8), gamma(read_input, 9),
#                     gamma(read_input, 10), gamma(read_input, 11) ]

# end

# bin_array = [ gamma(read_input, 0), gamma(read_input, 1), gamma(read_input, 2), gamma(read_input, 3), gamma(read_input, 4),
#                 gamma(read_input, 5), gamma(read_input, 6), gamma(read_input, 7), gamma(read_input, 8), gamma(read_input, 9),
#                 gamma(read_input, 10), gamma(read_input, 11) ]

# most_common = bin_array.join

# alt = most_common.chars.map do |digit|
#   if digit == '1'
#     '0'
#   else
#     '1'
#   end
# end

# # p least_common = alt.join
# # p most_common[0]
# # p most_common_array[2]

def oxygen(array, i)
  #select (then repeat) each element where most common bit == bit at that position
  # p gamma(array, i)
  # p array
  # p i
  updated = array.select do |bin|
    # p bin
    bin[i] == gamma(array, i)
  end
  # p updated

  i+=1
  if updated.length > 1
    oxygen(updated, i)
  else
    return updated
  end
end

p oxygen(read_input, 0)

p "110011101111".to_i(2)
p "001101010011".to_i(2)
p "110011101111".to_i(2)*"001101010011".to_i(2)


# i = 0
# oxygen(array, i)

# def oxygen_final(array)

#   updated = oxygen(array, i)
#   i += 1
#   further = oxygen(updated, i)
#     i += 1
#   more = oxygen(further, i)
# end

# p oxygen_final(test_array)

# input = read_input

# (0..input[0].size - 1).each do |i|
#   break if input.length == 1
#   count = 0
#   input.each do |bin|
#     count += bin[i] == '0' ? -1 : 1
#   end

#   num = count >= 0 ? '1' : '0'

#   input.select! do |bin|
#     bin[i] == num
#   end
# end

# p input

#  p '110011101111'.to_i(2)
#  p "001111001000".to_i(2)
