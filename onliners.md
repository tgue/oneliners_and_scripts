
### Human evolution onliners

Please add your onliners to this script. Inlcude the following information:

1. What the purpose of the command is
2. The command itself
3. Your name




#### Find all files with the ending .bam and check their file type (are the sam or bam or cram format)
 

```
find -type f -iname *.bam -ls -exec file {} \

```
By  Carolina Bernhardsson



#### Grep all lines in text file containing Pattern, cut nth column and sum the values
```
grep <Pattern> file.txt |cut -d <delimiter> -f <Column of interest> | paste -sd+ |bc -l

```

By Carolina Bernhardsson  



#### Read a file and have the variable in a loop be the line of the file:

```
while read p; do
  echo $p
done <pops.txt
```
Will in this case just print the content of the file `pops.txt` but can be combined endlessly
By Rickard Hammarén

