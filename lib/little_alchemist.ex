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

  @spec rember_nopt_helper(any, list(any)) :: list(any)
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

  @spec firsts(list(any)) :: list(any)
  @doc """
  takes a list of lists and returns the first element of each list

  ## Examples

      iex> LittleAlchemist.firsts([])
      []

      iex> LittleAlchemist.firsts([[:a, :b], [:c, :d]])
      [:a, :c]

      iex> LittleAlchemist.firsts([[[:a, :b], :c], [:d, :e]])
      [[:a, :b], :d]
  """
  def firsts(list) do
    firsts_helper(list, [])
  end

  defp firsts_helper([], acc), do: acc |> Enum.reverse

  defp firsts_helper([[head | _rest] | tail], acc) do
    firsts_helper(tail, [head | acc])
  end

@spec insertR(any, any, list(any)) :: list (any)
@doc"""
inserts new to the right of old.

## Examples
    iex> LittleAlchemist.insertR(:b, :a, [])
    []

    iex> LittleAlchemist.insertR(:b, :a, [:a, :c])
    [:a, :b, :c]

    iex> LittleAlchemist.insertR(:c, :b, [:a, :b])
    [:a, :b, :c]
"""
def insertR(new, old, l) do
  insertR_helper(new, old, l, [])
end

defp insertR_helper(_new, _old, [], acc), do: acc |> Enum.reverse

defp insertR_helper(new, old, [old | tail], acc) do
  Enum.reverse(acc) ++ [old, new | tail]
end

defp insertR_helper(new, old, [head | tail], acc) do
  insertR_helper(new, old, tail, [head | acc])
end

@spec insertL(any, any, list(any)) :: list (any)
@doc"""
inserts new to the left of old.

## Examples
    iex> LittleAlchemist.insertL(:b, :a, [])
    []

    iex> LittleAlchemist.insertL(:a, :b, [:b, :c])
    [:a, :b, :c]

    iex> LittleAlchemist.insertL(:b, :c, [:a, :c])
    [:a, :b, :c]
"""
def insertL(new, old, l) do
  insertL_helper(new, old, l, [])
end

defp insertL_helper(_new, _old, [], acc), do: acc |> Enum.reverse

defp insertL_helper(new, old, [old | tail], acc) do
  Enum.reverse(acc) ++ [new, old | tail]
end

defp insertL_helper(new, old, [head | tail], acc) do
  insertL_helper(new, old, tail, [head | acc])
end

@spec subst(any, any, list(any)) :: list (any)
@doc"""
substitutes first occurrence of old with new.

## Examples
    iex> LittleAlchemist.subst(:b, :a, [])
    []

    iex> LittleAlchemist.subst(:b, :a, [:a, :c])
    [:b, :c]

    iex> LittleAlchemist.subst(:c, :b, [:a, :b])
    [:a, :c]
"""
def subst(new, old, l) do
  subst_helper(new, old, l, [])
end

defp subst_helper(_new, _old, [], acc), do: acc |> Enum.reverse

defp subst_helper(new, old, [old | tail], acc) do
  Enum.reverse(acc) ++ [new | tail]
end

defp subst_helper(new, old, [head | tail], acc) do
  subst_helper(new, old, tail, [head | acc])
end

@spec subst2(any, any, any, list(any)) :: list (any)
@doc"""
substitutes either the first occurrence of o1 or the first occurrence of o2 with new.

## Examples
    iex> LittleAlchemist.subst2(:b, :a, :c, [])
    []

    iex> LittleAlchemist.subst2(:b, :a, :d, [:a, :c])
    [:b, :c]

    iex> LittleAlchemist.subst2(:c, :d, :b, [:a, :b, :d])
    [:a, :c, :d]

    iex> LittleAlchemist.subst2(:c, :x, :d, [:a, :b, :d])
    [:a, :b, :c]
"""
def subst2(new, o1, o2, l) do
  subst2_helper(new, o1, o2, l, [])
end

defp subst2_helper(_new, _o1, _o2, [], acc), do: acc |> Enum.reverse

defp subst2_helper(new, o1, _o2, [o1 | tail], acc) do
  Enum.reverse(acc) ++ [new | tail]
end

defp subst2_helper(new, _o1, o2, [o2 | tail], acc) do
  Enum.reverse(acc) ++ [new | tail]
end

defp subst2_helper(new, o1, o2, [head | tail], acc) do
  subst2_helper(new, o1, o2, tail, [head | acc])
end

  @spec multirember(any, list(any)) :: list(any)
  @doc """
  takes an atom and a list and removes the first instance of that atom

  ## Examples

      iex> LittleAlchemist.multirember(:a, [])
      []

      iex> LittleAlchemist.multirember(:b, [:a, :b, :c])
      [:a, :c]

      iex> LittleAlchemist.multirember(:a, [:a, :b, :c, :a])
      [:b, :c]
  """
  def multirember(item, list) do
    multirember_helper(item, list, [])
  end

  defp multirember_helper(_item, [], acc), do: acc |> Enum.reverse

  defp multirember_helper(item, [item | tail], acc) do
    multirember_helper(item, tail, acc)
  end

  defp multirember_helper(item, [head | tail], acc) do
    multirember_helper(item, tail, [head | acc])
  end

@spec multiinsertR(any, any, list(any)) :: list (any)
@doc"""
inserts new to the right of every occurrence of old.

## Examples
    iex> LittleAlchemist.multiinsertR(:b, :a, [])
    []

    iex> LittleAlchemist.multiinsertR(:b, :a, [:a, :c, :a])
    [:a, :b, :c, :a, :b]

    iex> LittleAlchemist.multiinsertR(:c, :b, [:a, :b, :b])
    [:a, :b, :c, :b, :c]
"""
def multiinsertR(new, old, l) do
  multiinsertR_helper(new, old, l, [])
end

defp multiinsertR_helper(_new, _old, [], acc), do: acc |> Enum.reverse

defp multiinsertR_helper(new, old, [old | tail], acc) do
  multiinsertR_helper(new, old, tail, [new, old | acc])
end

defp multiinsertR_helper(new, old, [head | tail], acc) do
  multiinsertR_helper(new, old, tail, [head | acc])
end

@spec multiinsertL(any, any, list(any)) :: list (any)
@doc"""
inserts new to the left of every occurrence of old.

## Examples
    iex> LittleAlchemist.multiinsertL(:b, :a, [])
    []

    iex> LittleAlchemist.multiinsertL(:b, :a, [:a, :c, :a])
    [:b, :a, :c, :b, :a]

    iex> LittleAlchemist.multiinsertL(:c, :b, [:a, :b, :b])
    [:a, :c, :b, :c, :b]
"""
def multiinsertL(new, old, l) do
  multiinsertL_helper(new, old, l, [])
end

defp multiinsertL_helper(_new, _old, [], acc), do: acc |> Enum.reverse

defp multiinsertL_helper(new, old, [old | tail], acc) do
  multiinsertL_helper(new, old, tail, [old, new | acc])
end

defp multiinsertL_helper(new, old, [head | tail], acc) do
  multiinsertL_helper(new, old, tail, [head | acc])
end

@spec multisubst(any, any, list(any)) :: list (any)
@doc"""
substitutes every occurrence of old with new.

## Examples
    iex> LittleAlchemist.multisubst(:b, :a, [])
    []

    iex> LittleAlchemist.multisubst(:b, :a, [:a, :c, :a])
    [:b, :c, :b]
"""
def multisubst(new, old, l) do
  multisubst_helper(new, old, l, [])
end

defp multisubst_helper(_new, _old, [], acc), do: acc |> Enum.reverse

defp multisubst_helper(new, old, [old | tail], acc) do
  multisubst_helper(new, old, tail, [new | acc])
end

defp multisubst_helper(new, old, [head | tail], acc) do
  multisubst_helper(new, old, tail, [head | acc])
end

end
