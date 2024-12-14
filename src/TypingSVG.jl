module TypingSVG

using URIs
using CodeEvaluation

export mdbadge, mdbadge_file

"""
    QueryParameter

Query parameter for Readme Typing SVG

We change the default values of the following keys for Julian:
- multiline: false => true
- Background: "00000000" => "000000FF"
- colour: "#36BCF7FF" => "#B3E053"
- widthInt 435 => 700
- height 50 => 300

The rest of the keys should be the same as in https://readme-typing-svg.demolab.com/demo
"""
@kwdef struct QueryParameter
    font::String = "Fira Code" # Font
    weight::Int = 400 # Font weight
    size::Int = 20 # Font size
    letterSpacing::String = "normal" # Letter spacing
    duration::Int = 1000 # Duration (ms per line)
    pause = 200 # Pause (ms after line)
    color = "#B3E053" # Font color
    background = "#000000FF" # Background color
    center::Bool = false # Horizontally Centered
    vcenter::Bool = false # Vertically Centered
    multiline::Bool = true # Multiline
    repeat::Bool = true # Repeat
    random::Bool = false # Random
    width::Int = 700 # Width
    height::Int = 300 # Height
    separator::String = ";;"
end

function mdbadge(
    code::AbstractString;
    queryparam::QueryParameter = QueryParameter(),
    eval = false,
    insertprompt = false,
)
    lines = if eval
        sb = CodeEvaluation.Sandbox()
        r = CodeEvaluation.replblock!(sb, code)
        lines = CodeEvaluation.join_to_string(r)
        join(filter(!isempty, split(lines, "\n")), queryparam.separator)
    else
        lines = filter(!isempty, split(code, "\n"))
        if insertprompt
            for i in eachindex(lines)
                lines[i] = "julia> " * lines[i]
            end
        end
        join(lines, queryparam.separator)
    end
    # convert QueryParameter as dict
    d = Dict(
        fieldnames(QueryParameter) .=>
            getfield.(Ref(queryparam), fieldnames(QueryParameter)),
    )
    d[:lines] = lines
    query = URIs.escapeuri(d)
    "![Typing SVG](https://readme-typing-svg.demolab.com?$(query))"
end

function mdbadge_file(file::AbstractString; kwargs...)
    mdbadge(read(file, String); kwargs...)
end

end # module TypingSVG
