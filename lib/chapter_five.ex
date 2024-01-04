defmodule ChapterFive do
  @spec rember_star(any, list(any)) :: list(any)
  @doc """
  `rember_star` takes in an atom and a list and removes every instance of the
  atom in the list or in inner lists
  iex> ChapterFive.rember_star(:a, [])
  []

  iex> ChapterFive.rember_star(:c, [[:a, :b, :c], :c])
  [[:a, :b]]

  iex> ChapterFive.rember_star(:c, [[:c], [[:a, :b, :c], :c], :c])
  [[], [[:a, :b]]]
  """
  def rember_star(elem, list) do
    rember_star_helper(elem, list, [])
  end

  defp rember_star_helper(_elem, [], acc) do
    acc
    |> Enum.reverse
  end

  defp rember_star_helper(elem, [head | tail], acc)
  when is_list(head) do
    rember_star_helper(elem, tail, [rember_star_helper(elem, head, []) | acc])
  end

  defp rember_star_helper(elem, [elem | tail], acc) do
    rember_star_helper(elem, tail, acc)
  end


  defp rember_star_helper(elem, [head | tail], acc) do
    rember_star_helper(elem, tail, [head | acc])
  end

end
