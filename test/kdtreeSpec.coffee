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
    result = k.findInBounds [0,0],[1,1]

    intersection = _.intersection result, correct

    expect( intersection.length ).toEqual 3

