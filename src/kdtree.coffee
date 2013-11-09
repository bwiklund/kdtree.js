class KDTree
  constructor: (@dim) ->
  
  add: (value) ->
    if @root then @root.add @dim,0,value else @root = new KDTreeNode value

  # c1 and c2 are the corner vectors of the bounding box
  findInBounds: (c1,c2) ->
    (@root?.findInBounds @dim, 0, [], c1, c2) or []



class KDTreeNode
  constructor: (@value) ->
  
  add: (dim, depth, value) ->
    k = depth % dim
    if value[k] < @value[k]
      if !@left then @left = new KDTreeNode value else @left.add dim, depth+1, value
    else
      if !@right then @right = new KDTreeNode value else @right.add dim, depth+1, value

  findInBounds: (dim,depth,accum,c1,c2) ->
    outOfBounds = false
    
    k = depth % dim

    # note that this doesn't necessarily mean the current value is in the bounding box,
    # only that it has children that could potentially be.
    if c1[k] <= @value[k]
      @left?.findInBounds  dim, depth+1, accum, c1, c2
    if c2[k] >= @value[k]
      @right?.findInBounds dim, depth+1, accum, c1, c2
    
    outOfBounds = false
    for n in [0...dim]
      if c1[n] > @value[n] || c2[n] < @value[n]
        outOfBounds = true
        break
    
    if !outOfBounds then accum.push @value

    accum



@KDTree = KDTree
