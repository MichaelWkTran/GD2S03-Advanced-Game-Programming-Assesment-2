stacks = {}
setmetatable(stacks, stacks)

function DivideStack(_stackIndex, _splitSize)
    --_stackIndex is the selected stack from the table, stacks, to split.
    --_splitSize is the size of the resulting stacks once split.

    --Check whether the _stackIndex is outside the bounds of the table, stacks.
    if _stackIndex < 0 or _stackIndex >= stacks.size() then
        return false
    end

    --Check whether _splitSize is a valid size.
    if (_splitSize > stacks[_stackIndex]) then
        return false
    end

    --Check whether the resulting split is valid.
    local secondStackSize = stacks[_stackIndex] - _splitSize
    if (_splitSize == secondStackSize) then
        return false
    end

    --Divide the stack
    stacks[_stackIndex] = _splitSize
    stacks.insert(secondStackSize)

    return true
end

function PrintStack()

end