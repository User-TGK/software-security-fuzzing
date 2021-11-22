for i in {1..16}
do
	screen -dmS fuzzer$i /bin/bash -c "sudo afl-fuzz -i afl_testcases/png/edges-only/images/ -o findings -M fuzzer$i -- build/stb-image @@"
done
