defmodule AlgorithmicCrush do

  def get_input do
    #parse the list length and no. of instructions from the first line of stdin
    dims = IO.gets ""
    [length, no_of_instructions] = dims
    |> String.split(" ")

    no_of_instructions = no_of_instructions
    |> String.trim
    |> String.to_integer

    #read the instructions
    instructions = for _n <- 1..no_of_instructions do
      instruction = IO.gets ""

      instruction
      |> String.split(" ")
      |> Enum.map( fn(int) ->
        int
        |> String.trim
        |> String.to_integer
      end)
    end

    #build a list of zeros "length" long
    l = length |> String.to_integer
    list = for n <- 1..l, do: 0

    # solve(list, instructions)
    # |> Enum.sort
    # |> List.last

    solve_with_prefix_sum(list, instructions)
    |> AlgorithmicCrush.prefix_sum_list_totals([], 0)
    |> Enum.max

  end

  def solve(list, instructions) do
    instructions
    |> Enum.reduce(list, fn([start_pos, end_pos, val], acc) ->
      #zero indexed as god intended
      start_pos = start_pos - 1
      end_pos = end_pos - 1

      start_pos..end_pos
      |> Enum.reduce(acc, fn(x, inner_acc)->
        inner_acc |> List.replace_at(x, Enum.at(inner_acc, x) + val)
      end)
    end)
  end

  def solve_with_prefix_sum(list, instructions) do

    list_len = length(list)

    instructions
    |> Enum.reduce(list, fn([start_pos, end_pos, val], acc) ->
      start_pos = start_pos - 1

      #check we are not out of bounds with the end position
      cond do
        end_pos == list_len ->
          acc
          |> List.replace_at(start_pos, Enum.at(acc, start_pos) + val)
        true ->
          acc
          |> List.replace_at(start_pos, Enum.at(acc, start_pos) + val)
          |> List.replace_at(end_pos, Enum.at(acc, end_pos) - val)
      end

    end)
  end

  def prefix_sum_list_totals([], totals, counter), do: totals

  def prefix_sum_list_totals([head | tail], totals, counter) do
    prefix_sum_list_totals(tail, totals ++ [head + counter], head + counter)
  end

  def get_largest(list) do
    list
    |> Enum.sort
    |> List.last
  end

end

# AlgorithmicCrush.get_input()

ExUnit.start()

defmodule AlgorithmicCrushTest do
  use ExUnit.Case

  test "solve" do
    assert AlgorithmicCrush.solve([0,0,0,0,0], [[1,2,100], [2,5,100], [3,4,100]])
      == [100, 200, 200, 200, 100]
  end

  test "solve with prefix sum approach" do
    assert AlgorithmicCrush.solve_with_prefix_sum([0,0,0,0,0], [[1,2,100], [2,5,100], [3,4,100]])
      == [100, 100, 0, 0, -100]
  end

  test "sum up prefix sum list" do
    assert AlgorithmicCrush.prefix_sum_list_totals([100, 100, 0, 0, -100], [], 0)
      == [100, 200, 200, 200, 100]
  end

  test "test case 1" do

    assert AlgorithmicCrush.solve([0,0,0,0], [[2,3,603], [1,1,286], [4,4,882]])
      |> Enum.sort
      |> List.last
      == 882
    assert AlgorithmicCrush.solve_with_prefix_sum([0,0,0,0], [[2,3,603], [1,1,286], [4,4,882]])
        |> AlgorithmicCrush.prefix_sum_list_totals([], 0)
        |> Enum.sort
        |> List.last
      == 882
  end

  test "test case 13" do
    assert 7542539201 == 7542539201
  end

  test "test case 4" do
    assert 2490686975 == 2490686975
  end

end
