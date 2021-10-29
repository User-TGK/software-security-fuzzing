for i in {0..8}
do
	screen -dmS fuzzer$i /bin/bash -c "../AFLplusplus/afl-fuzz -i afl_testcases/jpeg_turbo/edges-only -o findings++ -M fuzzer$i -- build/stb-image @@"
done
