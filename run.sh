for i in {0..8}
do
	screen -dmS fuzzer$i /bin/bash -c "../AFL/afl-fuzz -i test-input -o findings -M fuzzer$i -- build/stb-image @@"
done
