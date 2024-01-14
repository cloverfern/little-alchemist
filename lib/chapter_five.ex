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
    rember_star_acc(elem, list, [])
  end

  defp rember_star_acc(_elem, [], acc) do
    Enum.reverse(acc)
  end

  defp rember_star_acc(elem, [head | tail], acc)
  when is_list(head) do
    rember_star_acc(elem, tail, [rember_star_acc(elem, head, []) | acc])
  end

  defp rember_star_acc(elem, [elem | tail], acc) do
    rember_star_acc(elem, tail, acc)
  end

  defp rember_star_acc(elem, [head | tail], acc) do
    rember_star_acc(elem, tail, [head | acc])
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
    insertR_star_acc(new, old, list, [])
  end

  defp insertR_star_acc(_new, _old, [], acc) do
    Enum.reverse(acc)
  end

  defp insertR_star_acc(new, old, [head | tail], acc)
  when is_list(head) do
    insertR_star_acc(new, old, tail, [insertR_star_acc(new, old, head, []) | acc])
  end

  defp insertR_star_acc(new, old, [old | tail], acc) do
    insertR_star_acc(new, old, tail, [new, old | acc])
  end

  defp insertR_star_acc(new, old, [head | tail], acc) do
    insertR_star_acc(new, old, tail, [head | acc])
  end

  @doc """
  `occur_star` takes in a nested list and an item and counts the occurencces of the item in the
  list and the lists within

  ## Examples
  iex> ChapterFive.occur_star([], :a)
  0

  iex> ChapterFive.occur_star([:a, :a], :a)
  2

  iex> ChapterFive.occur_star([:a, :b, [:a, :a, [:a, :b]]], :a)
  4

  iex> ChapterFive.occur_star([:a, [:a, :a]], :a)
  3
  """
  @spec occur_star(list(any), any) :: integer
  def occur_star(list, elem) do
    occur_star_total(list, elem, 0)
  end

  defp occur_star_total([], _elem, total) do
    total
  end

  defp occur_star_total([[head | tail] | tail2], elem, total) do
    occur_star_total(tail2, elem, occur_star_total([head|tail], elem, total))
  end

  defp occur_star_total([elem | tail], elem, total) do
    occur_star_total(tail, elem, total+1)
  end

  defp occur_star_total([_head | tail], elem, total) do
    occur_star_total(tail, elem, total)
  end

  @doc """
  `occur_star_reduce` takes in a nested list and an item and counts the occurencces of the item in the
  list and the lists within

  ## Examples
  iex> ChapterFive.occur_star_reduce([], :a)
  0

  iex> ChapterFive.occur_star_reduce([:a, :a], :a)
  2

  iex> ChapterFive.occur_star_reduce([:a, :b, [:a, :a, [:a, :b]]], :a)
  4

  iex> ChapterFive.occur_star_reduce([:a, [:a, :a]], :a)
  3
  """
  def occur_star_reduce(list, elem) do
    Enum.reduce(list, 0, fn
      e, total when e == elem -> total + 1
      e, total when is_list(e) -> total + occur_star_reduce(e, elem)
      _, total -> total
      end)
  end

end
