require "byebug"

def coordinates
  file = File.read('input.txt')
  file.split(/\n+/)
      .map do |coords|
        coords.split(' -> ').map do |coord|
          coord.split(',').map(&:to_i)
        end
      end
end

def horizontal_and_vertical(coordinates_list)
  coordinates_list.select do |coordinates|
    coordinates[0][0] == coordinates[1][0] || coordinates[0][1] == coordinates[1][1]
  end
end

def diagonal_lines(coordinates_list)
  coordinates_list.select do |coordinates|
    coordinates[0][0] != coordinates[1][0] && coordinates[0][1] != coordinates[1][1]
  end
end

def make_line(coordinates_of_line_ends)
  line_point_array = []
  if coordinates_of_line_ends[0][0] == coordinates_of_line_ends[1][0] && coordinates_of_line_ends[0][1] < coordinates_of_line_ends[1][1]
    (coordinates_of_line_ends[0][1]..coordinates_of_line_ends[1][1]).each do |y_axis_coordinate|
      line_point_array << [coordinates_of_line_ends[0][0], y_axis_coordinate]
    end
  elsif coordinates_of_line_ends[0][0] == coordinates_of_line_ends[1][0] && coordinates_of_line_ends[0][1] > coordinates_of_line_ends[1][1]
    (coordinates_of_line_ends[1][1]..coordinates_of_line_ends[0][1]).each do |y_axis_coordinate|
      line_point_array << [coordinates_of_line_ends[0][0], y_axis_coordinate]
    end
  elsif coordinates_of_line_ends[0][1] == coordinates_of_line_ends[1][1] && coordinates_of_line_ends[0][0] < coordinates_of_line_ends[1][0]
    (coordinates_of_line_ends[0][0]..coordinates_of_line_ends[1][0]).each do |x_axis_coordinate|
      line_point_array << [x_axis_coordinate, coordinates_of_line_ends[1][1]]
    end
  elsif coordinates_of_line_ends[0][1] == coordinates_of_line_ends[1][1] && coordinates_of_line_ends[0][0] > coordinates_of_line_ends[1][0]
    (coordinates_of_line_ends[1][0]..coordinates_of_line_ends[0][0]).each do |x_axis_coordinate|
      line_point_array << [x_axis_coordinate, coordinates_of_line_ends[1][1]]
    end
  end
  line_point_array
end

def diagonal_lines_line(coordinates_of_line_ends)
  line_point_array = []
  x_coords = []
  y_coords = []
  if coordinates_of_line_ends[0][0] < coordinates_of_line_ends[1][0]
    (coordinates_of_line_ends[0][0]..coordinates_of_line_ends[1][0]).each do |x_axis_coordinate|
      x_coords << x_axis_coordinate
    end
  end
  if coordinates_of_line_ends[0][0] > coordinates_of_line_ends[1][0]
    (coordinates_of_line_ends[1][0]..coordinates_of_line_ends[0][0]).to_a.reverse.each do |x_axis_coordinate|
      x_coords << x_axis_coordinate
    end
  end
  if coordinates_of_line_ends[0][1] < coordinates_of_line_ends[1][1]
    (coordinates_of_line_ends[0][1]..coordinates_of_line_ends[1][1]).each do |y_axis_coordinate|
      y_coords << y_axis_coordinate
    end
  end
  if coordinates_of_line_ends[0][1] > coordinates_of_line_ends[1][1]
    (coordinates_of_line_ends[1][1]..coordinates_of_line_ends[0][1]).to_a.reverse.each do |y_axis_coordinate|
      y_coords << y_axis_coordinate
    end
  end
  x_coords.each_with_index do |x_coord, index|
    line_point_array << [x_coord, y_coords[index]]
  end
  return line_point_array
end

def all_straight_line_points(coordinates_list)
  lines = horizontal_and_vertical(coordinates_list).map do |coords_pair|
    make_line(coords_pair)
  end
  points_array = []
  lines.each do |line|
    line.each do |coordinate|
      points_array << coordinate
    end
  end
  points_array
end

def all_diagonal_line_points(coordinates_list)
  lines = diagonal_lines(coordinates_list).map do |coords_pair|
    diagonal_lines_line(coords_pair)
  end
  points_array = []
  lines.each do |line|
    line.each do |coordinate|
      points_array << coordinate
    end
  end
  points_array
end

def combined_coordinates(coordinates_list)
  all_diagonal_line_points(coordinates_list) + all_straight_line_points(coordinates_list)
end

def double_crossing(points_array)
  points_hash = Hash.new(0)
  points_array.each do |coordinate|
    points_hash[coordinate] += 1
  end
  crossings = points_hash.select do |coordinate, frequency|
    frequency >=2
  end
  crossings.length
end

p double_crossing(combined_coordinates(coordinates))
