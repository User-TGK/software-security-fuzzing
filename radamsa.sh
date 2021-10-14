# Run radamsa in a loop to generate fuzzed files until the stb-image wrapper program crashes;
# The malformed file is then in $INPUT.fuzzed

RADAMSA=../radamsa/bin/radamsa
WRAPPER=build/stb-image

# Input and output files
if [ -z "$1" ]
then
    echo "Error: no input file given"
    exit 1
fi
infile="$1"
fuzzed="$infile.fuzzed"

# Seed
if [ ! -z "$2" ]
then
    RADAMSA="$RADAMSA --seed $2"
fi

# Main loop
while true
do
    $RADAMSA $infile > $fuzzed
    $WRAPPER $fuzzed > /dev/null
    test $? -gt 127 && break
done
