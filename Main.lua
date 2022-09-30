Stacks = require("Stacks")
stack = Stacks.New()

function PlayerTurn()
    print("Each line is a stack. The number on the left is the stack index and the number on the right is its value ([Index] : [Value]). \n")
    
    --Print the stacks
    print("Index : Size")
    for i=1, #stack do
        print(i .. "     : " .. stack[i])
    end

    --Select the stack to split
    ::SELECT_INDEX::
    print("Type the index of the stack you want to modify and press ENTER to select that stack")

    local stackIndex = 0
    while true do
        local foundIndex = true

        --Get the index of the stack from the player
        stackIndex = io.read("*number")
        
        --Check whether the chosen index is an integer  
        if stackIndex == nil or math.floor(stackIndex) ~= stackIndex then
            print("\nThe written index must be an integer\n")
            foundIndex = false
        end

        --Check whether the index is not out of bounds
        if stack[stackIndex] == nil then
            print("\nThere are no stacks with the given index\n")
            foundIndex = false
        end

        if foundIndex then break end
    end

    --Split the stack itself
    print("Type the value of one of the resulting stacks split from the your chosen stack. Press ENTER to split the stack. If you want to change the chosen stack, type 'Back' and press ENTER")
    print("If you want to change the chosen stack, type '0' and press ENTER")
    
    local splitSize = 0
    while true do
        local foundSize = true

        --Get the size of the first resulting stack once split
        io.read(splitSize)

        --Check whether the player wants to reselect the stack they want to split
        if splitSize == 0 then
            goto SELECT_INDEX
        end

        --Check whether the size is an integer
        if splitSize == nil or math.floor(splitSize) ~= splitSize then
            print("\nThe size of the split stack must be an integer\n")
            foundSize = false
        end

        --Split the stack
        if stack:DivideStack(stackIndex, splitSize) == false then
            print("\nThe size of the split stack must be from 1 to the size of the chosen stack\n")
            foundSize = false
        end

        if foundSize then break end
    end
end

function EnemyTurn()
    
end