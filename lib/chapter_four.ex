defmodule ChapterFour do
  @moduledoc """
  Implements the code found in chapter four of The Little Schemer
  """
  defp add1(n), do: n + 1
  defp sub1(n), do: n - 1

  @spec plus(number, number) :: number
  @doc """
  Adds two numbers together
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
  def plus(n1, 0) do
    n1
  end

  def plus(n1, n2)
  when n2 < 0 do
    plus(n1, add1(n2))
    |> sub1
  end

  def plus(n1, n2) do
    plus(n1, sub1(n2))
    |> add1
  end

  @spec plus_opt(number, number) :: number
  @doc """
  Adds two positive numbers together. Tail call optimized
  ## Examples
  iex> ChapterFour.plus_opt(46, 12)
  58

  iex> ChapterFour.plus_opt(1, -3)
  -2

  iex> ChapterFour.plus_opt(-3, 1)
  -2
  """
  def plus_opt(n1, n2) do
    plus_opt_helper(n1, n2, 0)
  end

  defp plus_opt_helper(n1, 0, acc) do
    n1 + acc
  end

  defp plus_opt_helper(n1, n2, acc)
  when n2 < 0 do
    plus_opt_helper(n1, add1(n2), sub1(acc))
  end

  defp plus_opt_helper(n1, n2, acc) do
    plus_opt_helper(n1, sub1(n2), add1(acc))
  end

  @spec minus(number, number) :: number
  @doc """
  Subtracts n2 from n1
  ## Examples
  iex> ChapterFour.minus(46, 12)
  34
  """
  def minus(n1, 0) do
    n1
  end

  def minus(n1, n2) do
    minus(n1, sub1(n2))
    |> sub1
  end

  @spec minus_opt(number, number) :: number
  @doc"""
  Substracts n2 from n1. Tail call optimized
  ## Examples
  iex> ChapterFour.minus_opt(46, 12)
  34
  """
  def minus_opt(n1, n2) do
    minus_opt_helper(n1, n2, 0)
  end

  defp minus_opt_helper(n1, 0, acc) do
    n1 - acc
  end

  defp minus_opt_helper(n1, n2, acc)
  when n2 < 0 do
    minus_opt_helper(n1, add1(n2), add1(acc))
  end

  defp minus_opt_helper(n1, n2, acc) do
    minus_opt_helper(n1, sub1(n2), add1(acc))
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
    addtup_helper(tail, plus_opt(acc, head))
  end

  @spec times(number, number) :: number
  @doc """
  times returns the multiplication of n1 times n2
  ## Examples
  iex> ChapterFour.times(2, 3)
  6

  iex> ChapterFour.times(2, -3)
  -6

  iex> ChapterFour.times(-2, 3)
  -6
  """
  def times(n1, n2) do
    times_helper(n1, n2, 0)
  end

  defp times_helper(_n1, 0, acc) do
    acc
  end

  defp times_helper(n1, n2, acc)
  when n2 < 0 do
    times_helper(n1, add1(n2), minus_opt(acc, n1))
  end

  defp times_helper(n1, n2, acc) do
    times_helper(n1, sub1(n2), plus_opt(acc, n1))
  end
end
