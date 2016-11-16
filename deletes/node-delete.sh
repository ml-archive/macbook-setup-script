#!/bin/bash -f

# DELETE NODE, NPM, and N versions.
rm -f /usr/local/bin/node
rm -r /usr/local/n
rm -r /usr/local/lib/node_modules/
rm -r /usr/local/include/node/
rm -f /usr/local/bin/gulp