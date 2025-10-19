
   .-'''-.     .-''-.   ______     .-------.        .-''-.  ,---.   .--.   ____    ,---.    ,---.    .-''-.
  / _     \  .'_ _   \ |    _ `''. |  _ _   \     .'_ _   \ |    \  |  | .'  __ `. |    \  /    |  .'_ _   \
 (`' )/`--' / ( ` )   '| _ | ) _  \| ( ' )  |    / ( ` )   '|  ,  \ |  |/   '  \  \|  ,  \/  ,  | / ( ` )   '
(_ o _).   . (_ o _)  ||( ''_'  ) ||(_ o _) /   . (_ o _)  ||  |\_ \|  ||___|  /  ||  |\_   /|  |. (_ o _)  |
 (_,_). '. |  (_,_)___|| . (_) `. || (_,_).' __ |  (_,_)___||  _( )_\  |   _.-`   ||  _( )_/ |  ||  (_,_)___|
.---.  \  :'  \   .---.|(_    ._) '|  |\ \  |  |'  \   .---.| (_ o _)  |.'   _    || (_ o _) |  |'  \   .---.
\    `-'  | \  `-'    /|  (_.\.' / |  | \ `'   / \  `-'    /|  (_,_)\  ||  _( )_  ||  (_,_)  |  | \  `-'    /
 \       /   \       / |       .'  |  |  \    /   \       / |  |    |  |\ (_ o _) /|  |      |  |  \       /
  `-...-'     `'-..-'  '-----'`    ''-'   `'-'     `'-..-'  '--'    '--' '.(_,_).' '--'      '--'   `'-..-'

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
$ sedrename.sh 's/e/woah/g' .
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
## Installation

Download the [sedrename.sh](sedrename.sh) file

```
$ wget https://raw.githubusercontent.com/tsnad/sedrename/refs/heads/master/sedrename.sh
```

Make the file executable

```
$ chmod u+x sedrename.sh
```

Then run the file from the current location or add it to ~/.local/bin if it's in your $PATH

```
$ ./sedrename.sh -pn my/life/
```

## Author

**tsnad**

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Acknowledgments

* Thanks to [You Suck at Programming](https://www.youtube.com/@yousuckatprogramming) for the bash tutorials

