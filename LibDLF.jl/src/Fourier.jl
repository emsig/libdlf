module Fourier

libpath = @__DIR__

cache = Dict() # local cache for any filters already loaded

"""
	 key_81_2009()

 81 point Fourier filter, Sine and Cosine


 Designed and tested for controlled-source electromagnetic data.


 > Key, K., 2009;
 > 1D inversion of multicomponent, multifrequency marine CSEM data:
 > Methodology and synthetic studies for resolving thin resistive layers;
 > Geophysics, 74(2), F9-F20;
 > DOI: 10.1190/1.3058434


 Copyright 2009 Kerry Key

 This work is licensed under a CC BY 4.0 license.
 <http://creativecommons.org/licenses/by/4.0/>.

# Returns

base, fsin, fcos :: Array{Float64,1}
Filter base and its values.

# Example

```julia
base, fsin, fcos = LibDLF.Fourier.key_81_2009()
```

"""
function key_81_2009()
	if !haskey(cache,"key_81_2009") # read and add to cache
		bfile = joinpath(libpath,"lib/Fourier/fourier_key_81_2009_sincos.txt.bin")
		bdat = Array{Float64}(undef,81,3)
		read!(open(bfile,"r"),bdat)
		bdat .= ltoh(bdat) # file save with little endian so convert to host's endian
		cache["key_81_2009"]= tuple([bdat[:,c] for c in 1:size(bdat,2)]...)
	end
	return cache["key_81_2009"]
end

"""
	 key_241_2009()

 241 point Fourier filter, Sine and Cosine


 Designed and tested for controlled-source electromagnetic data.


 > Key, K., 2009;
 > 1D inversion of multicomponent, multifrequency marine CSEM data:
 > Methodology and synthetic studies for resolving thin resistive layers;
 > Geophysics, 74(2), F9-F20;
 > DOI: 10.1190/1.3058434


 Copyright 2009 Kerry Key

 This work is licensed under a CC BY 4.0 license.
 <http://creativecommons.org/licenses/by/4.0/>.

# Returns

base, fsin, fcos :: Array{Float64,1}
Filter base and its values.

# Example

```julia
base, fsin, fcos = LibDLF.Fourier.key_241_2009()
```

"""
function key_241_2009()
	if !haskey(cache,"key_241_2009") # read and add to cache
		bfile = joinpath(libpath,"lib/Fourier/fourier_key_241_2009_sincos.txt.bin")
		bdat = Array{Float64}(undef,241,3)
		read!(open(bfile,"r"),bdat)
		bdat .= ltoh(bdat) # file save with little endian so convert to host's endian
		cache["key_241_2009"]= tuple([bdat[:,c] for c in 1:size(bdat,2)]...)
	end
	return cache["key_241_2009"]
end

"""
	 key_601_2009()

 601 point Fourier filter, Sine and Cosine


 Designed and tested for controlled-source electromagnetic data.


 > Key, K., 2009;
 > 1D inversion of multicomponent, multifrequency marine CSEM data:
 > Methodology and synthetic studies for resolving thin resistive layers;
 > Geophysics, 74(2), F9-F20;
 > DOI: 10.1190/1.3058434


 Copyright 2009 Kerry Key

 This work is licensed under a CC BY 4.0 license.
 <http://creativecommons.org/licenses/by/4.0/>.

# Returns

base, fsin, fcos :: Array{Float64,1}
Filter base and its values.

# Example

```julia
base, fsin, fcos = LibDLF.Fourier.key_601_2009()
```

"""
function key_601_2009()
	if !haskey(cache,"key_601_2009") # read and add to cache
		bfile = joinpath(libpath,"lib/Fourier/fourier_key_601_2009_sincos.txt.bin")
		bdat = Array{Float64}(undef,601,3)
		read!(open(bfile,"r"),bdat)
		bdat .= ltoh(bdat) # file save with little endian so convert to host's endian
		cache["key_601_2009"]= tuple([bdat[:,c] for c in 1:size(bdat,2)]...)
	end
	return cache["key_601_2009"]
end

"""
	 key_101_2012()

 101 point Fourier filter, Sine and Cosine


 Designed and tested for controlled-source electromagnetic data.


 > Key, K., 2012;
 > Is the fast Hankel transform faster than quadrature?;
 > Geophysics, 77(3), F21-F30;
 > DOI: 10.1190/geo2011-0237.1


 Copyright 2012 Kerry Key

 This work is licensed under a CC BY 4.0 license.
 <http://creativecommons.org/licenses/by/4.0/>.

# Returns

base, fsin, fcos :: Array{Float64,1}
Filter base and its values.

# Example

```julia
base, fsin, fcos = LibDLF.Fourier.key_101_2012()
```

"""
function key_101_2012()
	if !haskey(cache,"key_101_2012") # read and add to cache
		bfile = joinpath(libpath,"lib/Fourier/fourier_key_101_2012_sincos.txt.bin")
		bdat = Array{Float64}(undef,101,3)
		read!(open(bfile,"r"),bdat)
		bdat .= ltoh(bdat) # file save with little endian so convert to host's endian
		cache["key_101_2012"]= tuple([bdat[:,c] for c in 1:size(bdat,2)]...)
	end
	return cache["key_101_2012"]
end

"""
	 key_201_2012()

 201 point Fourier filter, Sine and Cosine


 Designed and tested for controlled-source electromagnetic data.


 > Key, K., 2012;
 > Is the fast Hankel transform faster than quadrature?;
 > Geophysics, 77(3), F21-F30;
 > DOI: 10.1190/geo2011-0237.1


 Copyright 2012 Kerry Key

 This work is licensed under a CC BY 4.0 license.
 <http://creativecommons.org/licenses/by/4.0/>.

# Returns

base, fsin, fcos :: Array{Float64,1}
Filter base and its values.

# Example

```julia
base, fsin, fcos = LibDLF.Fourier.key_201_2012()
```

"""
function key_201_2012()
	if !haskey(cache,"key_201_2012") # read and add to cache
		bfile = joinpath(libpath,"lib/Fourier/fourier_key_201_2012_sincos.txt.bin")
		bdat = Array{Float64}(undef,201,3)
		read!(open(bfile,"r"),bdat)
		bdat .= ltoh(bdat) # file save with little endian so convert to host's endian
		cache["key_201_2012"]= tuple([bdat[:,c] for c in 1:size(bdat,2)]...)
	end
	return cache["key_201_2012"]
end

"""
	 grayver_50_2021()

 50 point Fourier filter, Sine


 Designed and tested for planetary electromagnetic induction.


 > Grayver, A. V., A. Kuvshinov, and D. Werthmüller, 2021;
 > Time-Domain Modeling of Three-Dimensional Earth's and Planetary
 > Electromagnetic Induction Effect in Ground and Satellite Observations;
 > Journal of Geophysical Research: Space Physics, 126(3), e2020JA028672;
 > DOI: 10.1029/2020JA028672


 Copyright 2021 Alexander V. Grayver

 This work is licensed under a CC BY 4.0 license.
 <http://creativecommons.org/licenses/by/4.0/>.

# Returns

base, fsin :: Array{Float64,1}
Filter base and its values.

# Example

```julia
base, fsin = LibDLF.Fourier.grayver_50_2021()
```

"""
function grayver_50_2021()
	if !haskey(cache,"grayver_50_2021") # read and add to cache
		bfile = joinpath(libpath,"lib/Fourier/fourier_grayver_50_2021_sin.txt.bin")
		bdat = Array{Float64}(undef,50,2)
		read!(open(bfile,"r"),bdat)
		bdat .= ltoh(bdat) # file save with little endian so convert to host's endian
		cache["grayver_50_2021"]= tuple([bdat[:,c] for c in 1:size(bdat,2)]...)
	end
	return cache["grayver_50_2021"]
end

end
