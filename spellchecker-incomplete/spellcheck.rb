require "pry"
#!/usr/bin/env ruby

# def correct(sentence)
#   # YOUR CODE HERE
# end
#
# input = ARGV.join(" ")
# puts correct(input)
FILENAME = "lotsowords.txt"

text=File.open(FILENAME).read
text.split(" ")
