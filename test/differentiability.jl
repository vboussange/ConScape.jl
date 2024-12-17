using DifferentiationInterface
import Mooncake
import Zygote
import ConScape: graph_matrix_from_raster

permeability = randn(1000, 1000)
graph_matrix_from_raster(permeability)


function objective(permeability)
    A = graph_matrix_from_raster(permeability)
    return sum(A)
end

backend = AutoMooncake(; config=nothing)
prep = prepare_gradient(objective, backend, permeability);  # this is SLOW
@time val, grad = value_and_gradient(objective, prep, backend, permeability) # this is FAST

backend = AutoZygote()
prep = prepare_gradient(objective, backend, permeability);  # this is SLOW
@time val, grad = value_and_gradient(objective, prep, backend, permeability) # this is FAST

