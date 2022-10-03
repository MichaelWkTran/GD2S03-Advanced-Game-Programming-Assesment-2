Stacks = require("Stacks")

function GenerateStacksMinimax()
    --Create a tree. The format of a tree in table form will be {Node, Leaves}.
    --The nodes are the list of stacks and the leaves are the resulting stacks from possible divisions.
    local tree = {7}

    function SplitTree(_tree)
        --Split the node into leaves
        local node = _tree[0]
        local leaves = {}
        
        --aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
        function aa(_stackIndex)
            local stackSize = node[_stackIndex]

            --Check whether selected stack can be split
            if stackSize > 2 return


            resultingStacks = {}

            resultingStacks

            return resultingStacks
        end

        --loop though all possible moves that can be taken
        for stackIndex=1; node do
            --Get the size of the chosen stack to split
            local stackSize = node[stackIndex]

            --Check whether selected stack can be split
            if stackSize > 2 then leaves = aa(stackSize) end
        end

        --Update the leaves of the tree
        _tree[0] = leaves
        
        --Split the stacks in the leaves
        _tree = SplitTree(_tree[1])

        return _tree;
    end

    --function DivideStack(_node, _index, _splitSize)
    --            
    --    return {--[[aaaa]] newNode[_index], {--[[aaaa]]_splitSize,--[[aaaa]] newNode[_index] - _splitSize}}
    --end

    function tree.FindLeaves(_node)
    {
        for node=0;
    }

    return tree
end

return GenerateStacksMinimax();