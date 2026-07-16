# 基本运算符
# 1. 算数运算符+ - * /，注意/默认就是浮点数除法
# 2. ++ -- 运算符创作列表
# 3. <> 运算符连接字符串
_ = "Hello" <> " world"
# 4. or and not 运算符 第一个参数必须是一个布尔值，如果第一个参数不是布尔值将抛出异常
IO.puts true and 1 # 输出1
# 1 and true # ** (BadBooleanError) expected a boolean on left-side of "and", got: 1
# true and 1 and true # ** (BadBooleanError) expected a boolean on left-side of "and", got: 1
# or和and是短路操作符。如果它们执行一侧的表达式之后就能得出结果则会忽略剩下的表达式
# 5. Elixir还提供||、&&和!，这几个操作符可以接受任何类型的值作为参数，它们会把除了false和nil以外的任何值当作true
_ = 1 || true # true
# 6. > < <= >= == === 比较运算符，Elixir还可以比较不同类型的值的大小number < atom < reference < function < port < pid < tuple < map < list < bitstring，== 和 === 只在比较浮点数和整数时有差异，==允许不同数值类型比较，===则必须是完全相同类型才比较，这两个运算符对于其他类型毫无区别比javascript中的设计明确的多
_ = 1 <= 2
_ = 1 < :atom
_ = :atom < {}
