#include "benchmark/benchmark.h"
#include <vector>
#include <random>

static void generate_arg_pairs(benchmark::internal::Benchmark *b)
{
  for (int i = 1<<4; i <= 1<<10; i <<= 2) {
    for (int j : {32, 128, 224}) {
      b = b->ArgPair(i, j);
    }
  }
}

static void bench_fastmod(benchmark::State& state)
{
  const int size = state.range(0);
  assert(size >= 16 && "Only support 16 integers at a time!");
  const int ceil = state.range(1);
  std::vector<int> input, output;
  input.resize(size, 0);
  output.resize(size, 0);

  std::mt19937 rng;
  rng.seed(std::random_device()());
  std::uniform_int_distribution<int> dist(0, 255);
  for (int& i : input) {
    i = dist(rng);
  }

  while (state.KeepRunning()) {
    for (int i = 0; i < size; ++i) {
      output[i] = input[i] >= ceil ? input[i] % ceil : input[i];
    }
  }
}
BENCHMARK(bench_fastmod)->Apply(generate_arg_pairs);

BENCHMARK_MAIN();
