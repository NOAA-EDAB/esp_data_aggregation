DiagrammeR::grViz("
digraph boxes_and_circles {

  # a 'graph' statement
  graph [overlap = false, fontsize = 10, layout = neato]

  # several 'node' statements
  
  # main life stages
  node [shape = box, color = blue]
  EL[label = 'eggs and larvae']
  YJ[label = 'YOY and juveniles']
  A[label = 'adults']
  SM[label = 'sneaker males']
  
  # life history processes
  node [shape = diamond, color = black] 
  SP[label = 'spawning']; R[label = 'recruitment']

  # ecosystem and socioeconomic pressures
  node [shape = oval]
  T[label = 'temperature']
  S[label = 'winter survival']
  
  SST[label = 'sea surface temperature']
  HW[label = 'marine heatwaves']
  CP[label = 'cold pool']
  
  H[label = 'habitat']
  
  F[label = 'food']
  P[label = 'predation']
  PP[label = 'phytoplankton']
  Z[label = 'zooplankton']
  OF[label = 'other fish']
  
  FR[label = 'fisheries removals']
  CPUE
  TAC
  FD[label = 'fish distribution']

  # several 'edge' statements
  EL -> R [arrowhead = none]
  R -> YJ
  YJ -> A
  A -> SP [arrowhead = none]
  SP -> EL
  A -> SM
  SM -> A
  
  {SST, HW, CP} -> T
  
  T -> {S, SP}
  S -> R
  
  H -> {A, YJ}
  
  {PP, Z} -> F
  F -> S
  
  {Z, OF} -> P
  P -> S
  
  {TAC, CPUE, FD, A} -> FR
  {CPUE, T} -> FD
  FD -> CPUE
  FR -> {A, SM}
  
}
")

