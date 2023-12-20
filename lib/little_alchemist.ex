defmodule LittleAlchemist do
  @moduledoc """
  `LittleAlchemist` Implements the code for the book The Little Schemer
  in idiomatic Elixir.
  """

  @spec rember(any, list(any)) :: list(any)
  @doc """
  takes an atom and a list and removes the first instance of that atom. tail call optimized

  ## Examples

      iex> LittleAlchemist.rember(:a, [])
      []

      iex> LittleAlchemist.rember(:b, [:a, :b, :c])
      [:a, :c]

      iex> LittleAlchemist.rember(:a, [:a, :b, :c, :a])
      [:b, :c, :a]
  """
  def rember(item, list) do
    rember_helper(item, list, [])
  end

  defp rember_helper(_item, [], acc), do: acc |> Enum.reverse

  defp rember_helper(item, [item | tail], acc) do
    Enum.reverse(acc) ++ tail
  end

  defp rember_helper(item, [head | tail], acc) do
    rember_helper(item, tail, [head | acc])
  end

  @spec rember_all(any, list(any)) :: list(any)
  @doc """
  takes an atom and a list and removes the first instance of that atom

  ## Examples

      iex> LittleAlchemist.rember_all(:a, [])
      []

      iex> LittleAlchemist.rember_all(:b, [:a, :b, :c])
      [:a, :c]

      iex> LittleAlchemist.rember_all(:a, [:a, :b, :c, :a])
      [:b, :c]
  """
  def rember_all(item, list) do
    rember_all_helper(item, list, [])
  end

  defp rember_all_helper(_item, [], acc), do: acc |> Enum.reverse

  defp rember_all_helper(item, [item | tail], acc) do
    rember_all_helper(item, tail, acc)
  end

  defp rember_all_helper(item, [head | tail], acc) do
    rember_all_helper(item, tail, [head | acc])
  end

  @spec rember_nopt(any, list(any)) :: list(any)
  @doc """
  takes an atom and a list and removes the first instance of that atom. Without tail call optimization

  ## Examples

      iex> LittleAlchemist.rember_nopt(:a, [])
      []

      iex> LittleAlchemist.rember_nopt(:b, [:a, :b, :c])
      [:a, :c]

      iex> LittleAlchemist.rember_nopt(:a, [:a, :b, :c, :a])
      [:b, :c, :a]
  """
  def rember_nopt(item, list) do
    rember_nopt_helper(item, list)
  end

  defp rember_nopt_helper(_item, []), do: []

  defp rember_nopt_helper(item, [item | tail]) do
    tail
  end

  defp rember_nopt_helper(item, [head | tail]) do
    [head] ++ rember_nopt_helper(item, tail)
  end
end
