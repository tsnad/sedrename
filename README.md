
# SEDRENAME

A cli tool for renaming files based off regex patterns using sed, written in bash.

### Requirements

gnutils, bash

## Examples

```
$ ls
 agreement.null               garbage.win         policy
'decision estate operation'   location.tracking   profession
 engineering                  orange/            'selection instruction'
$ sedrename.sh 's/e/WOAH/g' .
mv: 'policy' and 'policy' are the same file
renamed 'selection instruction' -> 'sWOAHlWOAHction instruction'
renamed 'engineering' -> 'WOAHnginWOAHWOAHring'
renamed 'decision estate operation' -> 'dWOAHcision WOAHstatWOAH opWOAHration'
renamed 'profession' -> 'profWOAHssion'
mv: 'location.tracking' and 'location.tracking' are the same file
renamed 'agreement.null' -> 'agrWOAHWOAHmWOAHnt.null'
renamed 'garbage.win' -> 'garbagWOAH.win'
$ ls
 agrWOAHWOAHmWOAHnt.null                  policy
'dWOAHcision WOAHstatWOAH opWOAHration'   profWOAHssion
 garbagWOAH.win                          'sWOAHlWOAHction instruction'
 location.tracking                        WOAHnginWOAHWOAHring
 orange/
```

You can undo the previous command with the -u flag

```
$ sedrename.sh -u 
mv: 'policy' and 'policy' are the same file
mv: 'location.tracking' and 'location.tracking' are the same file
renamed 'sWOAHlWOAHction instruction' -> 'selection instruction'
renamed 'WOAHnginWOAHWOAHring' -> 'engineering'
renamed 'dWOAHcision WOAHstatWOAH opWOAHration' -> 'decision estate operation'
renamed 'profWOAHssion' -> 'profession'
renamed 'agrWOAHWOAHmWOAHnt.null' -> 'agreement.null'
renamed 'garbagWOAH.win' -> 'garbage.win'
```

## Installation

Download the [sedrename.sh](sedrename.sh) file

```
$ wget https://raw.githubusercontent.com/tsnad/sedrename/refs/heads/master/sedrename.sh
```

Make the file executable

```
$ chmod u+x sedrename.sh
```

Then run the file from the current location

```
$ ./sedrename.sh -pn my/life/
```

or add it to ~/.local/bin if it's in your $PATH

```
mv sedrename.sh ~/.local/bin/
```


## Author

**tsnad**

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Acknowledgments

Thanks to [You Suck at Programming](https://www.youtube.com/@yousuckatprogramming) for the bash tutorials

