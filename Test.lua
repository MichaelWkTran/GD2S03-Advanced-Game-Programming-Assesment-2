Stacks = require("Stacks")
stacks = Stacks.New()

function Stacks:Print()
    print("Index : Size")
    for i=1, #self do
        print(i .. "     : " .. self[i])
    end
end

copy = Stacks:New()
copy:DivideStack(1, 3)
copy:Print()
stacks:Print()