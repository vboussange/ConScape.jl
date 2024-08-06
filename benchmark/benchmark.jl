using ConScape, BenchmarkTools

datadir = joinpath(dirname(pathof(ConScape)), "..", "data")
_tempdir = mkdir(tempname())

landscape = "sno_2000"
θ = 0.1

affinity_raster, _ = ConScape.readasc(joinpath(datadir, "affinities_$landscape.asc"))

affinities = ConScape.graph_matrix_from_raster(affinity_raster)
qualities , _ = ConScape.readasc(joinpath(datadir, "qualities_$landscape.asc"))


g = ConScape.Grid(size(affinity_raster)...,
    affinities=affinities,
    qualities=qualities
    )
    
@benchmark ConScape.GridRSP($g, θ=θ)

#=
with \ operator and full matrix
BenchmarkTools.Trial: 85 samples with 1 evaluation.
 Range (min … max):  56.549 ms … 67.513 ms  ┊ GC (min … max): 0.00% … 2.62%
 Time  (median):     58.636 ms              ┊ GC (median):    0.00%
 Time  (mean ± σ):   58.823 ms ±  2.010 ms  ┊ GC (mean ± σ):  1.50% ± 1.51%

  █ ▄   ▆ ▂   ▄▄▆▄ ▆                                           
  █▆█████▁█▁▁█████▄█▆█▄▆▁▁▆▄▆▁▁▁▄▁▁▁▁▆▄▁▁▁▁▁▁▄▁▁▁▁▁▁▁▁▁▁▄▁▁▁▄ ▁
  56.5 ms         Histogram: frequency by time        65.7 ms <

 Memory estimate: 48.07 MiB, allocs estimate: 153.
=#