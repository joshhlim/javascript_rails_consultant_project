class String
  # This returns true for a string with leading zeros, "0009"
  # It also does not work for octal, hexadecimal or binary
  # See Stack Exchange Q&A for reference, if that is needed
  # http://stackoverflow.com/questions/1235863/test-if-a-string-is-basically-an-integer-in-quotes-using-ruby
  def is_id?
    self.to_i.to_s == self && self.to_i >= 0
  end
end