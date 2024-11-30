###  awk

awk is used for advanced text processing, especially for column-based operations.
### Examples

    Print the second column
    If file.txt contains:

John 25 M
Alice 30 F
Bob 28 M

Command:

awk '{print $2}' file.txt

Output:

25
30
28



Filter rows based on a condition
Print lines where the second column (age) is greater than 27:

awk '$2 > 27 {print $0}' file.txt

Output:

Alice 30 F
Bob 28 M

Sum a specific column
Sum the ages in the second column:

awk '{sum += $2} END {print sum}' file.txt

Output:

83

Work with CSV files
If file.csv contains:

ID,Name,Salary
1,John,5000
2,Alice,6000
3,Bob,5500

Print names and salaries:

awk -F ',' '{print $2, $3}' file.csv

Output:

    Name Salary
    John 5000
    Alice 6000
    Bob 5500

