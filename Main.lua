Stacks = require("Stacks")
stack = Stacks.New()

function PlayerTurn()
    ::SELECT_INDEX::
    
    os.execute("cls")
    print("Each line is a stack. The number on the left is the stack index and the number on the right is its value ([Index] : [Value]). \n")
    
    --Print the stacks
    print("Index : Size")
    for i=1, #stack do
        print(i .. "     : " .. stack[i])
    end
    print("")

    --Select the stack to split
    
    print("Type the index of the stack you want to modify and press ENTER to select that stack")

    local stackIndex = 0
    while true do
        local foundIndex = true

        --Get the index of the stack from the player
        stackIndex = io.read("*number")
        
        --Check whether the chosen index is an integer  
        if stackIndex == nil then
            print("\nThe written index must be an integer")
            ios.execute
            foundIndex = false
        elseif math.floor(stackIndex) ~= stackIndex then
            print("\nThe written index must be an integer")
            foundIndex = false
        --Check whether the index is not out of bounds
        elseif stack[stackIndex] == nil then
            print("\nThere are no stacks with the given index")
            foundIndex = false
        end

        if foundIndex then break end
    end

    --Split the stack itself
    print("\nType the value of one of the resulting stacks split from the your chosen stack. Press ENTER to split the stack.")
    print("If you want to change the chosen stack, type '0' and press ENTER")
    
    local splitSize = 0
    while true do
        local foundSize = true

        --Get the size of the first resulting stack once split
        splitSize = io.read("*number")

        --Check whether the player wants to reselect the stack they want to split
        if splitSize == 0 then
            print("")
            goto SELECT_INDEX
        end

        --Check whether the size is an integer--Check whether the chosen index is an integer  
        if splitSize == nil then
            print("\nThe size of the split stack must be an integer")
            foundSize = false
        elseif math.floor(splitSize) ~= splitSize then
            print("\nThe size of the split stack must be an integer")
            foundSize = false
        end

        --Split the stack
        if foundSize then
            if stack:DivideStack(stackIndex, splitSize) == false then
                print("\nThe size of the split stack must be from 1 to the size of the chosen stack\n")
                foundSize = false
            end
        end

        if foundSize then break end
    end
end

gameTree = {}
function EnemyTurn()
    function MiniMax(_stacks, _isMax, _alpha--[[ = -math.huge]], _beta--[[ = math.huge]])
        --If terminal state or leaf node is reached
        if _stacks:DividableStacksRemaining() == false then
            if _isMax then return 1 else return 0 end
        end
    
        --If current move is maximizer, find the maximum attainable value
        if _isMax then
            local bestVal = -math.huge
    
            --Select the stack to split
            for stackIndex=1, #_stacks do
                --Select the size of the stack to split
                for splitSize=1, _stacks[stackIndex] do
                    --Copy and divide the stored stack
                    local newStacks = _stacks:Copy()
                    newStacks:DivideStack(stackIndex, splitSize)
    
                    --Find the best value from the children below
                    local value = MiniMax(newStacks, true, _alpha, _beta)
                    bestVal = math.max(bestVal, value)
                
                    --Alpha Beta Pruning
                    _alpha = math.max(_alpha, bestVal)
                    if _beta <= _alpha then break end
                end
            end
    
            --Return the best maximizer
            return bestVal
    
        --If current move is minimizer, find the minimum attainable value
        else
            local bestVal = math.huge
    
            --Select the stack to split
            for stackIndex=1, #_stacks do
                --Select the size of the stack to split
                for splitSize=1, _stacks[stackIndex] do
                    --Copy and divide the stored stack
                    local newStacks = _stacks:Copy()
                    newStacks:DivideStack(stackIndex, splitSize)
                
                    --Find the best value from the children below
                    local value = MiniMax(newStacks, false, _alpha, _beta)
                    bestVal = math.min(bestVal, value)
                
                    --Alpha Beta Pruning
                    _alpha = math.min(_beta, bestVal)
                    if _beta <= _alpha then break end
                end
            end
    
            --Return the best minimizer
            return bestVal
        end
    end
   
    --Find the best move
    local bestVal = -math.huge
    local bestMove = {0, 0}

    --Select the stack to split
    for stackIndex=1, #stacks do
        --Select the size of the stack to split
        for splitSize=1, stacks[stackIndex] do
            --Create new stacks with the split done
            local newStacks = stacks:Copy()
            newStacks:DivideStack(stackIndex, splitSize)

            --Compute the evaluation for the move
            local moveVal = MiniMax(newStacks, true, -math.huge, math.huge)

            --If the moveVal of the current move is better than bestVal, update bestVal
            if (moveVal > bestVal) then
                bestMove[0] = stackIndex
                bestMove[1] = splitSize
                bestVal = moveVal
            end
        end
    end

    --Make the move
    stack:DivideStack(bestMove[0], bestMove[1])
end

isPlayerTurn = true
while stack:DividableStacksRemaining() do
    if isPlayerTurn then PlayerTurn()
    else EnemyTurn() end

    --Swap Player Turns
    if isPlayerTurn then isPlayerTurn = false
    else isPlayerTurn = true end
end