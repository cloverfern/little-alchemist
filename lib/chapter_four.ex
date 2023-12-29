defmodule ChapterFour do
  @moduledoc """
  Implements the code found in chapter four of The Little Schemer
  """
  defp add1(n), do: n + 1
  defp sub1(n), do: n - 1

  @spec plus(number, number) :: number
  @doc """
  `plus` returns the sum of two numbers.

  ## Examples
  iex> ChapterFour.plus(46, 12)
  58

  iex> ChapterFour.plus(-1, -2)
  -3

  iex> ChapterFour.plus(1, -3)
  -2

  iex> ChapterFour.plus(-6, 2)
  -4
  """
  def plus(n1, n2) do
    plus_helper(n1, n2, 0)
  end

  defp plus_helper(n1, 0, acc) do
    n1 + acc
  end

  defp plus_helper(n1, n2, acc)
  when n2 < 0 do
    plus_helper(n1, add1(n2), sub1(acc))
  end

  defp plus_helper(n1, n2, acc) do
    plus_helper(n1, sub1(n2), add1(acc))
  end

  @spec minus(number, number) :: number
  @doc"""
  `minus` returns the difference between two numbers
  ## Examples
  iex> ChapterFour.minus(46, 12)
  34

  iex> ChapterFour.minus(3, -1)
  4
  """
  def minus(n1, n2) do
    minus_helper(n1, n2, 0)
  end

  defp minus_helper(n1, 0, acc) do
    n1 - acc
  end

  defp minus_helper(n1, n2, acc)
  when n2 < 0 do
    minus_helper(n1, add1(n2), sub1(acc))
  end

  defp minus_helper(n1, n2, acc) do
    minus_helper(n1, sub1(n2), add1(acc))
  end

  @spec addtup(list(any)) :: number
  @doc """
  addtup adds all of the numbers in a tuple and returns the result
  ## Example
  iex> ChapterFour.addtup([1, 2, 3])
  6

  iex> ChapterFour.addtup([1, 2, -3])
  0
  """
  def addtup(l) do
    addtup_helper(l, 0)
  end

  defp addtup_helper([], acc) do
    acc
  end

  defp addtup_helper([head | tail], acc) do
    addtup_helper(tail, plus(acc, head))
  end

  @spec mult(number, number) :: number
  @doc """
  `mult` returns the product of 2 numbers
  ## Examples
  iex> ChapterFour.mult(2, 3)
  6

  iex> ChapterFour.mult(2, -3)
  -6

  iex> ChapterFour.mult(-2, 3)
  -6

  iex> ChapterFour.mult(3, 0)
  0
  """
  def mult(n1, n2) do
    mult_helper(n1, n2, 0)
  end

  defp mult_helper(_n1, 0, acc) do
    acc
  end

  defp mult_helper(n1, n2, acc)
  when n2 < 0 do
    mult_helper(n1, add1(n2), minus(acc, n1))
  end

  defp mult_helper(n1, n2, acc) do
    mult_helper(n1, sub1(n2), plus(acc, n1))
  end

  @spec sumtup(list(number), list(number)) :: list(number)
  @doc """
    `sumtup` takes two lists of numbers and returns a new list where each element
     is the sum of the corresponding elements from the two input lists.

    This function expects both input lists to be of the same length. It performs
    element-wise addition, where the first element of the first list is added to
    the first element of the second list, the second element of the first list
    to the second element of the second list, and so on.

    If the lists are of different lengths, the behavior is undefined.

    ## Examples

    iex> ChapterFour.sumtup([1, 1, 1], [2, 2, 2])
    [3, 3, 3]

    iex> ChapterFour.sumtup([3, 4, 5], [1, 2, 3])
    [4, 6, 8]

    ## Notes

    - If given empty lists, the function will return an empty list.
    - The function does not perform type checking on the elements of the lists.
    It's the caller's responsibility to ensure that both lists contain only
    numbers.
  """
  def sumtup(list_a, list_b) do
    sumtup_helper(list_a, list_b, [])
  end

  defp sumtup_helper([], [], acc) do
    acc
    |> Enum.reverse
  end

  defp sumtup_helper([head_a | tail_a], [head_b | tail_b], acc) do
    sumtup_helper(tail_a, tail_b, [plus(head_a, head_b) | acc])
  end

end
