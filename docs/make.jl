using TopOptGridap
using Documenter

DocMeta.setdocmeta!(TopOptGridap, :DocTestSetup, :(using TopOptGridap); recursive=true)

makedocs(;
    modules=[TopOptGridap],
    authors="Mohamed Tarek <mohamed82008@gmail.com> and contributors",
    repo="https://github.com/JuliaTopOpt/TopOptGridap.jl/blob/{commit}{path}#{line}",
    sitename="TopOptGridap.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://JuliaTopOpt.github.io/TopOptGridap.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/JuliaTopOpt/TopOptGridap.jl",
)
