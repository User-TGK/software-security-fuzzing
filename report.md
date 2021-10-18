# Fuzzing Project: `stb_image.h`

Twan Bolwerk (s1061234)
Ties Klappe (s...)
Ege Sarayadar (s...)
Koen Bolhuis (s1085616)

We use a specific version of stb_image:
- Version: 2.12 (2016-04-02)
- Commit: https://github.com/nothings/stb/blob/fdca443892d0ce3c8680e6f38f196c61e95c7de3/stb_image.h

# First attempt with AFL-Fuzzer

We ran afl fuzzer for 4 days with the following specs:
1. for instrumentation on binary we compiled with ```afl-clang```
2. hardware specs cpu; product: Intel(R) Core(TM) i7-4790 CPU @ 3.60GHz
3. we used the [png test suite](https://github.com/nothings/stb/tree/master/tests/pngsuite) of stb_image.h
4. we had to execute the following command under root ```echo core >/proc/sys/kernel/core_pattern ```

## Result
running the following anaysers:
``` ./afl-showmap -o ~/software-security-fuzzing/afl-mapping-fuzzing ~/software-security-fuzzing/build/stb-image```

```txt
000000:1
000634:1
000635:1

~/software-security-fuzzing/afl-mapping-fuzzing
```

