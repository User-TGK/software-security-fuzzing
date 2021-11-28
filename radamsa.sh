RADAMSA=../radamsa/bin/radamsa
WRAPPER=build/stb-image

TIMESTAMP=$(date +"%Y%m%d%H%M%S")
OUTDIR="radamsa-output/$TIMESTAMP"

if [ $# -lt 2 ]; then
    echo "Usage: radamsa.sh <infile> <seed>"
    exit 1
fi

inpath="$1"
infile=$(basename $inpath)

if [ ! -d "$OUTDIR" ]; then
    mkdir -p "$OUTDIR"
    echo "Created $OUTDIR"
fi

output_file()
{
    echo "$OUTDIR/$seed-$1.$infile.fuzzed"
}

seed=$2

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

i=0
while true; do
    echo "Iteration $i: $(output_file $i)"
    run_until_crash $i
    i=$(($i+1))
done
