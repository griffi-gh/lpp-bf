|> 
  ---effectively separates code into chunks during optimization
  bf_opt_boundary = "_opt_boundary_" 

  postprocess.optimize_bf = function(code, bf_opt_assume)
    local ass = bf_opt_assume or _G.bf_opt_assume or { all = true }
    local replacement_table = {
      "<>",
      "><",
      "%+%-",
      "%-%+",
      (ass.all or ass.no_inf_loop) and "%[%]",
      (ass.all or ass.zeroed_cells) and "^%[.-%]",
      (ass.all or ass.bits_8) and ("%-"):rep(256),
      (ass.all or ass.bits_8) and ("%+"):rep(256),
      (ass.all or ass.move_is_noop) and "(<+)$",
      (ass.all or ass.move_is_noop) and "(>+)$",
    }
    while true do
      local replacements = 0
      for _, v in ipairs(replacement_table) do
        if type(v) == "string" then
          local _code, count = code:gsub(v, "")
          replacements = replacements + count
          code = _code
        end
      end
      if (replacements == 0) or (#code == 0) then
        --TODO optimize + > 128 and - > 128 if bf_opt_assume.bits_8
        return code:gsub(bf_opt_boundary, "")
      end
    end
  end
<|