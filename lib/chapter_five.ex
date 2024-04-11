defmodule ChapterFive do
  @moduledoc """
  `ChapterFive` implements the functions found in chapter five of The Little Schemer
  """

  @doc """
  `rember_star` a list and an atom and removes every instance of the atom in the list or in the
  inner lists
  iex> ChapterFive.rember_star([], :a)
  []

  iex> ChapterFive.rember_star([[:a, :b, :c], :c], :c)
  [[:a, :b]]

  iex> ChapterFive.rember_star([[:c], [[:a, :b, :c], :c], :c], :c)
  [[], [[:a, :b]]]
  """
  @spec rember_star(list(any), any) :: list(any)
  def rember_star(list, elem) do
    rember_star_acc(list, elem, [])
  end

  defp rember_star_acc([], _elem, acc) do
    Enum.reverse(acc)
  end

  defp rember_star_acc([head | tail], elem, acc)
  when is_list(head) do
    rember_star_acc(tail, elem, [rember_star_acc(head, elem, []) | acc])
  end

  defp rember_star_acc([elem | tail], elem, acc) do
    rember_star_acc(tail, elem, acc)
  end

  defp rember_star_acc([head | tail], elem, acc) do
    rember_star_acc(tail, elem, [head | acc])
  end

  @doc """
  `insertR_star` takes in a list and two elements. It returns a new list with the first value
  inserted to the right of every occurrence of the second value in the list

  ## Examples
  iex> ChapterFive.insertR_star([:a, :c, [:a], [[:a, :c], :a], :a], :a, :b)
  [:a, :b, :c, [:a, :b], [[:a, :b, :c], :a, :b], :a, :b]
  """
  @spec insertR_star(list(any), any, any) :: list(any)
  def insertR_star(list, old, new) do
    insertR_star_acc(list, old, new, [])
  end

  defp insertR_star_acc([], _old, _new, acc) do
    Enum.reverse(acc)
  end

  defp insertR_star_acc([head | tail], old, new, acc)
  when is_list(head) do
    insertR_star_acc(tail, old, new, [insertR_star_acc(head, old, new, []) | acc])
  end

  defp insertR_star_acc([old | tail], old, new, acc) do
    insertR_star_acc(tail, old, new, [new, old | acc])
  end

  defp insertR_star_acc([head | tail], old, new, acc) do
    insertR_star_acc(tail, old, new, [head | acc])
  end

  @doc """
  `insertR_star_reduce` takes in a list and two values. It returns a new list with the
  first value inserted to the right of every occurrence of the second value in
  the list

  ## Examples
  iex> ChapterFive.insertR_star_reduce([:a, :c, [:a], [[:a, :c], :a], :a], :a, :b)
  [:a, :b, :c, [:a, :b], [[:a, :b, :c], :a, :b], :a, :b]
  """
  @spec insertR_star_reduce(list(any), any, any) :: list(any)
  def insertR_star_reduce(list, old, new) do
    list
    |> Enum.reduce([], fn
      elem, acc when is_list(elem) -> [insertR_star_reduce(elem, old, new) | acc]
      elem, acc when elem == old -> [new, elem | acc]
      elem, acc -> [elem | acc]
      end)
    |> Enum.reverse()
  end

  @doc """
  `occur_star` takes in a nested list and an item and counts the occurrences of the item in the
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

  defp occur_star_total([head | tail], elem, total)
  when is_list(head) do
    occur_star_total(tail, elem, occur_star_total(head, elem, total))
  end

  defp occur_star_total([elem | tail], elem, total) do
    occur_star_total(tail, elem, total+1)
  end

  defp occur_star_total([_head | tail], elem, total) do
    occur_star_total(tail, elem, total)
  end

  @doc """
  `occur_star_reduce` takes in a nested list and an item and counts the occurrences of the item in the
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

  @doc """
  `subst_star`takes in a nested list and two elements. It returns a list with every instance of the
  first element replaced by the second element

  ## Examples
  iex> ChapterFive.subst_star([], :a, :b)
  []

  iex> ChapterFive.subst_star([:z, :b, :c, [:z, :b, [:z, :b]]], :z, :a)
  [:a, :b, :c, [:a, :b, [:a, :b]]]
  """
  @spec subst_star(list(any), any, any) :: list(any)
  def subst_star(list, old, new) do
    subst_star_acc(list, old, new, [])
  end

  defp subst_star_acc([], _old, _new, acc) do
    Enum.reverse(acc)
  end

  defp subst_star_acc([head | tail], old, new, acc)
  when is_list(head) do
    subst_star_acc(tail, old, new, [subst_star_acc(head, old, new, []) | acc])
  end

  defp subst_star_acc([old | tail], old, new, acc) do
    subst_star_acc(tail, old, new, [new | acc])
  end

  defp subst_star_acc([head | tail], old, new, acc) do
    subst_star_acc(tail, old, new, [head | acc])
  end

  @doc """
  `subst_star_reduce` takes in a nested list and two elements. It returns a list with every instance of the
  first element replaced by the second element

  ## Examples
  iex> ChapterFive.subst_star_reduce([], :a, :b)
  []

  iex> ChapterFive.subst_star_reduce([:z, :b, :c, [:z, :b, [:z, :b]]], :z, :a)
  [:a, :b, :c, [:a, :b, [:a, :b]]]
  """
  @spec subst_star_reduce(list(any), any, any) :: list(any)
  def subst_star_reduce(list, old, new) do
    list
    |> Enum.reduce([], fn
      elem, acc when is_list(elem) -> [subst_star_reduce(elem, old, new) | acc]
      elem, acc when elem == old -> [new | acc]
      elem, acc -> [elem | acc]
      end)
    |> Enum.reverse
  end

  @doc"""
  `insertL_star` takes a list and two elements. It inserts the second element to the left of every
  occurrence of the first element.

  ## Examples
  iex> ChapterFive.insertL_star([:b, :c, [:b, :c, [:b, :c, :b]]], :b, :a)
  [:a, :b, :c, [:a, :b, :c, [:a, :b, :c, :a, :b]]]
  """
  @spec insertL_star(list(any), any, any) :: list(any)
  def insertL_star(list, old, new) do
    insertL_star_acc(list, old, new, [])
  end

  defp insertL_star_acc([], _old, _new, acc) do
    Enum.reverse(acc)
  end

  defp insertL_star_acc([head | tail], old, new, acc)
  when is_list(head) do
    insertL_star_acc(tail, old, new, [insertL_star_acc(head, old, new, []) | acc])
  end

  defp insertL_star_acc([old | tail], old, new, acc) do
    insertL_star_acc(tail, old, new, [old, new | acc])
  end

  defp insertL_star_acc([head | tail], old, new, acc) do
    insertL_star_acc(tail, old, new, [head | acc])
  end

  @doc"""
  `insertL_star_reduce` takes a list and two elements. It inserts the second element to the left of
  every occurrence of the first element.

  ## Examples
  iex> ChapterFive.insertL_star_reduce([:b, :c, [:b, :c, [:b, :c, :b]]], :b, :a)
  [:a, :b, :c, [:a, :b, :c, [:a, :b, :c, :a, :b]]]
  """
  @spec insertL_star_reduce(list(any), any, any) :: list(any)
  def insertL_star_reduce(list, old, new) do
    list
    |> Enum.reduce([], fn
      elem, acc when is_list(elem) -> [insertL_star_reduce(elem, old, new) | acc]
      elem, acc when elem == old -> [old, new | acc]
      elem, acc -> [elem | acc]
      end)
    |> Enum.reverse()
  end

  @doc"""
  `member_star` takes a list and an element. It returns true if the element is in the list or in the
  inner lists.

  ## Examples
  iex> ChapterFive.member_star([:a, :b, [:a, :b, :c]], :c)
  true

  iex> ChapterFive.member_star([:a, :b, [:a, :b, :c]], :d)
  false
  """
  @spec member_star(list(any), any) :: boolean
  def member_star([], _elem) do
    false
  end

  def member_star([head | tail], elem)
  when is_list(head) do
    member_star(tail, elem) || member_star(head, elem)
  end

  def member_star([elem | _tail], elem) do
    true
  end

  def member_star([_head | tail], elem) do
    member_star(tail, elem)
  end

  @doc"""
  `member_star_reduce` takes a list and an element. It returns true if the element is in the list or in the
  inner lists.

  iex> ChapterFive.member_star_reduce([:a, :b, [:a, :b, :c]], :c)
  true

  iex> ChapterFive.member_star_reduce([:a, :b, [:a, :b, :c]], :d)
  false
  """
  @spec member_star_reduce(list(any), any) :: boolean
  def member_star_reduce(list, elem) do
    Enum.reduce(list, false, fn
      e, acc when is_list(e) -> acc || member_star_reduce(e, elem)
      e, _acc when e == elem -> true
      _e, _acc -> false
    end)
  end

end
