#!/bin/bash

mkdir -p radamsa_output/fuzz/
mkdir -p radamsa_output/crash/

run_until_crash()
{
    while true; do
        echo "Iteration: $1, mutations: $(($1 * $COUNT))"
        ../radamsa/bin/radamsa -o radamsa_output/fuzz/%n-%s.fuzzed -n 1000 afl_testcases/jpeg_turbo/edges-only/images/*
        FILES=radamsa_output/fuzz/*
        for f in $FILES; do
            output=$(build/stb-image $f 2>&1)
            if [ $? -gt 127 ]; then
                echo "$f caused a crash"
                mkdir -p radamsa_output/crash/$1/
                echo "$output" > "radamsa_output/crash/$1/crash.txt"
                cp $f radamsa_output/crash/$1/
            fi
        done
    done
}

COUNT=$(ls afl_testcases/jpeg_turbo/edges-only/images/ | wc -l)
i=0
while true; do
    run_until_crash $i
    i=$((i + 1))
done
