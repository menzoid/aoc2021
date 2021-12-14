require "byebug"

def initial
  file = File.read('input.txt')
  file.split(",").map(&:chomp).map(&:to_i)
end

def initial_ages(age_array)
  zero_age_hash = {  0 => 0,
              1 => 0,
              2 => 0,
              3 => 0,
              4 => 0,
              5 => 0,
              6 => 0,
              7 => 0,
              8 => 0,
    }
  age_array.each do |age|
    zero_age_hash[age] +=1
  end
  zero_age_hash
end

def final_ages(age_hash, day, days)
  new_age_hash = {  0 => 0,
              1 => 0,
              2 => 0,
              3 => 0,
              4 => 0,
              5 => 0,
              6 => 0,
              7 => 0,
              8 => 0,
    }


  age_hash.each do |key, value|
    if key == 0
      new_age_hash[8] = age_hash[key]
      new_age_hash[6] = age_hash[key]
    elsif key == 7
      new_age_hash[6] += age_hash[key]
    else
      new_age_hash[key-1] = age_hash[key]
    end
  end
  if day < days
    final_ages(new_age_hash, day+1, days)
  else
    return new_age_hash
  end
end

def fish_count(final_age_hash)
  final_age_hash.values.inject(&:+)
end

p fish_count(final_ages(initial_ages(initial), 1, 256))
