# radamsa.sh <infile> <seed>
#
# Seed should be a number, eg. `$RANDOM`.
#
# Run Radamsa in a loop to generate fuzzed files until the stb-image wrapper program crashes;
# the malformed file is then collected under `./radamsa-output/`.
# This is repeated forever.

RADAMSA=../radamsa/bin/radamsa
WRAPPER=build/stb-image

if [ ! -f "$RADAMSA" ]; then
    echo "Error: $RADAMSA does not exist"
    exit 1
elif [ ! -f "$WRAPPER" ]; then
    echo "Error: $WRAPPER does not exist"
    exit 1
fi

TIMESTAMP=$(date +"%Y%m%d%H%M%S")
OUTDIR="radamsa-output/$TIMESTAMP"

#################################################
# Argument parsing
#################################################

if [ $# -lt 2 ]; then
    echo "Usage: radamsa.sh <infile> <seed>"
    exit 1
fi

# Input and output files
inpath="$1"
infile=$(basename $inpath)

if [ ! -d "$OUTDIR" ]; then
    mkdir -p "$OUTDIR"
    echo "Created $OUTDIR"
fi

output_file()
{
    echo "$OUTDIR/$seed_$1.$infile.fuzzed"
}

# Seed
seed=$2

#################################################
# Main script
#################################################

# Run Radamsa until it crashes
run_until_crash()
{
    local _sequential_seed="$seed$1"
    local _outfile=$(output_file "$1")

    while true; do
        $RADAMSA --seed $_sequential_seed "$inpath" > "$_outfile"
        $WRAPPER "$_outfile" > /dev/null
        test $? -gt 127 && break
    done

    echo "$_outfile produced a crash"
}

# Main loop; do `run_until_crash` forever, collecting results in `$OUTDIR`
main_loop()
{
    local _i=0
    while true; do
        echo "Iteration $_i: $(output_file $_i)"
        run_until_crash $_i
        i=$((i+1))
    done
}

main_loop
