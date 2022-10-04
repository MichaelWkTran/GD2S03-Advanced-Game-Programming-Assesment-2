Stacks = require("Stacks")

--[[
The format of a tree in table form will be {Parent, {Children}}.
Thus the tree below will look like {1, {{2, {3}}, {4, {5}}}}

      1
    /   \
    2   4
    |   |
    3   5
]]

function MiniMax(_tree, _isMax, _alpha--[[ = -math.huge]], _beta--[[ = math.huge]])
    --MiniMax returns two values: The index of the child of _tree that will lead to the best winning path,
    --and the score value of that path
    
    --Get the children of the _tree
    local children = _tree[2]
    
    --If terminal state or leaf node is reached
    if children == nil or children == {} then return 1, _tree end

    --If current move is maximizer, find the maximum attainable value
    if _isMax then
        local bestVal = -math.huge
        for childIndex=1, #children do
            local value = MiniMax(children[childIndex], false, _alpha, _beta)
            local discardedTree, bestVal = math.max(bestVal, value)
            
            _alpha = math.max(_alpha, bestVal)
            if _beta <= _alpha then break end

            return childIndex, bestVal
        end
    --If current move is minimizer, find the minimum attainable value
    else
        local bestVal = math.huge
        for childIndex=1, #_tree do
            local value = MiniMax(children[childIndex], false, _alpha, _beta)
            local discardedTree, bestVal = math.min(bestVal, value)
            
            _beta = math.min(_beta, bestVal)
            if _beta <= _alpha then break end

            return childIndex, bestVal
        end
    end
end

function GenerateGameTree()

    function sss(_stacks)
        
        --Select the stack to split
        for stackIndex=1, #_stacks do
            --Select the size of the stack to split
            for splitSize=1, _stacks[stackIndex] do
                local newStacks = _stacks:Copy()
                newStacks:DivideStack(stackIndex, splitSize)

            end
        end
        
    end
     
end