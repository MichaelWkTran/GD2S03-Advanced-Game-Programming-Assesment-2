Grundy's Game - Created by Michael Wai Kit Tran

To play Grundy's Game, both players start with one stack of seven pennies. First player divides the original stack into two stacks. The resulting divided stacks must be unequal and cannot have the same number of pennies. Each player alternatively thereafter does the same to some single stack when it is their turn to player. The game proceeds until each stack have either just one or two penny - at which point of continuation becomes impossible. The player who first cannot player is the loser. 

When opening the game program. The player sees a list of two numbers. The number on the left is the stack index and the number on the right is the number of pennies the stack has. Type the index of the stack you want to modify, and press ENTER to select that stack. 
When a stack is selected, type the size of the one of the resulting stacks split from your chosen stack. Press Enter to split the stack. If you want to change the stack to split, type 0 and press ENTER. 

After splitting the stack, a computer player will then split one of the stacks. You will then be shown the list of stacks after the split the computer player has made. Choose a stack to split as done previously until either you or the computer wins. 

This program uses object-oriented programming as shown in the Stacks.lua file, it uses the minimax algorithm with alpha beta pruning found in line 109 of the Main.lua file.