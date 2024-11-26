# Ghostty is my ultimate guinea pig for this project.
# So, if I fuck up something, here is the code to unfuck it:

defaults write /Applications/Ghostty.app/Contents/Info CFBundleIconName AppIcon
defaults write /Applications/Ghostty.app/Contents/Info CFBundleIconFile AppIcon
touch /Applications/Ghostty.app
codesign --force --deep --sign - /Applications/Ghostty.app
