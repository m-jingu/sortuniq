# sortuniq
This scripts make large lists unique using a Perl hash.

## sortuniq.pl
This script just makes the list unique.

```
$ cat list.txt
aaaa
bbbb
cccc
dddd
aaaa
cccc
cccc
$ cat list.txt|perl sortuniq.pl
$ cat result
aaaa
bbbb
cccc
dddd
```

## sortuniqc.pl
This script makes the list unique and count the number of times the line.

```
$ cat list.txt
aaaa
bbbb
cccc
dddd
aaaa
cccc
cccc
$ cat list.txt|perl sortuniqc.pl
$ cat result
2	aaaa
1	bbbb
3	cccc
1	dddd
```
