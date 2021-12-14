def read_input
  file = File.open('input.txt')
  input = file.readlines.map(&:chomp).map(&:to_i)
  file.close
  input
end

def depth_increases(arr)
  increases_times = 0
  arr.each_with_index do |number, index|
    next if index == 0
    if number > arr[index - 1]
      increases_times +=1
    end
  end
  increases_times
end

puts depth_increases(read_input)

def three_peat(arr)
  three_arr = []
  arr.each_with_index do |number, index|
    break if arr[index + 1].nil? || arr[index + 2].nil?
    three_arr << (number + arr[index+1] + arr[index+2])
  end
  three_arr
end

three = three_peat(read_input)

puts depth_increases(three)
