# 字符串
# 1. Elixir通过""包裹来创建字符串
# 2. 一个字符串是一个被编码成UTF-8的二进制数
string = "hełło"
IO.puts string
IO.puts byte_size string # byte_size/1计算的是字符串的字节数
IO.puts String.length string # String.length/1计算的是字符数

# 二进制型（和位串）
# 1. Elixir中，可以使用<<>>来定义一个二进制型
# 2. 一个二进制型是一个字节序列。其中的字节可以被视为任何东西，甚至这个字节序列根本不是一个合法的字符串
# 3. 字符串连接操作实际上就是二进制型的连接操作
# 4. 二进制型中的每个数字都表示一个字节，因此每个数字的最大值是255。二进制型允许传递一个修饰符来存储大于255的值，或者把一个码点转换成UTF-8
# 5. 当一个二进制型的位数不能被8整除时，它是一个位串
unknown = <<0, 1, 2, 3>>
IO.puts unknown
IO.puts byte_size unknown
IO.puts String.valid? <<239, 191, 191>>
IO.puts "hełło" <> <<0>>
IO.puts <<256 :: size(16)>> # 使用16bits(2bytes)来存储256 其实等价与大端存储 <<1, 0>> 00000001 00000000
IO.puts <<256 :: utf8>> # 将一个数字转为UTF-8存储 Unicode 码点 U+0100 -> UTF-8 会按照自己的变长规则编码 U+0100 -> 11000100 10000000
IO.puts is_binary <<1 :: size(16)>>
IO.puts is_binary <<1 :: size(15)>>

# 对二进制型或者位串进行模式匹配
<<0, 1, x>> = <<0, 1, 2>> # 在二进制模式中，每个项将恰好匹配8位
IO.puts x
<<0, 1, x :: binary>> = <<0, 1, 2, 3>>
IO.puts x

"he" <> rest = "hello"
IO.puts rest

# 字符列表
# 1. 字符列表只不过是一个码点的列表。可以使用~c单引号包裹的字符串来创建字符列表
list = ~c'hełło'
IO.puts is_list list
IO.puts List.first list
