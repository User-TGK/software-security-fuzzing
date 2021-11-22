screen -dmS fuzzer1 /bin/bash -c "afl-fuzz -i test-input/pngsuite/primary/ -o output_live_fuzz ./build/stb-image @@
"
