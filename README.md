# MsgpackBenchmark

A simple benchmark of Msgpax vs Poison.

## Small data:

```
Data size:
[msg_pack_length: 22, json_length: 32]

Benchmark, 10000 times do:

Do nothing (benchmark the benchmark)
2.896 ms in total, 0.2896 μs/iteration 3453039 iterations/second

Msgpax: pack
50.963 ms in total, 5.0963 μs/iteration 196221 iterations/second

Poison: encode
54.689 ms in total, 5.4689 μs/iteration 182852 iterations/second

Msgpax: pack and unpack
81.534 ms in total, 8.1534 μs/iteration 122648 iterations/second

Poison: encode and decode
155.935 ms in total, 15.5935 μs/iteration 64129 iterations/second
```

## "Big" data:

```
Data size:
[msg_pack_length: 4999, json_length: 5606]

Benchmark, 10000 times do:

Do nothing (benchmark the benchmark)
1.239 ms in total, 0.1239 μs/iteration 8071025 iterations/second

Msgpax: pack
1404.629 ms in total, 140.4629 μs/iteration 7119 iterations/second

Poison: encode
6498.529 ms in total, 649.8529 μs/iteration 1539 iterations/second

Msgpax: pack and unpack
2025.419 ms in total, 202.5419 μs/iteration 4937 iterations/second

Poison: encode and decode
10045.583 ms in total, 1004.5583 μs/iteration 995 iterations/second
```
