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

    IO.puts "Data size:"
    IO.inspect msg_pack_length: Msgpax.pack!(data) |> IO.iodata_to_binary |> byte_size, json_length: Poison.encode!(data) |> byte_size
    IO.puts ""

    times = 100000

    IO.puts "Benchmark, #{times} times do:"

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

    ms = (:os.system_time - start_time)/1000000
    ms_per_iteration = ms / count
    iterations_per_second = :erlang.round(1000 / ms_per_iteration)
    IO.puts "#{ms} ms in total, #{ms_per_iteration} ms/iteration #{iterations_per_second} iterations/second"
  end
end
