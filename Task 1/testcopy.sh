#!/bin/bash

#!/bin/sh


if (( $# == 2 )); then
    
    PortFiles="./tempFolder/*.txt"
    
    
    for f in $PortFiles
    do
        echo "Processing $f file..."
        
    done
    
    
    rm -rf tempFolder
    
fi