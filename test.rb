a = 'This is string'
to_match = 'isz'
a = 'Это строка, в которой есть слово Киев'
to_match = 'Киев'
reg = Regexp.compile(to_match)
puts (a =~ reg) != nil