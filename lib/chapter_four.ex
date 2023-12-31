defmodule ChapterFour do
  @moduledoc """
  Implements the code found in chapter four of The Little Schemer
  """
  defp add1(n), do: n + 1

  defp sub1(n), do: n - 1

  @doc """
  `plus` takes in two numbers and returns their sum

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
  @spec plus(number, number) :: number
  def plus(n1, n2) do
    plus_total(n1, n2, n1)
  end

  defp plus_total(_n1, 0, total) do
    total
  end

  defp plus_total(n1, n2, total)
  when n2 < 0 do
    plus_total(n1, add1(n2), sub1(total))
  end

  defp plus_total(n1, n2, total) do
    plus_total(n1, sub1(n2), add1(total))
  end

  @doc"""
  `minus` takes in two numbers and returns their difference
  ## Examples
  iex> ChapterFour.minus(46, 12)
  34

  iex> ChapterFour.minus(3, -1)
  4
  """
  @spec minus(number, number) :: number
  def minus(n1, n2) do
    minus_total(n1, n2, n1)
  end

  defp minus_total(_n1, 0, total) do
    total
  end

  defp minus_total(n1, n2, total)
  when n2 < 0 do
    minus_total(n1, add1(n2), add1(total))
  end

  defp minus_total(n1, n2, total) do
    minus_total(n1, sub1(n2), sub1(total))
  end

  @doc """
  `addtup` takes in a list of numbers and returns the result of their sum
  ## Example
  iex> ChapterFour.addtup([1, 2, 3])
  6

  iex> ChapterFour.addtup([1, 2, -3])
  0
  """
  @spec addtup(list(any)) :: number
  def addtup(l) do
    addtup_acc(l, 0)
  end

  defp addtup_acc([], acc) do
    acc
  end

  defp addtup_acc([head | tail], acc) do
    addtup_acc(tail, plus(acc, head))
  end

  @doc """
  `mult` takes 2 numbers and returns returns their product
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
  @spec mult(number, number) :: number
  def mult(n1, n2) do
    mult_total(n1, n2, 0)
  end

  defp mult_total(_n1, 0, total) do
    total
  end

  defp mult_total(n1, n2, total)
  when n2 < 0 do
    mult_total(n1, add1(n2), minus(total, n1))
  end

  defp mult_total(n1, n2, total) do
    mult_total(n1, sub1(n2), plus(total, n1))
  end

  @doc """
    `sumtup` takes two lists of numbers and returns a new list where each element
     is the sum of the corresponding elements from the two input lists.

    It performs element-wise addition, where the first element of the first list
    is added to the first element of the second list, the second element of the
    first list to the second element of the second list, and so on.

    If the lists are of different lengths, the shorter list is treated as
    having a pad of zeroes to the right to match the length of the longer one.

    ## Examples

    iex> ChapterFour.sumtup([1, 1, 1], [2, 2, 2])
    [3, 3, 3]

    iex> ChapterFour.sumtup([3, 4, 5], [1, 2, 3])
    [4, 6, 8]

    iex> ChapterFour.sumtup([1, 2], [0, 0, 3])
    [1, 2, 3]

    iex> ChapterFour.sumtup([0, 0, 3], [1, 2])
    [1, 2, 3]

    ## Notes

    - If given empty lists, the function will return an empty list.
    - The function does not perform type checking on the elements of the lists.
    It's the caller's responsibility to ensure that both lists contain only
    numbers.
  """
  @spec sumtup(list(number), list(number)) :: list(number)
  def sumtup(list_a, list_b) do
    sumtup_acc(list_a, list_b, [])
  end

  defp sumtup_acc([], [], acc) do
    Enum.reverse(acc)
  end

  defp sumtup_acc([], [head | tail], acc) do
    acc
    |> Enum.reverse()
    |> Enum.concat([head | tail])
  end

  defp sumtup_acc([head | tail], [], acc) do
    acc
    |> Enum.reverse()
    |> Enum.concat([head | tail])
  end

  defp sumtup_acc([head_a | tail_a], [head_b | tail_b], acc) do
    sumtup_acc(tail_a, tail_b, [plus(head_a, head_b) | acc])
  end

  @doc """
    `sumtup_map` does the same as `sumtup` but uses map to do it

    ## Examples

    iex> ChapterFour.sumtup_map([1, 1, 1], [2, 2, 2])
    [3, 3, 3]

    iex> ChapterFour.sumtup_map([3, 4, 5], [1, 2, 3])
    [4, 6, 8]

    ## Notes

    - If given empty lists, the function will return an empty list.
    - The function does not perform type checking on the elements of the lists.
    It's the caller's responsibility to ensure that both lists contain only
    numbers.
    - Lists must be the same length
  """
  @spec sumtup_map(list(number), list(number)) :: list(number)
  def sumtup_map(list_a, list_b) do
    list_a
    |> Enum.zip(list_b)
    |> Enum.map(fn {a, b} -> plus(a, b) end)
  end

  @doc """
  `greater_than` takes in two numbers and returns true if the first number is
  larger than the second, otherwise it returns false.

  ## Examples
  iex> ChapterFour.greater_than(5, 3)
  true

  iex> ChapterFour.greater_than(2, 3)
  false

  iex> ChapterFour.greater_than(3, 3)
  false
  """
  @spec greater_than(number, number) :: boolean
  def greater_than(0, _m), do: false
  def greater_than(_n, 0), do: true

  def greater_than(n, m) do
    greater_than(sub1(n), sub1(m))
  end

  @doc """
  `less_than` takes in two numbers and returns true if the first number is
  smaller than the second, otherwise it returns false.

  ## Examples
  iex> ChapterFour.less_than(5, 3)
  false

  iex> ChapterFour.less_than(2, 3)
  true

  iex> ChapterFour.less_than(3, 3)
  false
  """
  @spec less_than(number, number) :: boolean
  def less_than(_n, 0), do: false
  def less_than(0, _m), do: true

  def less_than(n, m) do
    less_than(sub1(n), sub1(m))
  end

  @doc """
  `equal` takes in two numbers and returns true if the first number is
  equal to the second, otherwise it returns false.

  ## Examples
  iex> ChapterFour.equal(5, 3)
  false

  iex> ChapterFour.equal(2, 3)
  false

  iex> ChapterFour.equal(3, 3)
  true
  """
  @spec equal(number, number) :: boolean
  def equal(n, m) do
    cond do
      less_than(n, m) ->
         false

      greater_than(n, m) ->
        false

      true ->
        true
    end
  end

  @doc """
  `exp` takes two numbers and returns the first number raised to the power of
  the second number

  ## Example
  iex> ChapterFour.exp(2, 2)
  4

  iex> ChapterFour.exp(5, 5)
  3125

  iex> ChapterFour.exp(0, 100)
  0

  iex> ChapterFour.exp(1, 50)
  1
  """
  @spec exp(number, number) :: number
  def exp(n, pow) do
    exp_total(n, pow, 1)
  end

  defp exp_total(0, _pow, 1) do
    0
  end

  defp exp_total(_n, 0, total) do
    total
  end

  defp exp_total(n, pow, total) do
    exp_total(n, sub1(pow), mult(total, n))
  end

  @doc """
  `div` takes in two numbers and returns the quotient of the two
  ## Examples
  iex> ChapterFour.div(12, 6)
  2

  iex> ChapterFour.div(10, 100)
  0

  iex> ChapterFour.div(100, 10)
  10

  iex> ChapterFour.div(8, 3)
  2
  """
  @spec div(number, number) :: number
  def div(n, m) do
    div_total(n, m, 0)
  end

  defp div_total(n, m, total)
  when n < m do
    total
  end

  defp  div_total(n, m, total) do
    div_total(minus(n, m), m, add1(total))
  end

  @doc """
  `len` receives a list and returns its length
  ## Examples
  iex> ChapterFour.len([])
  0

  iex> ChapterFour.len([1, 2, 3])
  3
  """
  @spec len(list(any)) :: number
  def len(list) do
    len_total(list, 0)
  end

  defp len_total([], total) do
    total
  end

  defp len_total([_head | tail], total) do
    len_total(tail, add1(total))
  end

  @doc """
  `len_reduce` receives a list and returns its length
  ## Examples
  iex> ChapterFour.len_reduce([])
  0

  iex> ChapterFour.len_reduce([1, 2, 3])
  3
  """
  @spec len_reduce(list(any)) :: number
  def len_reduce(list), do: Enum.reduce(list, 0,  fn _, total -> add1(total) end)

  @doc """
  `pick` takes in a number and a list and returns the value at that location in
  the list. The number is zero indexed. The caller is responsible for passing a
  number within the bounds of the list.

  #Examples
  iex> ChapterFour.pick(0, [1])
  1

  iex> ChapterFour.pick(1, [1, 2])
  2

  iex> ChapterFour.pick(2, [1, 2, 3])
  3

  iex> ChapterFour.pick(-1, [1, 2, 3])
  3
  """
  @spec pick(number, list(any)) :: any
  def pick(i, list)
  when i < 0 do
    i
    |> plus(len_reduce(list))
    |> pick(list)
  end

  def pick(0, [head | _tail]) do
    head
  end

  def pick(i, [_head | tail]) do
    pick(sub1(i), tail)
  end

  @doc """
  `rempick` takes in a number and a list and returns the list without the value
  at the location of the number. The list is zero indexed.

  #Examples
  iex> ChapterFour.rempick(0, [1])
  []

  iex> ChapterFour.rempick(1, [1, 2])
  [1]

  iex> ChapterFour.rempick(2, [1, 2, 3])
  [1, 2]

  iex> ChapterFour.rempick(-1, [1, 2, 3])
  [1, 2]
  """
  @spec rempick(number, list(any)) :: any
  def rempick(i, list) do
    rempick_acc(i, list, [])
  end

  defp rempick_acc(0, [_head | tail], acc) do
    acc
    |> Enum.reverse()
    |> Enum.concat(tail)
  end

  defp rempick_acc(i, list, acc)
  when i < 0 do
    i
    |> plus(len_reduce(list))
    |> rempick_acc(list, acc)
  end

  defp rempick_acc(i, [head | tail], acc) do
    rempick_acc(sub1(i), tail, [head | acc])
  end

  @doc """
  `rempick_reduce` takes in a number and a list and returns the list without the value
  at the location of the number. The list is zero indexed.

  #Examples
  iex> ChapterFour.rempick_reduce(0, [1])
  []

  iex> ChapterFour.rempick_reduce(1, [1, 2])
  [1]

  iex> ChapterFour.rempick_reduce(2, [1, 2, 3])
  [1, 2]

  iex> ChapterFour.rempick_reduce(-1, [1, 2, 3])
  [1, 2]
  """
  @spec rempick_reduce(number, list(any)) :: any
  def rempick_reduce(i, list)
  when i < 0 do
    i
    |> plus(len_reduce(list))
    |> rempick_reduce(list)
  end

  def rempick_reduce(i, list) do
    list
    |> Enum.with_index()
    |> Enum.reduce([], fn
      {elem, index}, acc when index != i -> [elem | acc]
      _, acc -> acc
      end)
    |> Enum.reverse
  end

  @doc """
  `no_nums` takes in a list and removes every numerical element in the list

  ## Example
  iex> ChapterFour.no_nums([1, :a, 2, :b])
  [:a, :b]
  """
  @spec no_nums(list(any)) :: list(any)
  def no_nums(list) do
    no_nums_acc(list, [])
  end

  defp no_nums_acc([], acc) do
    Enum.reverse(acc)
  end

  defp no_nums_acc([head | tail], acc)
  when is_number head do
    no_nums_acc(tail, acc)
  end

  defp no_nums_acc([head | tail], acc) do
    no_nums_acc(tail, [head | acc])
  end

  @doc """
  `no_nums_filter` takes in a list and removes every numerical element in the list

  ## Example
  iex> ChapterFour.no_nums_filter([1, :a, 2, :b])
  [:a, :b]
  """
  @spec no_nums_filter(list(any)) :: list(any)
  def no_nums_filter(list) do
    Enum.filter(list, fn x -> not is_number(x) end)
  end

  @doc """
  `all_nums` takes in a list and removes every non-numerical element in the list

  ## Example
  iex> ChapterFour.all_nums([1, :a, 2, :b])
  [1, 2]
  """
  @spec all_nums(list(any)) :: list(any)
  def all_nums(list) do
    all_nums_acc(list, [])
  end

  defp all_nums_acc([], acc) do
    Enum.reverse(acc)
  end

  defp all_nums_acc([head | tail], acc)
  when not is_number head do
    all_nums_acc(tail, acc)
  end

  defp all_nums_acc([head | tail], acc) do
    all_nums_acc(tail, [head | acc])
  end

  @doc """
  `all_nums_filter` takes in a list and removes every non-numerical element in the list

  ## Example
  iex> ChapterFour.all_nums_filter([1, :a, 2, :b])
  [1, 2]
  """
  @spec all_nums_filter(list(any)) :: list(any)
  def all_nums_filter(list) do
    Enum.filter(list, fn x -> is_number(x) end)
  end

  @doc """
  `occur` takes in any, and a list and counts the number of times that the
  element appears in the list

  ## Examples
  iex> ChapterFour.occur(1, [])
  0

  iex> ChapterFour.occur(1, [2, 3])
  0

  iex> ChapterFour.occur(:a, [:a, :b, :a, :c, :a])
  3
  """
  @spec occur(any, list(any)) :: number
  def occur(elem, list) do
    occur_acc(elem, list, 0)
  end

  defp occur_acc(_elem, [], acc) do
    acc
  end

  defp occur_acc(elem, [elem | tail], acc) do
    occur_acc(elem, tail, add1(acc))
  end

  defp occur_acc(elem, [_head | tail], acc) do
    occur_acc(elem, tail, acc)
  end

  @doc """
  `occur_reduce` takes in any, and a list and counts the number of times that the
  element appears in the list

  ## Examples
  iex> ChapterFour.occur_reduce(1, [])
  0

  iex> ChapterFour.occur_reduce(1, [2, 3])
  0

  iex> ChapterFour.occur_reduce(:a, [:a, :b, :a, :c, :a])
  3
  """
  @spec occur_reduce(any, list(any)) :: number
  def occur_reduce(elem, list) do
    Enum.reduce(list, 0, fn
      e, acc when e == elem -> add1(acc)
      _, acc -> acc
    end)
  end
end
