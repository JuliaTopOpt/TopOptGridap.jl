module TopOptGridap

using Gridap

function get_domain()
    #domain = (0, 160, 0, 40)
    #partition = (160, 40)
    domain = (0, 1, 0, 1)
    partition = (10, 10)
    model = CartesianDiscreteModel(domain, partition)
    labels = get_face_labeling(model)
    add_tag_from_tags!(labels, "diri_0", [1, 3, 7])
    add_tag_from_tags!(labels, "diri_1", [2, 4, 8])

    order = 1
    E = 70.0e9
    ν = 0.33
    λ = (E * ν) / ((1 + ν) * (1 - 2 * ν))
    μ = E / (2 * (1 + ν))
    σ(ε) = λ * tr(ε) * one(ε) + 2 * μ * ε

    degree = 2 * order
    Ω = Triangulation(model)
    dΩ = Measure(Ω, degree)
    T = Float64
    reffe = ReferenceFE(lagrangian, VectorValue{2, T}, order)
    V0 = TestFESpace(
        model, reffe;
        vector_type = Vector{T},
        conformity = :H1,
        dirichlet_tags = ["diri_0", "diri_1"],
        dirichlet_masks = [(true, false), (true, true)],
    )
    g1(x) = VectorValue(convert(T, 0.005), convert(T, 0.0))
    g2(x) = VectorValue(convert(T, 0.0), convert(T, 0.0))
    U = TrialFESpace(V0, [g1, g2])
    l(v) = zero(T)

    function displacements(cell_param)
        ρ = CellField(cell_param, Ω)
        a(u, v) = ∫( ρ * ε(v) ⊙ (σ ∘ ε(u)) ) * dΩ
        op = AffineFEOperator(a, l, U, V0)
        uh = solve(op)
        return get_free_dof_values(uh)
    end, rand(num_cells(model))
end

end
