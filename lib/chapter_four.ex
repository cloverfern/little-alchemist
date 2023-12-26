defmodule ChapterFour do
  @moduledoc """
  Implements the code found in chapter four of The Little Schemer
  """
  defp add1(n), do: n + 1
  defp sub1(n), do: n - 1

  @doc """
  Adds two numbers together
  ## Examples
  iex> ChapterFour.plus(46, 12)
  58
  """
  def plus(n1, 0) do
    n1
  end

  def plus(n1, n2) do
    add1(plus(n1, sub1(n2)))
  end

  @doc """
  ## Example
  iex> ChapterFour.plus2(46, 12)
  58
  """
  def plus2(n1, n2) do
    plus2_helper(n1, n2, 0)
  end

  defp plus2_helper(n1, 0, acc) do
    n1 + acc
  end

  defp plus2_helper(n1, n2, acc) do
    plus2_helper(n1, sub1(n2), add1(acc))
  end


end
