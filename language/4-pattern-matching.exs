# 匹配操作符
# 1. Elixir的=操作符实际上被叫做匹配操作符
# 2. 让左右两边的模式（pattern）统一（unify），如果能统一就成功，否则报错
# 3. 注意这个运算符的真正处理流程是先将右边当作表达式算出结果，然后用左侧的值去匹配右侧的值
# 4. pattern = expression
x = 1 # 表示用1匹配变量x
1 = x # 表示用变量x的值去匹配1，现在变量的值是1因此匹配成功
# 2 = x # 表示用变量x的值去匹配2，现在变量的值是1因此匹配失败，抛出错误 ** (MatchError) no match of right hand side value: 1
# 1 = unknown # 由于变量unknown没有被赋值过，Elixir会认为你尝试调用一个叫做unknown/0的函数，但这个函数并不存在
# 5. 匹配操作符不仅可以用于匹配简单类型的值，还可以用来对复杂数据类型进行解构
{a, b, c} = {:hello, "hello", ~c'hello'}
IO.puts "#{a} #{b} #{c}"
# {a, b, c} = {:hello, "world"} # ** (MatchError) no match of right hand side value: {:hello, "world"}
# {a, b, c} = [:hello, "world", 42] # ** (MatchError) no match of right hand side value: [:hello, "world", 42]
# 6. 元组第一个值是:ok的时候才允许匹配成功
{:ok, _result} = {:ok, 13}
# 7. 可以通过表头表尾语法对列表进行匹配
[_head | _tail] = [1, 2, 3] # head 1 tail [2, 3]

# 变量
# 1. 变量名在=运算符左侧作为模式的时候可以代表任何值也就是总能匹配成功并且绑定，类似其他语言变量被重新赋值
_a = 1
_a = 2
# 2. Elixir变量名必须小写或者_开头
# 3. 大写开头在Elixir中是模块名不能用作变量使用=左侧会报错
# 4. 单个_不是变量名而是作为模式匹配用的通配符，其他变量使用_开头的时候编译器不会警告该变量没有使用
# 5. 可以包含数字
# 6. 变量名和函数名可以包含?，社区约定?作为末尾的变量和函数返回布尔值
_name? = true

# ^运算符
# 1. 当变量名在=左侧不想重新绑定值而是只作值匹配的时候在变量名前加上^运算符
x = 3
{_a, ^x, _b} = {0, 3, 1} 
