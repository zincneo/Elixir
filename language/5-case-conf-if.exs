# case
# 1. case允许我们使用多个模式去匹配一个值，直到找到可以匹配的那个模式，类似rust的match
# 2. case有返回值，就是每一个分支最后一个表达式计算得到的值
# 3. 但是给函数使用的时候需要()包裹避免编译器理解错误，这里没有办法直接使用如IO.puts case 这样的用法
# 4. do end表示一个区块，类似其他语言{}包裹，但是并非全部情况会产生局部作用域，case是会产生局部作用域的
# 5. 匹配方式是patter = case后面的表达式，匹配成功->进入对应的分支处理逻辑，因此不想绑定而是匹配现有变量值也是需要使用^运算符
a = 10
IO.puts(
  case {1, 2, 3} do
    {4, 5, 6} ->
      "This clause won't match"
    {1, x, 3} ->
      a = 20
      IO.puts a
      "This clause will match and bind x to #{x} in this clause"
    _ ->
      "This clause would match any value"
  end
)
IO.puts a

case 10 do
  ^a -> IO.puts a
  _ -> nil
end

# case中的哨兵语句
# 在分支模式patten后加上when关键字配合哨兵语句(表达式返回布尔值)对其进行限制
# 1. 比较操作符 (==, !=, ===, !==, >, >=, <, <=)
# 2. 布尔操作符 (and, or, not)
# 3. !!!!逻辑运算符 (&&, ||, !)不可以出现在哨兵语句中
# 4. 算数运算符 (+, -, *, /)
# 5. 一元算数运算符 (+, -)
# 6. 二进制级联操作符 (<>)
# 7. 使用in操作符时右边需要是一个范围或这列表
# 8. 类型检查函数: is_atom/1 is_binary/1 is_bitstring/1 is_boolean/1 is_float/1 is_function/1 is_function/2 is_integer/1 is_list/1 is_map/1 is_nil/1 is_number/1 is_pid/1 is_port/1 is_reference/1 is_tuple/1
# 9. abs(number) binary_part(binary, start, length) bit_size(bitstring) byte_size(bitstring) div(integer, integer) elem(tuple, n) hd(list) length(list) map_size(map) node() node(pid | ref | port) rem(integer, integer) round(number) self() tl(list) trunc(number) tuple_size(tuple)
# 10. 用户可以定义自己的哨兵。比如，Bitwise模块定义了一系列函数和操作符作为哨兵：bnot, ~~~, band, &&&, bor, |||, bxor, ^^^, bsl, <<<, bsr, >>>.
# 11. 哨兵中的错误不会泄露到外部，而是导致哨兵失败

# hd(1) ** (ArgumentError) argument error
IO.puts(
case 1 do
  x when hd(x) -> "Won't match"
  x -> "Got #{x}"
end)

# case抛出异常
# 1. 当case所有子句都没有匹配上的情况才会抛出异常
# case :ok do
#   :error -> "Won't match"
# end
# ** (CaseClauseError) no case clause matching: :ok

# 匿名函数配合哨兵语句
# 1. 可以一些其他语言难以实现的神奇操作,如通过判断传入参数的类型不同执行不同的操作
# 2. 子句的参数数量必须一致，否则会报错
# 3. 参数调用数量正确但是不能匹配任何子句的时候也会报错** (FunctionClauseError) no function clause matching in anonymous
f = fn a, b when a > 0 and b > 0 -> a + b
       a, b when a < 0 and b < 0 -> -a - b 
       a, b -> a - b
    end
f = fn a when is_atom a -> IO.puts a
       a when is_boolean a -> IO.puts !a
    end

# f.(10)
f.(:atom)
f.(true)

# cond
# 检查一些不同的条件并且找到第一个成立的条件。这种情况下，可以使用cond
# 1. case用于已经有一个值，需要通过这个值的结构来决定执行什么操作
# 2. cond则应用于大量的if else if的情况，没有模式匹配只接受表达式布尔值判断
# 3. cond的所有条件都失败则会抛出异常（CondClauseError）
# 4. cond会把除了nil和false的所有值认为是true
result = {:ok, 100}
case result do
  {:ok, value} ->
    IO.puts("成功")
    IO.inspect(value)
  {:error, reason} ->
    IO.inspect(reason)
end
age = 25
# 其他语言if else if else,Elixir也可以这么写，但是由于Elixir没有else if只有if和else，所以其实是通过do end嵌套很多层级，只是Elixir其实是不关心缩进所以看着有else if罢了
if age < 18 do
    IO.puts "未成年"
else if age < 30 do
    IO.puts "青年"
else if age < 60 do
    IO.puts "中年"
else
    IO.puts "老年"
end
end
end
# 符合缩进会嵌套很多层
if age < 18 do
    IO.puts "未成年"
else
  if age < 30 do
    IO.puts "青年"
  else
    if age < 60 do
      IO.puts "中年"
    else
      IO.puts "老年"
    end
  end
end
# 使用cond
cond do
  age < 18 ->
    IO.puts "未成年"
  age < 30 ->
    IO.puts "青年"
  age < 60 ->
    IO.puts "中年"
  true ->
    IO.puts "老年"
end

# if和unless
# 1. 除了case和cond，Elixir还提供if/2和unless/2两个宏用来处理只有一个条件的情况
# 2. if 支持 else 块，没有else if
# 3. 如果传递给if/2的条件返回false或nil，do/end块中的代码就不会被执行，并且整个结构会返回nil。unless/2则相反
# 4. 注意这两个在Elixir中是宏不是关键字
if true do
  IO.puts "This works!"
end
if nil do
  "This won't be seen"
else
  "This will"
end

# do end块
# 1. 不是一个独立的语法，而是一种"块（block）"语法
# 2. 用于所有控制结构 if unless case conf with receive try for
# 3. 函数定义def
# 4. 模块定义defmodule
# 5. 协议、结构体、测试
# 6. do...end有缩写语法糖果, do: 注意只有if unless for with可以这么用
num = if true, do: 1 + 2
IO.puts num
_num = if num > 1, do: -1, else: 1
# 这是因为if是一个宏而非是关键字语法结构，实际上这里的,绝对不能理解为;在分割语句，编译器的理解更加接近以下的做法，其中`,`是在分割宏的参数
# if(
#     true,
#     do: 1 + 2
# )
# Elixir其实是有分号的;将多行语句写在同一行只是极少有人这么写Elixir的代码
