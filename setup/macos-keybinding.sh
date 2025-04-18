#!/bin/sh

set -e

mkdir -p "$HOME/Library/KeyBindings"

cat << EOF > "$HOME/Library/KeyBindings/DefaultKeyBinding.dict"
/*
    Key Modifiers 
    ^ : Ctrl 
    $ : Shift 
    ~ : Option (Alt) 
    @ : Command (Apple) 
    # : Numeric Keypad 
     
    Non-Printable Key Codes 
     
    Up Arrow:     \UF700        Backspace:    \U0008        F1:           \UF704 
    Down Arrow:   \UF701        Tab:          \U0009        F2:           \UF705 
    Left Arrow:   \UF702        Escape:       \U001B        F3:           \UF706 
    Right Arrow:  \UF703        Enter:        \U000A        ... 
    Insert:       \UF727        Page Up:      \UF72C 
    Delete:       \UF728        Page Down:    \UF72D 
    Home:         \UF729        Print Screen: \UF72E 
    End:          \UF72B        Scroll Lock:  \UF72F 
    Break:        \UF732        Pause:        \UF730 
    SysReq:       \UF731        Menu:         \UF735 
    Help:         \UF746 
*/

{
  "\UF729"  = "moveToBeginningOfLine:"; /* Home */
  "\UF72B"  = "moveToEndOfLine:"; /* End */
  "$\UF729" = "moveToBeginningOfLineAndModifySelection:"; /* Shift + Home */
  "$\UF72B" = "moveToEndOfLineAndModifySelection:"; /* Shift + End */
  "^\UF729" = moveToBeginningOfDocument:; // Ctrl + Home
  "^\UF72B" = moveToEndOfDocument:;   // Ctrl + End
  "^$\UF729" = moveToBeginningOfDocumentAndModifySelection:; // Ctrl + Shift + Home
  "^$\UF72B" = moveToEndOfDocumentAndModifySelection:; // Ctrl + Shift + End
}
EOF

