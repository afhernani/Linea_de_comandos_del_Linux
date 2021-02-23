# PRINT YEAR,MONTH,DAY AND DATE...

echo "We are in the year = $(date +%Y)"
echo "We are in the year = $(date +%y)"

# Difference between %Y and %y is %Y will print 4 digits while %y will print the last 2 digits of the year.

echo "We are in the month = $(date +%m)"
echo "We are in the month = $(date +%b)"
echo "We are in the month = $(date +%B)"

# Difference between %B and %b is, %B will print full month name while %b will print abbreviated month name.

echo "Current Day of the month = $(date +%d)"

echo "Current Day of the week = $(date +%A)"
echo "Current Day of the week = $(date +%a)"

# Difference between %A and %a is, %A will print full Weekday name while %a will print abbreviated weekday name.

# Instead of formatting to get the date, we can use %D which will print the date as %m/%d/%y or %F which prints in %Y-%M-%d format.

echo "Date using %D = $(date +%D)"
echo "Date using %F = $(date +%F)"
