# MachOReader

### Installation

```
$ git clone git@github.com:olbartek/MachOReader.git
$ cd MachOReader
$ swift build
$ swift run machoreader -rh <macho_file_path>
```

Additionally when needed

```
$ swift build --configuration release
$ cp -f .build/release/machoreader /usr/local/bin/machoreader
```

### Usage

```
OVERVIEW: Mach-O file format reader, written entirely in Swift.

USAGE: machoreader <file-path> [--header] [--fat]

ARGUMENTS:
  <file-path>             The file path of Mach-O executable.

OPTIONS:
  -h, --header            Read header.
  -f, --fat               Read fat header.
  -h, --help              Show help information.
```
