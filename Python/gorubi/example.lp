\ Model AndOr
\ LP format - for model browsing. Use MPS format to capture full model detail.
Minimize
  x + y + z
Subject To
 R0: x + y + z + RgR0 = 12
Bounds
 RgR0 <= 7
General Constraints
 GC0: z = AND ( x , y )
End
