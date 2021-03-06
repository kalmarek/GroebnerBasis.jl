function test_msolve_qq_l2()
    print("Msolve.msolve_qq_l2...")
    n = 4
    vars = Array{String, 1}(undef, n)
    # generate dummy array of n strings for generating
    # singular polynomial ring
    for i = 1:n
        vars[i] = "x$(i)"
    end
    R, X = Singular.PolynomialRing(
            Singular.QQ, vars, ordering = :degrevlex)
    global X
    # parses X[i] to xi
    [ eval(Meta.parse("$s = X[$i]")) for (i, s) in enumerate(vars) ]
    gens = [
        x1+2*x2+2*x3+2*x4-1,
        x1^2+2*x2^2+2*x3^2+2*x4^2-x1,
        2*x1*x2+2*x2*x3+2*x3*x4-x2,
        x2^2+2*x1*x3+2*x2*x4-x3
       ]

    id = Singular.Ideal(R, gens)

    sols = msolve(id, la_option=2)

    @test length(sols) == 6

    test_sols=[
               [4871720146171538053//8606136274519915162, 556010706967535921//3726774170982363712, 113376249241794779//443673942583616667, -243817258112272092//1298483891285305001],
                [1709182024934578276//3884438535844349667, 1410952112210577516//4593555428149678135, 99053225134378139//936582683649889144, -217118074030671581//1633411809993125516],
                 [1//1, 0//1, 0//1, 0//1],
                  [452743799637016807//606669070771355944, 456850886032707767//1956748565966302868, -501868158234629217//2718562067991793660, 651152824892914037//8348708935528466750],
                   [864155811707679569//4606538246761933084, 103160859936579578//1316603937596356701, 3764235640497721//51148181865446440, 18052514399240359//71001644994605646],
                    [1//3, 0//1, 0//1, 1//3]
                   ]

    for i in 1:length(sols)
        @test sols[i] == test_sols[i]
    end

    println("PASS")
end


function test_msolve()
    test_msolve_qq_l2()
    println("")
end
