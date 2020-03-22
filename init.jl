using Pkg

ENV["PYTHON"] = "/srv/julia/pkg/conda/3/bin"
Pkg.build("PyCall")

using PyPlot