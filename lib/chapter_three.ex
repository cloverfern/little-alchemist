defmodule ChapterThree do
  @moduledoc """
  Implements the code found in chapter three of The Little Schemer
  """

  @doc """
  takes an atom and a list and removes the first instance of that atom. tail call optimized

  ## Examples

      iex> ChapterThree.rember(:a, [])
      []

      iex> ChapterThree.rember(:b, [:a, :b, :c])
      [:a, :c]

      iex> ChapterThree.rember(:a, [:a, :b, :c, :a])
      [:b, :c, :a]
  """
  @spec rember(any, list(any)) :: list(any)
  def rember(item, list) do
    rember_acc(item, list, [])
  end

  defp rember_acc(_item, [], acc) do
    Enum.reverse(acc)
  end

  defp rember_acc(item, [item | tail], acc) do
    acc
    |> Enum.reverse()
    |> Enum.concat(tail)
  end

  defp rember_acc(item, [head | tail], acc) do
    rember_acc(item, tail, [head | acc])
  end

  @doc """
  takes a list of lists and returns the first element of each list

  ## Examples

      iex> ChapterThree.firsts([])
      []

      iex> ChapterThree.firsts([[:a, :b], [:c, :d]])
      [:a, :c]

      iex> ChapterThree.firsts([[[:a, :b], :c], [:d, :e]])
      [[:a, :b], :d]
  """
  @spec firsts(list(any)) :: list(any)
  def firsts(list) do
    firsts_acc(list, [])
  end

  defp firsts_acc([], acc) do
    Enum.reverse(acc)
  end

  defp firsts_acc([[head | _rest] | tail], acc) do
    firsts_acc(tail, [head | acc])
  end

@doc"""
inserts new to the right of old.

## Examples
    iex> ChapterThree.insertR(:b, :a, [])
    []

    iex> ChapterThree.insertR(:b, :a, [:a, :c])
    [:a, :b, :c]

    iex> ChapterThree.insertR(:c, :b, [:a, :b])
    [:a, :b, :c]
"""
@spec insertR(any, any, list(any)) :: list (any)
def insertR(new, old, l) do
  insertR_acc(new, old, l, [])
end

defp insertR_acc(_new, _old, [], acc) do
  Enum.reverse(acc)
end

defp insertR_acc(new, old, [old | tail], acc) do
  acc
  |> Enum.reverse()
  |> Enum.concat([old, new | tail])
end

defp insertR_acc(new, old, [head | tail], acc) do
  insertR_acc(new, old, tail, [head | acc])
end

@doc"""
inserts new to the left of old.

## Examples
    iex> ChapterThree.insertL(:b, :a, [])
    []

    iex> ChapterThree.insertL(:a, :b, [:b, :c])
    [:a, :b, :c]

    iex> ChapterThree.insertL(:b, :c, [:a, :c])
    [:a, :b, :c]
"""
@spec insertL(any, any, list(any)) :: list (any)
def insertL(new, old, l) do
  insertL_acc(new, old, l, [])
end

defp insertL_acc(_new, _old, [], acc) do
  Enum.reverse(acc)
end

defp insertL_acc(new, old, [old | tail], acc) do
  acc
  |> Enum.reverse()
  |> Enum.concat([new, old | tail])
end

defp insertL_acc(new, old, [head | tail], acc) do
  insertL_acc(new, old, tail, [head | acc])
end

@doc"""
substitutes first occurrence of old with new.

## Examples
    iex> ChapterThree.subst(:b, :a, [])
    []

    iex> ChapterThree.subst(:b, :a, [:a, :c])
    [:b, :c]

    iex> ChapterThree.subst(:c, :b, [:a, :b])
    [:a, :c]
"""
@spec subst(any, any, list(any)) :: list (any)
def subst(new, old, l) do
  subst_acc(new, old, l, [])
end

defp subst_acc(_new, _old, [], acc) do
  Enum.reverse(acc)
end

defp subst_acc(new, old, [old | tail], acc) do
  acc
  |> Enum.reverse()
  |> Enum.concat([new | tail])
end

defp subst_acc(new, old, [head | tail], acc) do
  subst_acc(new, old, tail, [head | acc])
end

@doc"""
substitutes either the first occurrence of o1 or the first occurrence of o2 with new.

## Examples
    iex> ChapterThree.subst2(:b, :a, :c, [])
    []

    iex> ChapterThree.subst2(:b, :a, :d, [:a, :c])
    [:b, :c]

    iex> ChapterThree.subst2(:c, :d, :b, [:a, :b, :d])
    [:a, :c, :d]

    iex> ChapterThree.subst2(:c, :x, :d, [:a, :b, :d])
    [:a, :b, :c]
"""
@spec subst2(any, any, any, list(any)) :: list (any)
def subst2(new, o1, o2, l) do
  subst2_acc(new, o1, o2, l, [])
end

defp subst2_acc(_new, _o1, _o2, [], acc) do
  Enum.reverse(acc)
end

defp subst2_acc(new, o1, _o2, [o1 | tail], acc) do
  acc
  |> Enum.reverse()
  |> Enum.concat([new | tail])
end

defp subst2_acc(new, _o1, o2, [o2 | tail], acc) do
  acc
  |> Enum.reverse()
  |> Enum.concat([new | tail])
end

defp subst2_acc(new, o1, o2, [head | tail], acc) do
  subst2_acc(new, o1, o2, tail, [head | acc])
end

  @doc """
  takes an atom and a list and removes the first instance of that atom

  ## Examples

      iex> ChapterThree.multirember(:a, [])
      []

      iex> ChapterThree.multirember(:b, [:a, :b, :c])
      [:a, :c]

      iex> ChapterThree.multirember(:a, [:a, :b, :c, :a])
      [:b, :c]
  """
  @spec multirember(any, list(any)) :: list(any)
  def multirember(item, list) do
    multirember_acc(item, list, [])
  end

  defp multirember_acc(_item, [], acc) do
    Enum.reverse(acc)
  end

  defp multirember_acc(item, [item | tail], acc) do
    multirember_acc(item, tail, acc)
  end

  defp multirember_acc(item, [head | tail], acc) do
    multirember_acc(item, tail, [head | acc])
  end

@doc"""
inserts new to the right of every occurrence of old.

## Examples
    iex> ChapterThree.multiinsertR(:b, :a, [])
    []

    iex> ChapterThree.multiinsertR(:b, :a, [:a, :c, :a])
    [:a, :b, :c, :a, :b]

    iex> ChapterThree.multiinsertR(:c, :b, [:a, :b, :b])
    [:a, :b, :c, :b, :c]
"""
@spec multiinsertR(any, any, list(any)) :: list (any)
def multiinsertR(new, old, l) do
  multiinsertR_acc(new, old, l, [])
end

defp multiinsertR_acc(_new, _old, [], acc) do
  Enum.reverse(acc)
end

defp multiinsertR_acc(new, old, [old | tail], acc) do
  multiinsertR_acc(new, old, tail, [new, old | acc])
end

defp multiinsertR_acc(new, old, [head | tail], acc) do
  multiinsertR_acc(new, old, tail, [head | acc])
end

@doc"""
inserts new to the left of every occurrence of old.

## Examples
    iex> ChapterThree.multiinsertL(:b, :a, [])
    []

    iex> ChapterThree.multiinsertL(:b, :a, [:a, :c, :a])
    [:b, :a, :c, :b, :a]

    iex> ChapterThree.multiinsertL(:c, :b, [:a, :b, :b])
    [:a, :c, :b, :c, :b]
"""
@spec multiinsertL(any, any, list(any)) :: list (any)
def multiinsertL(new, old, l) do
  multiinsertL_acc(new, old, l, [])
end

defp multiinsertL_acc(_new, _old, [], acc) do
  Enum.reverse(acc)
end

defp multiinsertL_acc(new, old, [old | tail], acc) do
  multiinsertL_acc(new, old, tail, [old, new | acc])
end

defp multiinsertL_acc(new, old, [head | tail], acc) do
  multiinsertL_acc(new, old, tail, [head | acc])
end

@doc"""
substitutes every occurrence of old with new.

## Examples
    iex> ChapterThree.multisubst(:b, :a, [])
    []

    iex> ChapterThree.multisubst(:b, :a, [:a, :c, :a])
    [:b, :c, :b]
"""
@spec multisubst(any, any, list(any)) :: list (any)
def multisubst(new, old, l) do
  multisubst_acc(new, old, l, [])
end

defp multisubst_acc(_new, _old, [], acc) do
  Enum.reverse(acc)
end

defp multisubst_acc(new, old, [old | tail], acc) do
  multisubst_acc(new, old, tail, [new | acc])
end

defp multisubst_acc(new, old, [head | tail], acc) do
  multisubst_acc(new, old, tail, [head | acc])
end

end
