### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ 82be8262-b9e3-11ef-25fa-0def7b703c38
begin
	using Pkg
	Pkg.activate(dirname(dirname(@__DIR__)))
	using TypingSVG: mdbadge, QueryParameter
end

# ╔═╡ a22a54fc-882b-4845-90a1-518629bef353
using PlutoUI

# ╔═╡ 7f922d2f-b8f7-4bdc-985e-0195f6a932f7
script = raw"""
$ git clone https://github.com/terasakisatoshi/TypingSVG.jl.git
$ cd TypingSVG.jl
$ ls
README.md     src     Project.toml
$ julia --project -e 'using Pkg; Pkg.instantiate()'
$ julia --project -q
julia> using TypingSVG; mdbadge_file("sample.jl") |> clipboard
julia> # Insert the result into your README.md
julia> # Enjoy
julia> exit()
$
"""

# ╔═╡ e3c370a6-bfeb-4289-9617-e855b172179c
mdbadge(script) |> Markdown.parse

# ╔═╡ 5a4ad39c-9112-45fc-aa38-75440c194ae0
demo = """
using TerminalGat
gat("sample.jl") # View file contents with syntax highlighting
gess("sample.jl") # gat + less
"""

# ╔═╡ e82fae29-8451-4e3a-b46f-50c323fefd9b
let
	q = QueryParameter(size=18) # Set font size to 18
	mdbadge(demo, eval=false, insertprompt=true, queryparam=q) |> Markdown.parse
end

# ╔═╡ 6122b2d9-1ba7-4b7e-9199-ac07dfeeb69f
begin
	default = raw"""
println("Hello World")
x = 40
@show x
y = x + 2
"""
	@bind code TextField((60, 10), default=default)
end

# ╔═╡ 0fe7b824-db6e-4fd3-9595-735894b5345c
let
	mdbadge(code, eval=true) |> Markdown.parse
end

# ╔═╡ Cell order:
# ╠═82be8262-b9e3-11ef-25fa-0def7b703c38
# ╠═a22a54fc-882b-4845-90a1-518629bef353
# ╠═7f922d2f-b8f7-4bdc-985e-0195f6a932f7
# ╠═e3c370a6-bfeb-4289-9617-e855b172179c
# ╠═5a4ad39c-9112-45fc-aa38-75440c194ae0
# ╠═e82fae29-8451-4e3a-b46f-50c323fefd9b
# ╟─6122b2d9-1ba7-4b7e-9199-ac07dfeeb69f
# ╠═0fe7b824-db6e-4fd3-9595-735894b5345c
