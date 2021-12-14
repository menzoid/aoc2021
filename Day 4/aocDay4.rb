require 'byebug'

def numbers
  file = File.open('number.txt')
  input = file.map(&:chomp)[0].split(',').map(&:to_i)
  file.close
  input
end

def gridsy
    f = File.read('inputday4.txt')
      data_array = f.split(/^\n+/).map  do |block|
      block
      .split(/\n+/)
      .map(&:chomp)
      .map { |e| e.strip.split(/\s+/)
      .map(&:to_i) }
      .reject { |a| a.empty? }
    end
end

def test_for_win(grid)
  grid.each_with_index do |matrix, index|
    rows = matrix
    columns = matrix.transpose
    rows.each do |row|
      if row.join == "xxxxx"
        return index
      end
    end
    columns.each do |column|
      if column.join == "xxxxx"
        return index
      end
    end
  end
  return nil
end

def remove_matrix(grid)
  grid.each_with_index do |matrix, index|
    rows = matrix
    columns = matrix.transpose
    rows.each do |row|
      if row.join == "xxxxx"
        grid.delete_at(index)
        remove_matrix(grid)
      end
    end
    columns.each do |column|
      if column.join == "xxxxx"
        grid.delete_at(index)
        remove_matrix(grid)
      end
    end
  end
  return grid
end

def last_standing(grids, num, i)
  new_grids = grids.map do |matrix|
    new_matrix = matrix.map do |line|
      new_line = line.map  do |element|
        if element == num[i]
          element = 'x'
        end
        element
      end
      new_line
    end
    new_matrix
  end
  i += 1
  if remove_matrix(new_grids).length > 1
    last_standing(remove_matrix(new_grids), num, i)
  else
    return remove_matrix(new_grids)
  end
end

def winning_board(grids, num, i)
  new_grids = grids.map do |matrix|
    new_matrix = matrix.map do |line|
      new_line = line.map  do |element|
        if element == num[i]
          element = 'x'
        end
        element
      end
      new_line
    end
    new_matrix
  end
  i += 1
  if test_for_win(new_grids).nil?
    winning_board(new_grids, num, i)
  else
    return new_grids
  end
end

def which_number(grids, num, i)
  new_grids = grids.map do |matrix|
    new_matrix = matrix.map do |line|
      new_line = line.map  do |element|
        if element == num[i]
          element = 'x'
        end
        element
      end
      new_line
    end
    new_matrix
  end
  i += 1
  if test_for_win(new_grids).nil?
    which_number(new_grids, num, i)
  else
    return num[i-1]
  end
end



p last_standing(gridsy, numbers, 0)
p winning_board(last_standing(gridsy, numbers, 0), numbers, 0).flatten.reject! {|n| n == "x"}.sum
p which_number(last_standing(gridsy, numbers, 0), numbers, 0)

def output(gridsy, numbers, i)
  sum = winning_board(last_standing(gridsy, numbers, 0), numbers, 0).flatten.reject! {|n| n == "x"}.sum
  last_pulled = which_number(last_standing(gridsy, numbers, 0), numbers, 0)
  return sum * last_pulled
end

p output(gridsy, numbers, 0)
