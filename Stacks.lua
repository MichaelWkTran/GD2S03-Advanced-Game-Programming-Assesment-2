Stacks = {7}
Stacks.__index = Stacks

--Creates a new object from the Stacks class
function Stacks.New()
    return Stacks:Copy()
end

--Creates a new object with data copied from another Stacks object
function Stacks:Copy()
    --local copy = Stacks.New()
    local copy = {}

    for i=1, #self do
        copy[i] = self[i]
    end

    --return copy
    return setmetatable(copy, Stacks)
end

--Split a stack a Stacks object. 
function Stacks:DivideStack(_stackIndex, _splitSize)
    --_stackIndex is the selected stack from the table, stacks, to split.
    --_splitSize is the size of the first resulting stack once split.

    --Check whether the _stackIndex is outside the bounds of the table, stacks.
    if self[_stackIndex] == nil then return false end

    --Check whether the particular stack can be split
    if self[_stackIndex] <= 2 then return false end

    --Check whether_splitSize is a valid size.
    if _splitSize < 0 and _splitSize >= self[_stackIndex] then return false end

    --Get the size of the second resulting stack once split.
    local secondStackSize = self[_stackIndex] - _splitSize

    --Divide the stack
    self[_stackIndex] = _splitSize
    self[#self + 1] = secondStackSize
    
    return true
end

--Check whether there are remaining stacks in the Stacks object that can be split
function Stacks:DividableStacksRemaining()
    local dividableStacksRemaining = 0
    
    for i=1, #self do
        if self[i] > 2 then
            dividableStacksRemaining = dividableStacksRemaining + 1
        end
    end

    return dividableStacksRemaining
end

return Stacks