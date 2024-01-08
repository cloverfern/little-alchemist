defmodule ChapterFive do
  @moduledoc """
  `ChapterFive` implrements the functions found in chapter five of The Little
  Schemer
  """

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
  @spec rember_star(any, list(any)) :: list(any)
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

  @doc """
  `insertR_star` takes in two values and a list. It returns a new list with the
  first value inserted to the right of every occurance of the second value in
  the list

  ## Examples
  iex> ChapterFive.insertR_star(:b, :a, [:a, :c, [:a], [[:a, :c], :a], :a])
  [:a, :b, :c, [:a, :b], [[:a, :b, :c], :a, :b], :a, :b]
  """
  @spec insertR_star(any, any, list(any)) :: list(any)
  def insertR_star(new, old, list) do
    insertR_star_helper(new, old, list, [])
  end

  defp insertR_star_helper(_new, _old, [], acc), do: acc |> Enum.reverse

  defp insertR_star_helper(new, old, [head | tail], acc)
  when is_list(head) do
    insertR_star_helper(new, old, tail, [insertR_star_helper(new, old, head, []) | acc])
  end

  defp insertR_star_helper(new, old, [old | tail], acc) do
    insertR_star_helper(new, old, tail, [new, old | acc])
  end

  defp insertR_star_helper(new, old, [head | tail], acc) do
    insertR_star_helper(new, old, tail, [head | acc])
  end

end
