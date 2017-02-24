defmodule BinaryTree do
  defstruct value: nil, left: nil, right: nil

  def add do
    IO.puts "ok"
  end

  def biggest_power_of_2_after_n(n) do
    :math.pow(2, (:math.log2(n) |> Float.ceil))
  end

  def create_leaves(n) do
    0..n
    |> Enum.chunk(2)
    |> Enum.map( fn(chunk)->
      %BinaryTree{value: 0, left: nil, right: nil}
    end)
  end

end
