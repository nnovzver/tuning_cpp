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

all:

bench: vector/bench.cpp
	clang++ ${FLAGS} -o bench vector/bench.cpp -lbenchmark

bench_run: bench
	./bench

perf_record: bench
	perf stat ./bench

perf_stat: bench
	perf record ./bench
	perf report

bench2: vector/bench.cpp
	clang++ ${FLAGS} -fno-omit-frame-pointer -o bench2 vector/bench.cpp -lbenchmark

perf_call_graph: bench2
	perf record -g ./bench2
	perf report -g "graph,0.5,caller"

bench_fastmod: fastmod/bench.cpp
	clang++ ${FLAGS} -fno-omit-frame-pointer -o bench_fastmod fastmod/bench.cpp -lbenchmark

run_bench_fastmod: bench_fastmod
	./bench_fastmod

perf_bench_fastmod: bench_fastmod
	perf record -g ./bench_fastmod
	perf report -g "graph,0.5,caller"
