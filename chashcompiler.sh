#!/bin/bash

# Usage: ./rebuild.sh source1.c source2.c ... sourceN.c

source_files=$*

rehash()
{
    cat $source_files | md5sum | awk '{ print $1 }'
}

rebuild()
{
    N=$(expr $N + 1)
    M=$(rehash)
    gcc -Wall -Wshadow $source_files -o generated_execuatable \
	&& echo "Rebuild $N successful"
}

rebuild

while (( 1 )) ; do
    H=$(rehash)
    [ "$H" != "$M" ] && M="$H" && rebuild
    sleep 0.2
done
