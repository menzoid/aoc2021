require 'byebug'

def input
  file = File.read('input.txt')
  input = file.split(',').map(&:chomp).map(&:to_i)
end

def median(array)
  return nil if array.empty?
  sorted = array.sort
  len = sorted.length
  (sorted[(len - 1) / 2] + sorted[len / 2]) / 2
end

def average(array)
  ave = array.sum / array.length.to_f
  # ave.round
end

def total_movement_pt1(array)
  total = 0
  final_position = median(array)
  array.each do |starting_position|
    total += (starting_position - final_position).abs
  end
  total
end

def total_movement_pt2(array)
  total = 0
  final_position = 466
  array.each do |starting_position|
    distance = (starting_position - final_position).abs
    total += ((distance*(distance+1))/2)
  end
  total
end

p median(input)
p total_movement_pt1(input)
p average(input)
p total_movement_pt2(input)
