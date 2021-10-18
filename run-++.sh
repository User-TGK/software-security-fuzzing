for i in {0..8}
do
	screen -dmS fuzzer$i /bin/bash -c "../AFLplusplus/afl-fuzz -i afl_testcases -o findings++ -M fuzzer$i -- build/stb-image @@"
done
