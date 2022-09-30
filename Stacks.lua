Stacks = {7}
Stacks.__index = Stacks;

function Stacks.New()
    return setmetatable(Stacks, {})
end

function Stacks:DivideStack(_stackIndex, _splitSize)
    --_stackIndex is the selected stack from the table, stacks, to split.
    --_splitSize is the size of the first resulting stack once split.

    --Check whether the _stackIndex is outside the bounds of the table, stacks.
    if self[_stackIndex] == nil then
        return false
    end

    --Check whether _splitSize is a valid size.
    if (_splitSize > 0 and _splitSize > self[_stackIndex]) then
        return false
    end

    --Get the size of the second resulting stack once split
    local secondStackSize = self[_stackIndex] - _splitSize

    --Check whether the resulting split is valid.
    if (secondStackSize > 0 and _splitSize == secondStackSize) then
        return false
    end

    --Divide the stack
    self[_stackIndex] = _splitSize
    table.insert(self, secondStackSize)

    return true
end

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