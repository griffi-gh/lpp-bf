|>
  bf = {}
  
	bf.pointer = 0
  
  function bf.move_ptr_from_to(current, target)
    if target > current then
			return (">"):rep(target - current)
		else 
			return ("<"):rep(current - target)
		end
  end
  
	function bf.move_ptr(target)
		local mov = bf.move_ptr_from_to(bf.pointer, target)
		bf.pointer = target
		return mov
	end
  
	function bf.inc_by(by)
		if by > 0 then
			return ("+"):rep(by)
		else
			return ("-"):rep(-by)
		end
	end
  
  function bf.dec_by(by)
    return bf.inc_by(-by)
  end

	function bf.move_to(...)
    local prev_target = bf.pointer
    local increment_cells = {}
    for i, target in ipairs({...}) do
      increment_cells[i] = bf.move_ptr_from_to(prev_target, target) .. "+"
      prev_target = target
    end
    return table.concat {
      "[-",
      table.concat(increment_cells),
      bf.move_ptr_from_to(prev_target, bf.pointer),
      "]",
    }
	end
  
  --TODO copy to multiple
  function bf.copy_to(temporary, target)
    local _pointer = bf.pointer
    return table.concat {
      bf.move_to(target, temporary),
      bf.move_ptr(temporary),
      bf.move_to(_pointer),
      bf.move_ptr(_pointer),
    }
  end
  
  ---reset the cell to zero
  bf.set_0 = "[-]"
  
  ---prints string (needs to be zero terminated on *both* ends!)
  bf.print_zero_terminated = "[.>]<[<]>"
  
  ---increment/decrement double-cell integer, requres one free cell to the right
  bf.inc_double = "+>+[<->[->+<]]>[-<+>]<<"
  bf.dec_double = ">[<+>[->+<]]>[-<+>]<-<-"
  
  function bf.inc_double_by(by)
    if by > 0 then
			return (bf.inc_double):rep(by)
		else
			return (bf.dec_double):rep(-by)
		end
  end
  function bf.dec_double_by(by)
    return bf.inc_double_by(-by)
  end
  
  function bf.add_single_to_double(double_ptr)
    return table.concat {
      "[",
        bf.move_ptr_from_to(pointer, target),
        bf.move_ptr_from_to(target, pointer),
      "]",
    }
  end
<|