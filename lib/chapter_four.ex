defmodule ChapterFour do
  @moduledoc """
  Implements the code found in chapter four of The Little Schemer
  """
  defp add1(n), do: n + 1
  defp sub1(n), do: n - 1

  @spec plus(number, number) :: number
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
  def plus(n1, n2) do
    plus_helper(n1, n2, n1)
  end

  defp plus_helper(_n1, 0, acc) do
    acc
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
  `minus` takes in two numbers and returns their difference
  ## Examples
  iex> ChapterFour.minus(46, 12)
  34

  iex> ChapterFour.minus(3, -1)
  4
  """
  def minus(n1, n2) do
    minus_helper(n1, n2, n1)
  end

  defp minus_helper(_n1, 0, acc) do
    acc
  end

  defp minus_helper(n1, n2, acc)
  when n2 < 0 do
    minus_helper(n1, add1(n2), add1(acc))
  end

  defp minus_helper(n1, n2, acc) do
    minus_helper(n1, sub1(n2), sub1(acc))
  end

  @spec addtup(list(any)) :: number
  @doc """
  `addtup` takes in a list of numbers and returns the result of their sum
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
  def sumtup(list_a, list_b) do
    sumtup_helper(list_a, list_b, [])
  end

  defp sumtup_helper([], [], acc) do
    acc
    |> Enum.reverse
  end

  defp sumtup_helper([], [head | tail], acc) do
    acc
    |> Enum.reverse
    |> Enum.concat([head | tail])
  end

  defp sumtup_helper([head | tail], [], acc) do
    acc
    |> Enum.reverse
    |> Enum.concat([head | tail])
  end

  defp sumtup_helper([head_a | tail_a], [head_b | tail_b], acc) do
    sumtup_helper(tail_a, tail_b, [plus(head_a, head_b) | acc])
  end

  @spec greater_than(number, number) :: boolean
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
  def greater_than(0, _m), do: false
  def greater_than(_n, 0), do: true

  def greater_than(n, m) do
    greater_than(sub1(n), sub1(m))
  end

  @spec less_than(number, number) :: boolean
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
  def less_than(_n, 0), do: false
  def less_than(0, _m), do: true

  def less_than(n, m) do
    less_than(sub1(n), sub1(m))
  end

  @spec equal(number, number) :: boolean
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

  @spec exp(number, number) :: number
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
  def exp(n, pow) do
    exp_helper(n, pow, 1)
  end

  defp exp_helper(0, _pow, 1) do
    0
  end

  defp exp_helper(_n, 0, acc) do
    acc
  end

  defp exp_helper(n, pow, acc) do
    exp_helper(n, sub1(pow), mult(acc, n))
  end

  @spec div(number, number) :: number
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
  def div(n, m) do
    div_helper(n, m, 0)
  end

  defp div_helper(n, m, acc)
  when n < m do
    acc
  end

  defp  div_helper(n, m, acc) do
    div_helper(minus(n, m), m, add1(acc))
  end

  @spec len(list(any)) :: number
  @doc """
  `len` receives a list and returns its length
  ## Examples
  iex> ChapterFour.len([])
  0

  iex> ChapterFour.len([1, 2, 3])
  3
  """
  def len(list) do
    len_helper(list, 0)
  end

  defp len_helper([], acc) do
    acc
  end

  defp len_helper([_head | tail], acc) do
    len_helper(tail, add1(acc))
  end

  @spec pick(number, list(any)) :: any
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

 def pick(i, list)
 when i < 0 do
  i = plus len(list), i
  pick(i, list)
 end

  def pick(0, [head | _tail]) do
    head
  end

  def pick(i, [_head | tail]) do
    pick(sub1(i), tail)
  end

  @spec rempick(number, list(any)) :: any
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
  def rempick(i, list) do
    rempick_helper(i, list, [])
  end

  defp rempick_helper(0, [_head | tail], acc) do
    acc
    |> Enum.reverse
    |> Enum.concat(tail)
  end

  defp rempick_helper(i, list, acc)
  when i < 0 do
    i = plus len(list), i
    rempick_helper(i, list, acc)
  end

  defp rempick_helper(i, [head | tail], acc) do
    rempick_helper(sub1(i), tail, [head | acc])
  end

  @spec no_nums(list(any)) :: list(any)
  @doc """
  `no_nums` takes in a list and removes every numerical element in the list

  ## Example
  iex> ChapterFour.no_nums([1, :a, 2, :b])
  [:a, :b]
  """

  def no_nums(list) do
    no_nums_helper(list, [])
  end

  defp no_nums_helper([], acc) do
    acc
    |> Enum.reverse
  end

  defp no_nums_helper([head | tail], acc)
  when is_number head do
    no_nums_helper(tail, acc)
  end

  defp no_nums_helper([head | tail], acc) do
    no_nums_helper(tail, [head | acc])
  end

  @spec all_nums(list(any)) :: list(any)
  @doc """
  `all_nums` takes in a list and removes every non-numerical element in the list

  ## Example
  iex> ChapterFour.all_nums([1, :a, 2, :b])
  [1, 2]
  """

  def all_nums(list) do
    all_nums_helper(list, [])
  end

  defp all_nums_helper([], acc) do
    acc
    |> Enum.reverse
  end

  defp all_nums_helper([head | tail], acc)
  when not is_number head do
    all_nums_helper(tail, acc)
  end

  defp all_nums_helper([head | tail], acc) do
    all_nums_helper(tail, [head | acc])
  end


end
