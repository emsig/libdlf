module Hankel

libpath = @__DIR__

cache = Dict() # local cache for any filters already loaded

"""
	 anderson_801_1982()

 801 point Hankel filter, J0 and J1


 > Anderson, W. L., 1982;
 > Fast Hankel transforms using related and lagged convolutions;
 > ACM Trans. on Math. Softw. (TOMS), 8, 344-368;
 > DOI: 10.1145/356012.356014


 The original filter values are published in the appendix to above article:
 Algorithm 588, DOI: 10.1145/356012.356015

 The values provided here are taken from code that accompanies:
 Key 2012, Geophysics, DOI: 10.1190/geo2011-0237.1


 Copyright 1982 Walter L. Anderson

 This work is licensed under a CC BY 4.0 license.
 <http://creativecommons.org/licenses/by/4.0/>.

# Returns

base, j0, j1 :: Array{Float64,1}
Filter base and its values.

# Example

```julia
base, j0, j1 = LibDLF.Hankel.anderson_801_1982()
```

"""
function anderson_801_1982()
	if !haskey(cache,"anderson_801_1982") # read and add to cache
		bfile = joinpath(libpath,"lib/Hankel/hankel_anderson_801_1982_j0j1.txt.bin")
		bdat = Array{Float64}(undef,801,3)
		read!(open(bfile,"r"),bdat)
		bdat .= ltoh(bdat) # file save with little endian so convert to host's endian
		cache["anderson_801_1982"]= tuple([bdat[:,c] for c in 1:size(bdat,2)]...)
	end
	return cache["anderson_801_1982"]
end

"""
	 gupt_61_1997()

 61 point Hankel filter, J0



 > Guptasarma, D. and B. Singh, 1997;
 > New digital linear filters for Hankel J0 and J1 transforms;
 > Geophysical Prospecting, 45(5), 745-762;
 > DOI: 10.1046/j.1365-2478.1997.500292.x


 Copyright 1997 D. Guptasarma and B. Singh

 This work is licensed under a CC BY 4.0 license.
 <http://creativecommons.org/licenses/by/4.0/>.

# Returns

base, j0 :: Array{Float64,1}
Filter base and its values.

# Example

```julia
base, j0 = LibDLF.Hankel.gupt_61_1997()
```

"""
function gupt_61_1997()
	if !haskey(cache,"gupt_61_1997") # read and add to cache
		bfile = joinpath(libpath,"lib/Hankel/hankel_gupt_61_1997_j0.txt.bin")
		bdat = Array{Float64}(undef,61,2)
		read!(open(bfile,"r"),bdat)
		bdat .= ltoh(bdat) # file save with little endian so convert to host's endian
		cache["gupt_61_1997"]= tuple([bdat[:,c] for c in 1:size(bdat,2)]...)
	end
	return cache["gupt_61_1997"]
end

"""
	 gupt_120_1997()

 120 point Hankel filter, J0



 > Guptasarma, D. and B. Singh, 1997;
 > New digital linear filters for Hankel J0 and J1 transforms;
 > Geophysical Prospecting, 45(5), 745-762;
 > DOI: 10.1046/j.1365-2478.1997.500292.x


 Copyright 1997 D. Guptasarma and B. Singh

 This work is licensed under a CC BY 4.0 license.
 <http://creativecommons.org/licenses/by/4.0/>.

# Returns

base, j0 :: Array{Float64,1}
Filter base and its values.

# Example

```julia
base, j0 = LibDLF.Hankel.gupt_120_1997()
```

"""
function gupt_120_1997()
	if !haskey(cache,"gupt_120_1997") # read and add to cache
		bfile = joinpath(libpath,"lib/Hankel/hankel_gupt_120_1997_j0.txt.bin")
		bdat = Array{Float64}(undef,120,2)
		read!(open(bfile,"r"),bdat)
		bdat .= ltoh(bdat) # file save with little endian so convert to host's endian
		cache["gupt_120_1997"]= tuple([bdat[:,c] for c in 1:size(bdat,2)]...)
	end
	return cache["gupt_120_1997"]
end

"""
	 gupt_47_1997()

 47 point Hankel filter, J1



 > Guptasarma, D. and B. Singh, 1997;
 > New digital linear filters for Hankel J0 and J1 transforms;
 > Geophysical Prospecting, 45(5), 745-762;
 > DOI: 10.1046/j.1365-2478.1997.500292.x


 Copyright 1997 D. Guptasarma and B. Singh

 This work is licensed under a CC BY 4.0 license.
 <http://creativecommons.org/licenses/by/4.0/>.

# Returns

base, j1 :: Array{Float64,1}
Filter base and its values.

# Example

```julia
base, j1 = LibDLF.Hankel.gupt_47_1997()
```

"""
function gupt_47_1997()
	if !haskey(cache,"gupt_47_1997") # read and add to cache
		bfile = joinpath(libpath,"lib/Hankel/hankel_gupt_47_1997_j1.txt.bin")
		bdat = Array{Float64}(undef,47,2)
		read!(open(bfile,"r"),bdat)
		bdat .= ltoh(bdat) # file save with little endian so convert to host's endian
		cache["gupt_47_1997"]= tuple([bdat[:,c] for c in 1:size(bdat,2)]...)
	end
	return cache["gupt_47_1997"]
end

"""
	 gupt_140_1997()

 140 point Hankel filter, J1



 > Guptasarma, D. and B. Singh, 1997;
 > New digital linear filters for Hankel J0 and J1 transforms;
 > Geophysical Prospecting, 45(5), 745-762;
 > DOI: 10.1046/j.1365-2478.1997.500292.x


 Copyright 1997 D. Guptasarma and B. Singh

 This work is licensed under a CC BY 4.0 license.
 <http://creativecommons.org/licenses/by/4.0/>.

# Returns

base, j1 :: Array{Float64,1}
Filter base and its values.

# Example

```julia
base, j1 = LibDLF.Hankel.gupt_140_1997()
```

"""
function gupt_140_1997()
	if !haskey(cache,"gupt_140_1997") # read and add to cache
		bfile = joinpath(libpath,"lib/Hankel/hankel_gupt_140_1997_j1.txt.bin")
		bdat = Array{Float64}(undef,140,2)
		read!(open(bfile,"r"),bdat)
		bdat .= ltoh(bdat) # file save with little endian so convert to host's endian
		cache["gupt_140_1997"]= tuple([bdat[:,c] for c in 1:size(bdat,2)]...)
	end
	return cache["gupt_140_1997"]
end

"""
	 kong_61_2007b()

 61 point Hankel filter, J0 and J1


 Designed and tested for dipole antenna radiation in a conductive medium.


 > Kong, F. N, 2007;
 > Hankel transform filters for dipole antenna radiation in a conductive
 > medium;
 > Geophysical Prospecting, 55(1), 83-89;
 > DOI: 10.1111/j.1365-2478.2006.00585.x


 These filter values are available from

   http://www.em-earth-consulting.no

 in the three files YBASE61NEW.dat, J0K61NEW.dat, and J1K61NEW.dat.
 Please consult the original source for more details.

 The appendix "b" after the year indicates that it corresponds to the NEW
 set of filter values.


 Copyright 2007 Fannian Kong

 This work is licensed under a CC BY 4.0 license.
 <http://creativecommons.org/licenses/by/4.0/>.

# Returns

base, j0, j1 :: Array{Float64,1}
Filter base and its values.

# Example

```julia
base, j0, j1 = LibDLF.Hankel.kong_61_2007b()
```

"""
function kong_61_2007b()
	if !haskey(cache,"kong_61_2007b") # read and add to cache
		bfile = joinpath(libpath,"lib/Hankel/hankel_kong_61_2007b_j0j1.txt.bin")
		bdat = Array{Float64}(undef,61,3)
		read!(open(bfile,"r"),bdat)
		bdat .= ltoh(bdat) # file save with little endian so convert to host's endian
		cache["kong_61_2007b"]= tuple([bdat[:,c] for c in 1:size(bdat,2)]...)
	end
	return cache["kong_61_2007b"]
end

"""
	 kong_121_2007()

 121 point Hankel filter, J0 and J1


 Designed and tested for dipole antenna radiation in a conductive medium.


 > Kong, F. N, 2007;
 > Hankel transform filters for dipole antenna radiation in a conductive
 > medium;
 > Geophysical Prospecting, 55(1), 83-89;
 > DOI: 10.1111/j.1365-2478.2006.00585.x


 These filter values are available from

   http://www.em-earth-consulting.no

 in the three files YBASE121.dat, J0K121.dat, and J1K121.dat.
 Please consult the original source for more details.


 Copyright 2007 Fannian Kong

 This work is licensed under a CC BY 4.0 license.
 <http://creativecommons.org/licenses/by/4.0/>.

# Returns

base, j0, j1 :: Array{Float64,1}
Filter base and its values.

# Example

```julia
base, j0, j1 = LibDLF.Hankel.kong_121_2007()
```

"""
function kong_121_2007()
	if !haskey(cache,"kong_121_2007") # read and add to cache
		bfile = joinpath(libpath,"lib/Hankel/hankel_kong_121_2007_j0j1.txt.bin")
		bdat = Array{Float64}(undef,121,3)
		read!(open(bfile,"r"),bdat)
		bdat .= ltoh(bdat) # file save with little endian so convert to host's endian
		cache["kong_121_2007"]= tuple([bdat[:,c] for c in 1:size(bdat,2)]...)
	end
	return cache["kong_121_2007"]
end

"""
	 kong_241_2007()

 241 point Hankel filter, J0 and J1


 Designed and tested for dipole antenna radiation in a conductive medium.


 > Kong, F. N, 2007;
 > Hankel transform filters for dipole antenna radiation in a conductive
 > medium;
 > Geophysical Prospecting, 55(1), 83-89;
 > DOI: 10.1111/j.1365-2478.2006.00585.x


 These filter values are available from

   http://www.em-earth-consulting.no

 in the three files YBASE241.dat, J0K241.dat, and J1K241.dat.
 Please consult the original source for more details.


 Copyright 2007 Fannian Kong

 This work is licensed under a CC BY 4.0 license.
 <http://creativecommons.org/licenses/by/4.0/>.

# Returns

base, j0, j1 :: Array{Float64,1}
Filter base and its values.

# Example

```julia
base, j0, j1 = LibDLF.Hankel.kong_241_2007()
```

"""
function kong_241_2007()
	if !haskey(cache,"kong_241_2007") # read and add to cache
		bfile = joinpath(libpath,"lib/Hankel/hankel_kong_241_2007_j0j1.txt.bin")
		bdat = Array{Float64}(undef,241,3)
		read!(open(bfile,"r"),bdat)
		bdat .= ltoh(bdat) # file save with little endian so convert to host's endian
		cache["kong_241_2007"]= tuple([bdat[:,c] for c in 1:size(bdat,2)]...)
	end
	return cache["kong_241_2007"]
end

"""
	 key_101_2009()

 101 point Hankel filter, J0 and J1


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

base, j0, j1 :: Array{Float64,1}
Filter base and its values.

# Example

```julia
base, j0, j1 = LibDLF.Hankel.key_101_2009()
```

"""
function key_101_2009()
	if !haskey(cache,"key_101_2009") # read and add to cache
		bfile = joinpath(libpath,"lib/Hankel/hankel_key_101_2009_j0j1.txt.bin")
		bdat = Array{Float64}(undef,101,3)
		read!(open(bfile,"r"),bdat)
		bdat .= ltoh(bdat) # file save with little endian so convert to host's endian
		cache["key_101_2009"]= tuple([bdat[:,c] for c in 1:size(bdat,2)]...)
	end
	return cache["key_101_2009"]
end

"""
	 key_201_2009()

 201 point Hankel filter, J0 and J1


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

base, j0, j1 :: Array{Float64,1}
Filter base and its values.

# Example

```julia
base, j0, j1 = LibDLF.Hankel.key_201_2009()
```

"""
function key_201_2009()
	if !haskey(cache,"key_201_2009") # read and add to cache
		bfile = joinpath(libpath,"lib/Hankel/hankel_key_201_2009_j0j1.txt.bin")
		bdat = Array{Float64}(undef,201,3)
		read!(open(bfile,"r"),bdat)
		bdat .= ltoh(bdat) # file save with little endian so convert to host's endian
		cache["key_201_2009"]= tuple([bdat[:,c] for c in 1:size(bdat,2)]...)
	end
	return cache["key_201_2009"]
end

"""
	 key_401_2009()

 401 point Hankel filter, J0 and J1


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

base, j0, j1 :: Array{Float64,1}
Filter base and its values.

# Example

```julia
base, j0, j1 = LibDLF.Hankel.key_401_2009()
```

"""
function key_401_2009()
	if !haskey(cache,"key_401_2009") # read and add to cache
		bfile = joinpath(libpath,"lib/Hankel/hankel_key_401_2009_j0j1.txt.bin")
		bdat = Array{Float64}(undef,401,3)
		read!(open(bfile,"r"),bdat)
		bdat .= ltoh(bdat) # file save with little endian so convert to host's endian
		cache["key_401_2009"]= tuple([bdat[:,c] for c in 1:size(bdat,2)]...)
	end
	return cache["key_401_2009"]
end

"""
	 key_51_2012()

 51 point Hankel filter, J0 and J1


 Designed and tested for controlled-source electromagnetic data.


 > Key, K., 2012;
 > Is the fast Hankel transform faster than quadrature?;
 > Geophysics, 77(3), F21-F30;
 > DOI: 10.1190/geo2011-0237.1


 Copyright 2012 Kerry Key

 This work is licensed under a CC BY 4.0 license.
 <http://creativecommons.org/licenses/by/4.0/>.

# Returns

base, j0, j1 :: Array{Float64,1}
Filter base and its values.

# Example

```julia
base, j0, j1 = LibDLF.Hankel.key_51_2012()
```

"""
function key_51_2012()
	if !haskey(cache,"key_51_2012") # read and add to cache
		bfile = joinpath(libpath,"lib/Hankel/hankel_key_51_2012_j0j1.txt.bin")
		bdat = Array{Float64}(undef,51,3)
		read!(open(bfile,"r"),bdat)
		bdat .= ltoh(bdat) # file save with little endian so convert to host's endian
		cache["key_51_2012"]= tuple([bdat[:,c] for c in 1:size(bdat,2)]...)
	end
	return cache["key_51_2012"]
end

"""
	 key_101_2012()

 101 point Hankel filter, J0 and J1


 Designed and tested for controlled-source electromagnetic data.


 > Key, K., 2012;
 > Is the fast Hankel transform faster than quadrature?;
 > Geophysics, 77(3), F21-F30;
 > DOI: 10.1190/geo2011-0237.1


 Copyright 2012 Kerry Key

 This work is licensed under a CC BY 4.0 license.
 <http://creativecommons.org/licenses/by/4.0/>.

# Returns

base, j0, j1 :: Array{Float64,1}
Filter base and its values.

# Example

```julia
base, j0, j1 = LibDLF.Hankel.key_101_2012()
```

"""
function key_101_2012()
	if !haskey(cache,"key_101_2012") # read and add to cache
		bfile = joinpath(libpath,"lib/Hankel/hankel_key_101_2012_j0j1.txt.bin")
		bdat = Array{Float64}(undef,101,3)
		read!(open(bfile,"r"),bdat)
		bdat .= ltoh(bdat) # file save with little endian so convert to host's endian
		cache["key_101_2012"]= tuple([bdat[:,c] for c in 1:size(bdat,2)]...)
	end
	return cache["key_101_2012"]
end

"""
	 key_201_2012()

 201 point Hankel filter, J0 and J1


 Designed and tested for controlled-source electromagnetic data.


 > Key, K., 2012;
 > Is the fast Hankel transform faster than quadrature?;
 > Geophysics, 77(3), F21-F30;
 > DOI: 10.1190/geo2011-0237.1


 Copyright 2012 Kerry Key

 This work is licensed under a CC BY 4.0 license.
 <http://creativecommons.org/licenses/by/4.0/>.

# Returns

base, j0, j1 :: Array{Float64,1}
Filter base and its values.

# Example

```julia
base, j0, j1 = LibDLF.Hankel.key_201_2012()
```

"""
function key_201_2012()
	if !haskey(cache,"key_201_2012") # read and add to cache
		bfile = joinpath(libpath,"lib/Hankel/hankel_key_201_2012_j0j1.txt.bin")
		bdat = Array{Float64}(undef,201,3)
		read!(open(bfile,"r"),bdat)
		bdat .= ltoh(bdat) # file save with little endian so convert to host's endian
		cache["key_201_2012"]= tuple([bdat[:,c] for c in 1:size(bdat,2)]...)
	end
	return cache["key_201_2012"]
end

"""
	 wer_201_2018()

 201 point Hankel filter, J0 and J1


 Designed and tested for controlled-source electromagnetic data.

 See the notebook `Filter-wer201.ipynb` in the repo
 https://github.com/emsig/article-fdesign


 > Werthmüller, D., K. Key, and E. Slob, 2019;
 > A tool for designing digital filters for the Hankel and Fourier
 > transforms in potential, diffusive, and wavefield modeling;
 > Geophysics, 84(2), F47-F56;
 > DOI: 10.1190/geo2018-0069.1


 Copyright 2018 Dieter Werthmüller

 This work is licensed under a CC BY 4.0 license.
 <http://creativecommons.org/licenses/by/4.0/>.

# Returns

base, j0, j1 :: Array{Float64,1}
Filter base and its values.

# Example

```julia
base, j0, j1 = LibDLF.Hankel.wer_201_2018()
```

"""
function wer_201_2018()
	if !haskey(cache,"wer_201_2018") # read and add to cache
		bfile = joinpath(libpath,"lib/Hankel/hankel_wer_201_2018_j0j1.txt.bin")
		bdat = Array{Float64}(undef,201,3)
		read!(open(bfile,"r"),bdat)
		bdat .= ltoh(bdat) # file save with little endian so convert to host's endian
		cache["wer_201_2018"]= tuple([bdat[:,c] for c in 1:size(bdat,2)]...)
	end
	return cache["wer_201_2018"]
end

"""
	 wer_2001_2018()

 2001 point Hankel filter, J0 and J1


 Designed and tested for ground-penetrating radar (GPR).

 See the notebook `Filter-wer2001.ipynb` in the repo
 https://github.com/emsig/article-fdesign


 > Werthmüller, D., K. Key, and E. Slob, 2019;
 > A tool for designing digital filters for the Hankel and Fourier
 > transforms in potential, diffusive, and wavefield modeling;
 > Geophysics, 84(2), F47-F56;
 > DOI: 10.1190/geo2018-0069.1


 Copyright 2018 Dieter Werthmüller

 This work is licensed under a CC BY 4.0 license.
 <http://creativecommons.org/licenses/by/4.0/>.

# Returns

base, j0, j1 :: Array{Float64,1}
Filter base and its values.

# Example

```julia
base, j0, j1 = LibDLF.Hankel.wer_2001_2018()
```

"""
function wer_2001_2018()
	if !haskey(cache,"wer_2001_2018") # read and add to cache
		bfile = joinpath(libpath,"lib/Hankel/hankel_wer_2001_2018_j0j1.txt.bin")
		bdat = Array{Float64}(undef,2001,3)
		read!(open(bfile,"r"),bdat)
		bdat .= ltoh(bdat) # file save with little endian so convert to host's endian
		cache["wer_2001_2018"]= tuple([bdat[:,c] for c in 1:size(bdat,2)]...)
	end
	return cache["wer_2001_2018"]
end

end
