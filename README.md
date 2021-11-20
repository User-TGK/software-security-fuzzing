# Compilation
[link to minimized image test set](https://lcamtuf.coredump.cx/afl/demo/)

```
> mkdir build && cd build
> cmake ../
> make
```

## Honggfuzz
#### Setup

Point CMake compiler in CMakeLists.txt to Honggfuzz' clang, adjust path for your installation directory.

```cmake
set(CMAKE_C_COMPILER "../../honggfuzz/hfuzz_cc/hfuzz-clang")
```

### Run fuzzer
```bash
honggfuzz -i ../afl_testcases/ [CHOOSE INPUT DIR HERE] -o ../hongfuzz_results/ [CHOOSE OUTPUT DIR] -- stb_image ___FILE___
```

### Move fuzzer to background
```shell
$ ctrl + z
$ disown -h %1
$ bg 1
```

### Analyse results

From build dir, run i.e.

```shell
./stb-image ../hongfuzz_results/jpeg_turbo_edges_only/0a3dcbc1b1855f4bc60eba458d7a6509.00000071.honggfuzz.cov
```

## AFL

```Console
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
