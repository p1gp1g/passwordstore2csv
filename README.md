# Dump Pass to csv

To dump [pass](https://www.passwordstore.org/) to csv, which can be imported to Keepass.

## Usage

You need fd installed but it can be easily edited to work with find instead.

```
./dump.sh | tee store.csv

# Or, if you use a custom directory
PASSWORD_STORE_DIR=~/.mystore/ ./dump.sh | tee store.csv

# Import, then shred
shred -u store.csv
```
