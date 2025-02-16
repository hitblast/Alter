<img src="macos/Runner/Assets.xcassets/AppIcon.appiconset/icon_512x512@2x.png" width="40%" height="40%" align="right" alt="Alter Icon">

# Alter Beta

Beautiful app for customizing macOS app icons with ease. <br>

> [!NOTE]
> This project is still under active development. Expect breaking changes till v1.
> Works on [macOS Big Sur 11.5 or newer]().

## Table of Contents

- [Key Features](<README#Key Features>)
- [Project Status](<README#Project Status>)
- [Backstory](README#Backstory)
- [License](README#License)

## Key Features

- [Simple workflow]() for changing regular app icons.
- Beautiful UI with low overhead using [Flutter](https://flutter.dev/).
- Use any image format like [.png (WIP)]() and [.icns]() as your icon.
- Continuous and managed app synchronization in the background.
- Icon modification using application-default attributes.

## Project Status

This project is still under active development. Although it's stable enough for
daily-driving, expect breaking changes till v1 is relesed.

## Backstory
As an ex-Linux and ex-Windows user, customizability was at the forefront of what
I was doing with my laptop back when I started learning. However, when I
switched to my Apple Silicon-powered machine, I wasn't really sure how to take
"customizability" like I used to. Sure, there are apps like
[AeroSpace](https://github.com/nikitabobko/AeroSpace), [Karabiner
Elements](https://karabiner-elements.pqrs.org/) and
[Raycast](https://www.raycast.com/) which help me power through my everyday
workflow now, but aside of keybindings and shortcuts, I also wanted my Mac to
look and feel just like how I want it to.

I eventually came across
[IconChamp](https://www.macenhance.com/iconchamp.html)
and [Pictogram](https://pictogramapp.com/), and while the latter one allows me
to easily change "some" of my app icons, IconChamp can change basically all of
them. Including, obviously, system icons. The problem? None of them are really
"open-source" and not "really stable" either, according to [this Reddit
thread](https://www.reddit.com/r/macapps/comments/1dm1uad/has_iconchamp_been_abandoned/)
which describes IconChamp glitching out while changing system icons on a regular
basis.

I wanted to take the good parts of both apps and make my own, personal solution
with a fully open-sourced near-native development experience.

## License

This project has been licensed under the [MIT License](./LICENSE).
