#!/bin/bash

PREFIX=$1
BINARY=$2

mkdir -p radamsa_output/$PREFIX/fuzz/
mkdir -p radamsa_output/$PREFIX/crash/

i=0
while true; do
    echo "Iteration: $i, mutations: $(($i * 1000))"
    ../radamsa/bin/radamsa -o radamsa_output/$PREFIX/fuzz/%n.fuzzed -n 1000 afl_testcases/jpeg_turbo/edges-only/images/*
    files=radamsa_output/$PREFIX/fuzz/*
    for f in $files; do
        output=$($BINARY $f 2>&1)
        if [ $? -gt 127 ]; then
            echo "$f caused a crash"
            name=$(basename $f)
            cp $f radamsa_output/$PREFIX/crash/$i-$name.fuzz
            echo >radamsa_output/$PREFIX/crash/$i-$name.txt $output
        fi
    done
    i=$(($i + 1))
done
