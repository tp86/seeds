 local function func()
   print("func")
   return {2}
 end

 return {
   func = func
 }
