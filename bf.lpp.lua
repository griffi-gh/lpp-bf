|>! include "bf_opt.lpp.lua" <|
|>! include "bf_fun.lpp.lua" <|

|>! postprocess "remove_whitespace" <|
|>! postprocess "optimize_bf" <|

|>
  local text = "hello world"
  for i=1,#text do
    _(bf.move_ptr(i))
    _(bf.inc_by(text:sub(i,i):byte()))
  end
  _(bf.move_ptr(1))
  _(bf.print_zero_terminated)
<|
