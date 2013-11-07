class KDTree
  constructor: (@dim) ->
  
  add: (value) ->
    if @root then @root.add @dim,0,value else @root = new KDTreeNode value


class KDTreeNode
  constructor: (@value) ->
  
  add: (dim, depth, value) ->
    k = dim % depth
    if value < @value
      if !@left then @left = new KDTreeNode value else @left.add dim, depth+1, value
    else
      if !@right then @right = new KDTreeNode value else @right.add dim, depth+1, value


@KDTree = KDTree
