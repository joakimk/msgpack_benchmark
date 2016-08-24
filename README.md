# MsgpackBenchmark

A simple benchmark of Msgpax vs Poison.

## Small data:

```
Data size:
[msg_pack_length: 22, json_length: 32]

Benchmark, 10000 times do:

Msgpax: pack
54.295 ms in total, 0.0054295 ms/iteration 184179 iterations/second

Poison: encode
62.953 ms in total, 0.0062953 ms/iteration 158849 iterations/second

Msgpax: pack and unpack
96.585 ms in total, 0.009658499999999999 ms/iteration 103536 iterations/second

Poison: encode and decode
132.647 ms in total, 0.013264699999999999 ms/iteration 75388 iterations/second
```

## "Big" data:

```
Data size:
[msg_pack_length: 4999, json_length: 5606]

Benchmark, 10000 times do:

Msgpax: pack
1365.45 ms in total, 0.136545 ms/iteration 7324 iterations/second

Poison: encode
6266.781 ms in total, 0.6266781 ms/iteration 1596 iterations/second

Msgpax: pack and unpack
2063.596 ms in total, 0.2063596 ms/iteration 4846 iterations/second

Poison: encode and decode
10045.307 ms in total, 1.0045307 ms/iteration 995 iterations/second
```
