
using DataStructures
using DelimitedFiles
import JSON

pkgdir = "julia/LibDLF.jl/"

# Create package directories
mkpath(pkgdir * "src")
mkpath(pkgdir * "src/lib")
mkpath(pkgdir * "test")

# Copy package license
cp("LICENSE", pkgdir * "LICENSE" ,force=true)

# Copy filter data file license
cp("../LICENSE", pkgdir * "src/lib/LICENSE",force=true)

# Get current version number in git
version = chomp(split(read(`git describe --tags`, String), "-")[1][2:end])

# Create Project.toml
iop = open(abspath(pkgdir * "Project.toml"), "w")
println(iop,"name = \"LibDLF\"")
println(iop,"uuid = \"f0c3f387-4ff6-435f-9d63-77e28b8d1347\"")
println(iop,"authors = [\"The emsig community <info@emsig.xyz> \"]")
println(iop,"version = \"$version\"")
println(iop,"\n[deps]")
println(iop,"DelimitedFiles = \"8bb1440f-4735-579b-a4ab-409b98df4dab\"")
println(iop,"\n[compat]")
println(iop,"julia = \"1\"")
println(iop,"\n[extras]")
println(iop,"Test = \"8dfed614-e22c-5e08-85e1-65c5234f0b40\"")
println(iop,"\n[targets]")
println(iop,"test = [\"Test\"]")
close(iop)

# Open runtests.jl
iotest = open(abspath(pkgdir * "/Test/runtests.jl"), "w")
println(iotest,"using LibDLF")
println(iotest,"using Test")

# Test settings
println(iotest,"\n# Relative tolerance for test result accuracy")
println(iotest,"test_rtol = 1e-4")

println(iotest,"\n# Test at x=1. where filters usually have small relative error")
println(iotest,"x_test = 1.")

# Add testing function pairs to runtest.jl
println(iotest,"\n# Testing function pairs (from Anderson,1975, with a=1)")
println(iotest,"rhs_j0(x)   = exp(-x^2 / 4.) / 2.")
println(iotest,"rhs_j1(x)   = exp(-x^2 / 4.) * x / 4.")
println(iotest,"lhs_j0(lam) = exp(-lam^2) * lam")
println(iotest,"lhs_j1(lam) = exp(-lam^2) * lam^2")
println(iotest,"rhs_fcos(x) = exp(-x^2 / 4.) / 2 * sqrt(π)")
println(iotest,"rhs_fsin(x) = exp(-x^2 / 4.) / 4 * sqrt(π) * x")
println(iotest,"lhs_fcos(ω) = exp(-ω^2)")
println(iotest,"lhs_fsin(ω) = exp(-ω^2) * ω")

# J0 transform test function
println(iotest,"\nfunction j0_test(base,j0)")
println(iotest,"\tlam = base/x_test")
println(iotest,"\tfht = (lhs_j0.(lam)' * j0) / x_test")
println(iotest,"\trhs =  rhs_j0(x_test)")
println(iotest,"\treturn abs(fht - rhs) ./ abs(rhs) ")
println(iotest,"end")

# J1 transform test function
println(iotest,"\nfunction j1_test(base,j1)")
println(iotest,"\tlam = base/x_test")
println(iotest,"\tfht = (lhs_j1.(lam)' * j1) / x_test")
println(iotest,"\trhs =  rhs_j1(x_test)")
println(iotest,"\treturn abs(fht - rhs) ./ abs(rhs) ")
println(iotest,"end")

# cos transform test function
println(iotest,"\nfunction fcos_test(base,fcos)")
println(iotest,"\tω = base/x_test")
println(iotest,"\tfct = (lhs_fcos.(ω)' * fcos) / x_test")
println(iotest,"\trhs =  rhs_fcos(x_test)")
println(iotest,"\treturn abs(fct - rhs) ./ abs(rhs) ")
println(iotest,"end")

# sin transform test function
println(iotest,"\nfunction fsin_test(base,fsin)")
println(iotest,"\tω = base/x_test")
println(iotest,"\tfst = (lhs_fsin.(ω)' * fsin) / x_test")
println(iotest,"\trhs =  rhs_fsin(x_test)")
println(iotest,"\treturn abs(fst - rhs) ./ abs(rhs) ")
println(iotest,"end")

println(iotest,"\n# Unit tests")
# Read in .json file listing all filters
filters = JSON.parsefile("../lib/filters.json", dicttype=DataStructures.OrderedDict)

# Create Julia module
iol = open(abspath(pkgdir * "src/LibDLF.jl"), "w")

# Module name
println(iol,"module LibDLF\n")

# Create LibDLF.jl files
for type in filters.keys

    stype = titlecase(type)

    # Make directory for this type
    mkpath(pkgdir * "src/lib/$stype")

    # Add filter type section to runtests.jl
    println(iotest, "\n@testset \"$stype\" begin")

    # Include sub module file in parent
    println(iol, "include(\"$stype.jl\")")

    # Create sub module file for filter type
    iot = open(abspath(pkgdir * "src/$stype.jl"), "w")
    println(iot, "module $stype\n")

    # Add library path variable
    println(iot, "libpath = @__DIR__")

    # Add cache
    println(iot, "\ncache = Dict() # local cache for any filters already loaded")

    # Add filter functions
    for filt in filters[type]

        # Get and write header as docstring
        iof = open(abspath("../" * filt["file"]), "r")

        # Title
        println(iot, "\n\"\"\"")
        sname = filt["name"]
        println(iot, "\t $sname()\n")
        println(iot, readline(iof)[2:end])

        # Get vals and preformat if sin & cos
        vals = replace(filt["values"], "," => ", ")
        if type == "fourier"
            vals = replace(vals, "cos" => "fcos")
            vals = replace(vals, "sin" => "fsin")
        end

        # Rest of header
        for line in eachline(iof)

            # Do not copy the title-underline; just newline
            if contains(line, "========")
                println(iot, "")

            # Empty lines: only remove comment
            elseif line == "#\n"
                println(iot, "")

            # The license is the last thing of the header
            elseif contains(line, "This file is part of libdlf")

                # Add returned vals
                println(iot, "# Returns\n")
                println(iot, "base, $vals :: Array{Float64,1}")
                println(iot, "Filter base and its values.\n")

                # Example
                println(iot, "# Example\n")
                println(iot, "```julia")
                println(iot, "base, $vals = LibDLF.$stype.$sname()")
                println(iot, "```")

                # Finish header
                println(iot, "\n\"\"\"")

                # Stop header loop
                break

            # Print entire line
            else
                println(iot, line[2:end])

            end

        end

        # Read filter data from text file
        dat = readdlm("../" * filt["file"], comments=true)

        # Save filter data to binary file
        bfile = pkgdir * "src/" * filt["file"] * ".bin"
        iob = open(bfile, "w")
        write(iob, htol.(dat)) # htol converts from host endian from to little endian
        close(iob)

        # Write function to load binary data
        bfile  =  filt["file"] * ".bin"
        println(iot, "function $sname()")
        println(iot, "\tif !haskey(cache,\"$sname\") # read and add to cache")
        println(iot, "\t\tbfile = joinpath(libpath,\"$bfile\")")
        println(iot, "\t\tbdat = Array{Float64}(undef,", size(dat, 1), ",", size(dat, 2), ")");
        println(iot, "\t\tread!(open(bfile,\"r\"),bdat)")
        println(iot, "\t\tbdat .= ltoh(bdat) # file save with little endian so convert to host's endian")
        println(iot, "\t\tcache[\"$sname\"]= tuple([bdat[:,c] for c in 1:size(bdat,2)]...)")
        println(iot, "\tend")
        println(iot, "\treturn cache[\"$sname\"]")
        println(iot, "end")

        # Close file
        close(iof)

        # Add filter tests to runtests.jl
        println(iotest, "\n\t@testset \"$sname\" begin")
        println(iotest, "\t\tbase, $vals = LibDLF.$stype.$sname()")
        for val in strip.(split(vals, ","))
            ft = val * "_test"
            println(iotest, "\t\t@test $ft(base,$val) < test_rtol")
        end
        println(iotest, "\tend")
    end

    println(iotest, "end")

    # Close filter type sub module
    println(iot, "\nend")
    close(iot)
end

# Close LibDLF module
println(iol,"\nend")
close(iol)

# Close runtest.jl
close(iotest)

# Create README
iord = open(abspath(pkgdir * "README.md"), "w")
println(iord,"\n# Julia package for LibDLF\n")
str = "[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.5172893.svg)]"
str *= "(https://doi.org/10.5281/zenodo.5172893)"
println(iord,"\n$str")
str = "[![package-julia]"
str *= "(https://github.com/emsig/libdlf/actions/workflows/package-julia.yml/badge.svg)]"
str *= "(https://github.com/emsig/libdlf/actions/workflows/package-julia.yml)"
println(iord,"\n$str")
println(iord,"\nThis package is auto-generated. See
[emsig/libdlf](https://github.com/emsig/libdlf) for installation and usage
instructions.")

close(iord)
