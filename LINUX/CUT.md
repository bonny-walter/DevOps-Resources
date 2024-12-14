# cut

cut is used to extract specific fields, bytes, or characters.
### Examples

    Extract specific columns
    If file.txt contains:

John:25:M
Alice:30:F
Bob:28:M

Extract the first and third fields:

cut -d':' -f1,3 file.txt

Output:

John:M
Alice:F
Bob:M

---

Extract characters
Extract the first three characters of each line:

cut -c1-3 file.txt

Output:

Joh
Ali
Bob

---

Extract bytes
If file.txt contains:

abcdef
ghijkl

Extract the first two bytes:

cut -b1-2 file.txt

Output:

ab
gh

---

Extract fields from /etc/passwd
Get usernames and default shells from /etc/passwd:

cut -d':' -f1,7 /etc/passwd

Output:

    root:/bin/bash
    user1:/bin/zsh
    user2:/usr/sbin/nologin

