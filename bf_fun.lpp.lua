|>
	pointer = 0
  
  function move_ptr_from_to(current, target)
    if target > current then
			return (">"):rep(target - current)
		else 
			return ("<"):rep(current - target)
		end
  end
  
	function move_ptr(target)
		local mov = move_ptr_from_to(pointer, target)
		pointer = target
		return mov
	end
  
	function inc_by(by)
		if by > 0 then
			return ("+"):rep(by)
		else
			return ("-"):rep(-by)
		end
	end
  
  function dec_by(by)
    return inc_by(-by)
  end

	function move_to(...)
    local prev_target = pointer
    local increment_cells = {}
    for i, target in ipairs({...}) do
      increment_cells[i] = move_ptr_from_to(prev_target, target) .. "+"
      prev_target = target
    end
    return table.concat {
      "[-",
      table.concat(increment_cells),
      move_ptr_from_to(prev_target, pointer),
      "]",
    }
	end
  
  --TODO copy to multiple
  function copy_to(temporary, target)
    local _pointer = pointer
    return table.concat {
      move_to(target, temporary),
      move_ptr(temporary),
      move_to(_pointer),
      move_ptr(_pointer),
    }
  end
  
  ---reset the cell to zero
  set_0 = "[-]"
  
  ---increment/decrement double-cell integer, requres one free cell to the right
  inc_double = "+>+[<->[->+<]]>[-<+>]<<"
  dec_double = ">[<+>[->+<]]>[-<+>]<-<-"
  
  function inc_double_by(by)
    if by > 0 then
			return (inc_double):rep(by)
		else
			return (dec_double):rep(-by)
		end
  end
  function dec_double_by(by)
    return inc_double_by(-by)
  end
  
  function add_single_to_double(double_ptr)
    return table.concat {
      "[",
      move_ptr_from_to(pointer, target),
      
      move_ptr_from_to(target, pointer),
      "]",
    }
  end
<|