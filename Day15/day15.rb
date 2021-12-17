require 'byebug'

def input
  file = File.read('sampleinput.txt')
  input = file.split("\n").map do |line|
    line.chars.map do |height|
      height.to_i
    end
  end
  input
end

p input
p input.transpose
