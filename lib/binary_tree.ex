defmodule BinaryTree do

  defmodule BinaryTree.Node do
    defstruct value: nil, range: nil, left: nil, right: nil
  end

  def biggest_power_of_2_after_n(n) do
    :math.pow(2, (:math.log2(n) |> Float.ceil)) |> round
  end

  def create_leaves(n) do
    for x <- 0..biggest_power_of_2_after_n(n) do
      %BinaryTree.Node{value: 0, range: x..x, left: nil, right: nil}
    end
  end

  def create_tree_from_leaves(tree, true), do: tree |> List.first

  def create_tree_from_leaves(leaves, is_root \\false) do
    leaves
    |> Enum.chunk(2)
    |> Enum.map( fn(chunk) ->

      x1..y1 = Enum.at(chunk, 0).range
      x2..y2 = Enum.at(chunk, 1).range

      %BinaryTree.Node{value: 0, range: x1..y2,
       left: Enum.at(chunk, 0), right: Enum.at(chunk, 1)}
    end)
    |> create_tree_from_leaves( length(leaves) == 2 )

  end

  def print_tree(tree) do
    IO.inspect tree 
  end

end
