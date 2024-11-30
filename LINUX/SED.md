### sed

sed is used for text transformation and line editing.

### Examples

    Find and replace (basic)
    If file.txt contains:

Hello world
Goodbye world

Replace "world" with "universe":

sed 's/world/universe/' file.txt

Output:

Hello universe
Goodbye universe

### 

Find and replace globally
Replace all occurrences of "l" with "L":

sed 's/l/L/g' file.txt

Output:

HeLLo worLd
Goodbye worLd

### 

Delete specific lines
If file.txt contains:

Line 1
Line 2
Line 3

Delete the second line:

sed '2d' file.txt

Output:

Line 1
Line 3

### 

Print a range of lines
Print lines 2 to 3:

sed -n '2,3p' file.txt

Output:

Line 2
Line 3

### 

Insert a line before a pattern
Insert "New Line" before lines containing "world":

sed '/world/i\New Line' file.txt

Output:

Hello world
New Line
Goodbye world

###

In-place editing
Replace "world" with "universe" directly in the file:

    sed -i 's/world/universe/g' file.txt

### Comparison of Use Cases

Command	                                 Use Case	                                 Example Output
  awk	                     Filter rows based on conditions	                      Filter age > 25
  cut	                     Extract specific columns or characters	                  Extract usernames
  sed	                     Find, replace, or delete patterns	                   Replace "world" with "universe"