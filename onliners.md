
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


#### Check if file exists and then do something with it
```
if [ -f $FILE ] ; then
echo "$FILE exists"
fi 
```

this can also be negated: 
```
if [ ! -f $FILE ] ; then
echo "$FILE does not exist"
fi 
```

##### similar statements: 
```[ -s $FILE ]``` checks if file is non-empty

```[ -z $VAR ]``` checks if variable exists/ is non-empty

you can always negate them by adding a ``` ! ``` before the flag 

I use this, for example, to check whether an output file was generated and then to delete intermediate input files.

By Nina Hollfelder 

#### delete empty files:

```find . -size  0 -print -delete ```

by Nina Hollfelder 


A large collection of useful bioinformatic oneliners can also be found at Stephen Turner's github:  https://github.com/stephenturner/oneliners
