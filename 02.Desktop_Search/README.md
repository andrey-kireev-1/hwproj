[![ShellCheck](https://github.com/andrey-kireev-1/hwproj/actions/workflows/github-actions.yml/badge.svg?branch=02_DESKTOP_SEARCH)](https://github.com/andrey-kireev-1/hwproj/actions/workflows/github-actions.yml)
# SPbU Source Downloader

This script automatically download resources from SPBU server.

## Pre-install utils
```bash
sudo apt-get update
sudo apt-get install unrar
sudo apt-get install recoll
```

## Usage
This messages logs for every error.

```bash
./import_spbu_umd.sh [-s | --source] <url> [-d | --destination] <folder> [-p | --probe]
[-s | --source] - from download
[-d | --destination] - to what path download
[-p | --probe] - random 10 files
Source and destination parameters is required
```

## Recoll usage
```bash
recoll -t "text for search"
```
