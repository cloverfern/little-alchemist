defmodule ChapterFour do
  @moduledoc """
  Implements the code found in chapter four of The Little Schemer
  """
  defp add1(n), do: n + 1
  defp sub1(n), do: n - 1

  @spec plus(any(), number()) :: any()
  @doc """
  Adds two positive numbers together
  ## Examples
  iex> ChapterFour.plus(46, 12)
  58
  """
  def plus(n1, 0) do
    n1
  end

  def plus(n1, n2) do
    plus(n1, sub1(n2))
    |> add1
  end
  """
  plus(1, 2)>
    plus(1, 1)>
      plus(1, 0)> 1
    add1(1) > 2
  add1(2) > 3
  """

  @doc """
  Adds two positive numbers together. Tail call optimized
  ## Examples
  iex> ChapterFour.plus_opt(46, 12)
  58
  """
  def plus_opt(n1, n2) do
    plus_opt_helper(n1, n2, 0)
  end

  defp plus_opt_helper(n1, 0, acc) do
    n1 + acc
  end

  defp plus_opt_helper(n1, n2, acc) do
    plus_opt_helper(n1, sub1(n2), add1(acc))
  end

  def minus(n1, 0) do
    n1
  end

  @spec minus(any(), number()) :: any()
  @doc """
  Subtracts n2 from n1
  ## Examples
  iex> ChapterFour.minus(46, 12)
  34
  """
  def minus(n1, n2) do
    minus(n1, sub1(n2))
    |> sub1
  end

end
