FLAGS = \
  -O3 \
  -std=c++14 \
  -Wl,-rpath=/home/nnovzver/projects/tuning_cpp/ \
  -fno-exceptions \
  -fno-rtti \
  -Wall \
  -pedantic \
  -Werror \
  -I/home/nnovzver/projects/tuning_cpp/googlebenchmark-src/include \
  -L/home/nnovzver/projects/tuning_cpp/googlebenchmark-build/src \
  -pthreads \
  #-stdlib=libc++ \
  #-lc++abi \

first:
	clang++ ${FLAGS} -o bench vector/bench.cpp -lbenchmark
	./bench
