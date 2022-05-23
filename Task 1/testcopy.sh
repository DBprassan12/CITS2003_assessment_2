#!/bin/bash

#!/bin/sh


args=()
for i in "$@"; do
    args+=("$i")
done
echo "${args[@]}"
