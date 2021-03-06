# r2wakare
r2wakare is a radare2 plugin able to load trace databases generated by wakare-converter.

- Wakare project: https://github.com/lse/wakare

## Installation
You will need to go into the ```plugins/r2wakare``` folder of this repository and
build the plugin. To build and install the plugin you must use r2pm:

```
r2pm -i r2wakare
```

or build locally

```
$ r2pm -r make && r2pm -r make install
```

## Features
- Basic block listing
- Basic block hitcount comments (hard to do bb highlighting in cli)
- Basic block diffing (Difference / Intersection)
- Branch target resolution (\wkrx)
- Supports PIE executables/traces

## Requirements
- make
- r2pm
- sqlite3

## Usage

```
[0x00001040]> \wkr
Wakare plugin:
\wkro [file]  : Open a trace database
\wkri         : Displays information about the loaded database
\wkrx         : Displays the xrefs from the current address
\wkrbl        : Displays the list of basic blocks
\wkrbh        : Adds hitcounts in basic blocks comments
\wkrbc        : Cleans the hitcount comments
\wkrdd [file] : Does a difference based diffing with another trace
\wkrdi [file] : Does an intersection based diffing with another trace
\wkrdr        : Resets the database to its original state
```

## Example
### Getting basic block list
```
$ r2 prog.pie
 -- Most likely your core dump fell into a blackhole, can't see it.
[0x00001050]> aa
[x] Analyze all flags starting with sym. and entry0 (aa)
[0x00001050]> \wkro trace_pie.db
[0x00001050]> \wkrbl
0x1190: 6 main
0x11c2: 6 main
0x1341: 6 main
0x134c: 6 main
0x12ec: 2 main
0x1020: 2
0x1040: 2 sym.imp.strtoul
0x1080: 1 sym.deregister_tm_clones
0x10a8: 1 sym.deregister_tm_clones
0x10b0: 1 sym.register_tm_clones
0x10e8: 1 sym.register_tm_clones
0x10fd: 1 entry.fini0
0x110b: 1 entry.fini0
0x1118: 1 entry.fini0
0x1140: 1 entry.init0
0x116e: 1 main
0x118a: 1 main
0x1000: 1 sym._init
0x1030: 1 sym.imp.printf
0x11e4: 1 main
0x123c: 1 main
0x1294: 1 main
0x1036: 1
0x1310: 1 main
0x133e: 1 main
0x1340: 1 main
0x1016: 1 sym._init
0x1046: 1
0x1360: 1 main
0x1370: 1 sym.__libc_csu_init
0x13a7: 1 sym.__libc_csu_init
0x13c6: 1 sym.__libc_csu_init
[0x00001050]>
```

### Getting xrefs from an instruction
```
$ r2 prog.pie
 -- Dissasemble? No dissasemble, no dissassemble!!!!!
[0x00001050]> aa
[x] Analyze all flags starting with sym. and entry0 (aa)
[0x00001050]> \wkro trace_pie.db
[0x00001050]> \wkrx @ 0x000011e2
--- Found 5 xrefs from 0x11e2 ---
0x12ec: 2 main
0x11e4: 1 main
0x123c: 1 main
0x1294: 1 main
0x1310: 1 main
[0x00001050]>
```

## Screenshot
![VM main screen](assets/r2-screen-global.png)
