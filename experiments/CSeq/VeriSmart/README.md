# VeriSmart #
Built upon Lazy-CSeq 2.0

## Package contents ##

| File/Directory | Description                          |
| -------------- | ------------------------------------ |
| verismart.py   | VeriSmart wrapper script             |
| cseq*.py       | Translator scripts			        |
| bin/           | VeriSmart modules                    |
| core/          | Lazy-CSeq core framework             |
| modules/       | modules and configuration files      |
| examples/      | example files                        |
| LICENSE        | VeriSmart license                    |
| LICENSE-CSeq   | CSeq framework license               |
| CBMC_LICENSE   | CBMC license                         |
| README.md      | this file                            |


## Installation ##

To install VeriSmart, please follow the steps below:

    1. install the dependencies:
        - Python 2.7
        - PYCParser (pip install pycparser)
        - backends: [CBMC](http://www.cprover.org/cbmc/)

    2. create a directory, suppose this is called /workspace

    3. extract the entire package contents in /workspace

    4. set execution (+x) permissions for verismart.py and cseq*.py


## Usage ##

To try VeriSmart, please use the following command:

    ./verismart.py  examples/lazy_unsafe.c -A -p1 -l3

which should generating two instances and one of the instances is unsafe.

For details strategy, please refer to `./verismart.py -h`
