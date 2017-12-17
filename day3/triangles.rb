def is_triangle?(lengths)
  lengths.sort!
  return lengths[2] < (lengths[0] + lengths[1])
end
