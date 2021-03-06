defmodule MsgpackBenchmarkTest do
  use ExUnit.Case
  doctest MsgpackBenchmark

  test "encode and decode and benchmark a small data set" do
    data = %{
      simple: "data",
      list: [
        1,
        2,
        3
      ]
    }

    assert (data |> Msgpax.pack! |> IO.iodata_to_binary |> Msgpax.unpack!) == %{"list" => [1, 2, 3], "simple" => "data"}
    assert (data |> Poison.encode! |> Poison.decode!) == %{"list" => [1, 2, 3], "simple" => "data"}

    benchmark(data)
  end

  test "with lots of data" do
    data = File.read!("test/data.json") |> Poison.decode!
    benchmark(data)
  end

  def benchmark(data) do
    IO.puts "Data size:"
    IO.inspect msg_pack_length: Msgpax.pack!(data) |> IO.iodata_to_binary |> byte_size, json_length: Poison.encode!(data) |> byte_size
    IO.puts ""

    times = 10000

    IO.puts "Benchmark, #{times} times do:"

    IO.puts ""
    IO.puts "Do nothing (benchmark the benchmark)"
    Measure.duration times, fn ->
    end

    IO.puts ""
    IO.puts "Msgpax: pack"
    Measure.duration times, fn ->
      (data |> Msgpax.pack! |> IO.iodata_to_binary)
    end

    IO.puts ""
    IO.puts "Poison: encode"
    Measure.duration times, fn ->
      (data |> Poison.encode!)
    end

    IO.puts ""
    IO.puts "Msgpax: pack and unpack"
    Measure.duration times, fn ->
      (data |> Msgpax.pack! |> IO.iodata_to_binary |> Msgpax.unpack!)
    end

    IO.puts ""
    IO.puts "Poison: encode and decode"
    Measure.duration times, fn ->
      (data |> Poison.encode! |> Poison.decode!)
    end
  end
end

defmodule Measure do
  def duration(count, function) do
    start_time = :os.system_time

    (0..count) |> Enum.each fn (_) ->
      function.()
    end

    microseconds = (:os.system_time - start_time)/1000
    microseconds_per_iteration = microseconds / count
    iterations_per_second = :erlang.round(1000000 / microseconds_per_iteration)
    IO.puts "#{microseconds / 1000} ms in total, #{microseconds_per_iteration} μs/iteration #{iterations_per_second} iterations/second"
  end
end
