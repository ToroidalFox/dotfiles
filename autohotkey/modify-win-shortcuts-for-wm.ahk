; Remap Win+N to launch Alacritty.
#n::Run("alacritty.exe")
#+n:: {
    Run('alacritty.exe --option "colors.primary.background=\"#e7f0ff\"" --command "wsl --cd ~"')
}

; Remap Win+A to open Notifications(Win+N)
#a::Run("ms-actioncenter:")

; Remap Win+C to open File Explorer(Win+E)
#c::Run("explorer.exe")

#h::Return
#k::Return
#^f::Return
#^s::Return
