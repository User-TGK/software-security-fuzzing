# Compilation

```
> mkdir build && cd build
> cmake ../
> make
```

```Console
./run_crashes.sh 2>&1 | tee crashes.txt
./run_hangs.sh 2>&1 | tee hangs.txt



sudo apt install screen
vi run.sh
modify afl path to your own path
vi status.sh
modify afl path to your own path
./status.sh
should run by default on 8 cores
verify this with
./status.sh
```
