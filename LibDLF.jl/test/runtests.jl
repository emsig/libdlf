using LibDLF
using Test

# Relative tolerance for test result accuracy
test_rtol = 1e-4

# Test at x=1. where filters usually have small relative error
x_test = 1.

# Testing function pairs (from Anderson,1975, with a=1)
rhs_j0(x)   = exp(-x^2 / 4.) / 2.
rhs_j1(x)   = exp(-x^2 / 4.) * x / 4.
lhs_j0(lam) = exp(-lam^2) * lam
lhs_j1(lam) = exp(-lam^2) * lam^2
rhs_fcos(x) = exp(-x^2 / 4.) / 2 * sqrt(π)
rhs_fsin(x) = exp(-x^2 / 4.) / 4 * sqrt(π) * x
lhs_fcos(ω) = exp(-ω^2)
lhs_fsin(ω) = exp(-ω^2) * ω

function j0_test(base,j0)
	lam = base/x_test
	fht = (lhs_j0.(lam)' * j0) / x_test
	rhs =  rhs_j0(x_test)
	return abs(fht - rhs) ./ abs(rhs) 
end

function j1_test(base,j1)
	lam = base/x_test
	fht = (lhs_j1.(lam)' * j1) / x_test
	rhs =  rhs_j1(x_test)
	return abs(fht - rhs) ./ abs(rhs) 
end

function fcos_test(base,fcos)
	ω = base/x_test
	fct = (lhs_fcos.(ω)' * fcos) / x_test
	rhs =  rhs_fcos(x_test)
	return abs(fct - rhs) ./ abs(rhs) 
end

function fsin_test(base,fsin)
	ω = base/x_test
	fst = (lhs_fsin.(ω)' * fsin) / x_test
	rhs =  rhs_fsin(x_test)
	return abs(fst - rhs) ./ abs(rhs) 
end

# Unit tests

@testset "Hankel" begin

	@testset "anderson_801_1982" begin
		base, j0, j1 = LibDLF.Hankel.anderson_801_1982()
		@test j0_test(base,j0) < test_rtol
		@test j1_test(base,j1) < test_rtol
	end

	@testset "gupt_61_1997" begin
		base, j0 = LibDLF.Hankel.gupt_61_1997()
		@test j0_test(base,j0) < test_rtol
	end

	@testset "gupt_120_1997" begin
		base, j0 = LibDLF.Hankel.gupt_120_1997()
		@test j0_test(base,j0) < test_rtol
	end

	@testset "gupt_47_1997" begin
		base, j1 = LibDLF.Hankel.gupt_47_1997()
		@test j1_test(base,j1) < test_rtol
	end

	@testset "gupt_140_1997" begin
		base, j1 = LibDLF.Hankel.gupt_140_1997()
		@test j1_test(base,j1) < test_rtol
	end

	@testset "kong_61_2007b" begin
		base, j0, j1 = LibDLF.Hankel.kong_61_2007b()
		@test j0_test(base,j0) < test_rtol
		@test j1_test(base,j1) < test_rtol
	end

	@testset "kong_121_2007" begin
		base, j0, j1 = LibDLF.Hankel.kong_121_2007()
		@test j0_test(base,j0) < test_rtol
		@test j1_test(base,j1) < test_rtol
	end

	@testset "kong_241_2007" begin
		base, j0, j1 = LibDLF.Hankel.kong_241_2007()
		@test j0_test(base,j0) < test_rtol
		@test j1_test(base,j1) < test_rtol
	end

	@testset "key_101_2009" begin
		base, j0, j1 = LibDLF.Hankel.key_101_2009()
		@test j0_test(base,j0) < test_rtol
		@test j1_test(base,j1) < test_rtol
	end

	@testset "key_201_2009" begin
		base, j0, j1 = LibDLF.Hankel.key_201_2009()
		@test j0_test(base,j0) < test_rtol
		@test j1_test(base,j1) < test_rtol
	end

	@testset "key_401_2009" begin
		base, j0, j1 = LibDLF.Hankel.key_401_2009()
		@test j0_test(base,j0) < test_rtol
		@test j1_test(base,j1) < test_rtol
	end

	@testset "key_51_2012" begin
		base, j0, j1 = LibDLF.Hankel.key_51_2012()
		@test j0_test(base,j0) < test_rtol
		@test j1_test(base,j1) < test_rtol
	end

	@testset "key_101_2012" begin
		base, j0, j1 = LibDLF.Hankel.key_101_2012()
		@test j0_test(base,j0) < test_rtol
		@test j1_test(base,j1) < test_rtol
	end

	@testset "key_201_2012" begin
		base, j0, j1 = LibDLF.Hankel.key_201_2012()
		@test j0_test(base,j0) < test_rtol
		@test j1_test(base,j1) < test_rtol
	end

	@testset "wer_201_2018" begin
		base, j0, j1 = LibDLF.Hankel.wer_201_2018()
		@test j0_test(base,j0) < test_rtol
		@test j1_test(base,j1) < test_rtol
	end

	@testset "wer_2001_2018" begin
		base, j0, j1 = LibDLF.Hankel.wer_2001_2018()
		@test j0_test(base,j0) < test_rtol
		@test j1_test(base,j1) < test_rtol
	end
end

@testset "Fourier" begin

	@testset "key_81_2009" begin
		base, fsin, fcos = LibDLF.Fourier.key_81_2009()
		@test fsin_test(base,fsin) < test_rtol
		@test fcos_test(base,fcos) < test_rtol
	end

	@testset "key_241_2009" begin
		base, fsin, fcos = LibDLF.Fourier.key_241_2009()
		@test fsin_test(base,fsin) < test_rtol
		@test fcos_test(base,fcos) < test_rtol
	end

	@testset "key_601_2009" begin
		base, fsin, fcos = LibDLF.Fourier.key_601_2009()
		@test fsin_test(base,fsin) < test_rtol
		@test fcos_test(base,fcos) < test_rtol
	end

	@testset "key_101_2012" begin
		base, fsin, fcos = LibDLF.Fourier.key_101_2012()
		@test fsin_test(base,fsin) < test_rtol
		@test fcos_test(base,fcos) < test_rtol
	end

	@testset "key_201_2012" begin
		base, fsin, fcos = LibDLF.Fourier.key_201_2012()
		@test fsin_test(base,fsin) < test_rtol
		@test fcos_test(base,fcos) < test_rtol
	end

	@testset "grayver_50_2021" begin
		base, fsin = LibDLF.Fourier.grayver_50_2021()
		@test fsin_test(base,fsin) < test_rtol
	end
end
