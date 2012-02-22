def triangle(a, b, c)
  # WRITE THIS CODE
  raise TriangleError, "Sides must by numbers greater than zero" if (a <= 0) || (b <= 0) || (c <= 0)
raise TriangleError, "No two sides can add to be less than or equal to the other side" if (a+b <= c) || (a+c <= b) || (b+c <= a)
  if a==b && a==c
    return :equilateral
  end
  if (a==b && a!=c) || (a==c && a!=b) || (b==c && b!=a)
    return :isosceles
  end
  if a!=b && a!=c && b!=c
    return :scalene
  end




end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError

end