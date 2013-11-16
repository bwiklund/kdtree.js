KDTree = @KDTree

describe "kdtree", ->


  it "exists", ->
    expect( KDTree ).toBeDefined()


  it "can work in 1 dimension", ->
    k = new KDTree 1
    k.add [1]
    k.add [2]
    k.add [0]
    k.add [-1]

    expect( k.root.value ).toEqual [1]
    expect( k.root.right.value ).toEqual [2]
    expect( k.root.left.value ).toEqual [0]
    expect( k.root.left.left.value ).toEqual [-1]


  it "can work in 2 dimensions", ->
    k = new KDTree 2

    k.add [0,0]
    k.add [1,0]
    k.add [1,1]
    k.add [2,-1]

    expect( k.root.value ).toEqual [0,0]
    expect( k.root.right.value ).toEqual [1,0]
    expect( k.root.right.right.value ).toEqual [1,1]
    expect( k.root.right.left.value ).toEqual [2,-1]


  it "can find all vectors in a bounding box", ->
    k = new KDTree 2
    
    expect( k.findInBounds( [0,0],[1,1] ) ).toEqual []

    points = [[0,0],[1,0],[1,1],[2,-1]]
    k.add p for p in points

    correct = points[0...3]
    found = k.findInBounds [0,0],[1,1]

    intersection = _.intersection found, correct

    expect( found.length ).toBe correct.length
    expect( intersection.length ).toEqual 3
  

  it "can findInBounds in different dimensions (fuzz test)", ->

    startTime = new Date()
    
    # using a set random seed makes it more stable to benchmark
    chance = new Chance 19850619

    bench = (label,benchResults,fn) ->
      start = new Date
      rval = fn()
      stop = new Date
      benchResults.push label + " " + (stop-start)
      rval

    for dim in [1..5]

      benchResults = []
      
      k = new KDTree dim

      points = bench "point creation", benchResults, ->
        for i in [0...1000]
          chance.random() for j in [0...dim]

      bench "filling kdtree", benchResults, ->
        k.add p for p in points
      
      c1 = ( 0.45 for i in [0...dim] )
      c2 = ( 0.55 for i in [0...dim] )
      
      found = bench "kdfind", benchResults, ->
        k.findInBounds c1, c2

      # brute force to get correct result
      correct = bench "brute", benchResults, ->
        points.filter (p) ->
          for component in p
            if !(0.45 <= component <= 0.55) then return false
          true
      
      console.log "k = #{dim} | " + benchResults.join " | "
    
    stopTime = new Date()

    console.log( "ran fuzz test in #{(stopTime-startTime).toFixed()} ms" )
