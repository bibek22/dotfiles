#!/usr/bin/bash
xmodmap -e "clear lock"
xmodmap -e "keycode 66 = Control_L NoSymbol Control_L"
xmodmap -e "add control = Control_L Control_R"
xcape -e "Control_L=Escape"
