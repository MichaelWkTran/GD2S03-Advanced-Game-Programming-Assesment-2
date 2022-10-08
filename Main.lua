--[[
Issues:
    --All objects created from Stacks share the same data instead of containing individual data
    --How do I flush the input buffer
]]

Stacks = require("Stacks")
stacks = Stacks.New()

turnNumber = 0
--Prints a message showing how many turns are played in the game
function PrintTurn()
    print("Turn " .. turnNumber .. "----------------------------------")
end

--Prints the stacks in a Stacks object
function Stacks:Print()
    print("Index : Size")
    for i=1, #self do
        print(i .. "     : " .. self[i])
    end
end

--Split a Stacks object based on the player's inputs
function PlayerTurn()
    ::SELECT_INDEX::
    
    --Print turn number
    turnNumber = turnNumber + 1
    PrintTurn()
    
    --Print input intstruction
    print("Each line is a stack. The number on the left is the stack index and the number on the right is its value ([Index] : [Value]). \n")
    
    --Print the stacks
    stacks:Print()
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
            local flush = io.read()
            foundIndex = false
        elseif math.floor(stackIndex) ~= stackIndex then
            print("\nThe written index must be an integer")
            foundIndex = false
        --Check whether the index is not out of bounds
        elseif stacks[stackIndex] == nil then
            print("\nThere are no stacks with the given index")
            foundIndex = false
        --Check whether the chosen stack can be split
        elseif stacks[stackIndex] <= 2 then
            print("\nThe size of the chosen stack must be larger than two")
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

        --Check whether the chosen size is an integer  
        if splitSize == nil then
            print("\nThe size of the split stack must be an integer")
            local flush = io.read()
            foundSize = false
        elseif math.floor(splitSize) ~= splitSize then
            print("\nThe size of the split stack must be an integer")
            foundSize = false
        end

        --Split the stack
        if foundSize then
            if not stacks:DivideStack(stackIndex, splitSize) then
                print("\nThe size of the split stack must be larger than 1, but smaller than the size of the chosen stack")
                foundSize = false
            end
        end

        if foundSize then break end
    end

    print("")
end

--Split a Stacks object based on the computer player's inputs
function EnemyTurn()
    --Calcuate a score for a potential move done by the computer
    function Stacks:MiniMax(_isMax, _alpha--[[ = -math.huge]], _beta--[[ = math.huge]])
        --If terminal state or leaf node is reached
        if self:DividableStacksRemaining() <= 0 then
            if _isMax then return 1 else return 0 end
        end

        --Set the initial best value to math.huge if _isMax is true and if false set it to -math.huge
        local bestVal = math.huge;
        if _isMax then bestVal = -1 * bestVal; end

        --Select the stack to split
        for stackIndex=1, #self do
            --Select the size of the stack to split
            for splitSize=1, self[stackIndex]/2 do
                --Copy and divide the stored stack.
                --Skip this iteration of the chosen stack can not be divided
                local newStacks = self:Copy()
                if newStacks:DivideStack(stackIndex, splitSize) then
                    --Find the best value from the children below
                    local value = newStacks:MiniMax(not _isMax, _alpha, _beta)

                    --If _isMax is true, set bestVal to the maximum score,
                    --otherwise set it to the minimum score found
                    if _isMax then bestVal = math.max(bestVal, value)
                    else bestVal = math.min(bestVal, value) end

                    --Alpha Beta Pruning
                    if _isMax then _alpha = math.max(_alpha, bestVal)
                    else _beta = math.min(_beta, bestVal) end

                    if _beta <= _alpha then break end
                end
            end
        end

        return bestVal
    end
   
    --Find the best move
    local bestVal = -math.huge
    local bestMove = {1, 0}

    --Select the stack to split
    for stackIndex=1, #stacks do
        --Select the size of the stack to split
        for splitSize=1, stacks[stackIndex]/2 do
            --Create new stacks with the split done
            --Skip this iteration of the chosen stack can not be divided
            local newStacks = stacks:Copy()
            if newStacks:DivideStack(stackIndex, splitSize) then
                --Compute the evaluation for the move
                local moveVal = newStacks:MiniMax(true, -math.huge, math.huge)

                --If the moveVal of the current move is better than bestVal, update bestVal
                if (moveVal > bestVal) then
                    bestMove[1] = stackIndex
                    bestMove[2] = splitSize
                    bestVal = moveVal
                end
            end
        end
    end

    --Make the move
    stacks:DivideStack(bestMove[1], bestMove[2])
end

isPlayerTurn = true
while stacks:DividableStacksRemaining() > 0 do
    --Perform the Player or Enemy turn
    if isPlayerTurn then PlayerTurn()
    else EnemyTurn() end

    --Swap Player Turns
    if isPlayerTurn then isPlayerTurn = false
    else isPlayerTurn = true end
end

--Print turn number
PrintTurn()

--Show whether the player won or lost
if isPlayerTurn then print("You Lose\n")
else print("You Win\n") end

stacks:Print()