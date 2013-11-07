class KDTree
  constructor: (@dim) ->
  
  add: (value) ->
    if @root then @root.add @dim,value else @root = new KDTreeNode value


class KDTreeNode
  constructor: (@value) ->
  
  add: (dim, value) ->
    if value < @value
      if !@left then @left = new KDTreeNode value else @left.add dim, value
    else
      if !@right then @right = new KDTreeNode value else @right.add dim, value


@KDTree = KDTree
