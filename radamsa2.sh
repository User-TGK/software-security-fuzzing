#!/bin/bash

count=$(ls afl_testcases/jpeg_turbo/edges-only/images/ | wc -l)
i=0
while true; do
    echo "Iteration: $i, mutations: $(($i * $count))"
    ../radamsa/bin/radamsa -o radamsa_output/fuzz-%n-%s.fuzzed -n 1000 afl_testcases/jpeg_turbo/edges-only/images/*
    FILES=radamsa_output/*
    for f in $FILES; do
        build/stb-image $f
        if [ $? -gt 127 ]; then
            echo "$f caused a crash"
            exit 0
        fi
    done
    i=$((i + 1))
done
