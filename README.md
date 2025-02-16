<img src="macos/Runner/Assets.xcassets/AppIcon.appiconset/icon_512x512@2x.png" width="40%" height="40%" align="right" alt="Alter Icon">

# Alter Beta [![Build](https://github.com/hitblast/Alter/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/hitblast/Alter/actions/workflows/build.yml)

Beautiful app for customizing macOS app icons with ease. <br>

> [!NOTE]
> This project is still under active development. Expect breaking changes till v1.
> Works on [macOS Ventura 13 or newer]().

## Table of Contents

- [Key Features](#key-features)
- [Installation](#installation)
- [Project Status](#project-status)
- [Common Pitfalls](#common-pitfalls)
- [Backstory](#backstory)
- [License](#license)

## Key Features

- [Simple workflow]() for changing regular app icons.
- Beautiful UI with low overhead using [Flutter](https://flutter.dev/).
- Use any image format like [.png (WIP)]() and [.icns]() as your icon.
- Continuous and managed app synchronization in the background.
- Icon modification using application-default attributes.
- A moderately small binary size for its application.

## Installation

(Recommended) Install Alter using [Homebrew](https://brew.sh/):

```
brew install --cask hitblast/tap/alter
```

Alternatively, use [GitHub Releases](https://github.com/hitblast/alter/releases) to download the latest builds.

> [!NOTE]
> By using Alter, you acknowledge that Alter is not [notarized.](https://developer.apple.com/documentation/security/notarizing_macos_software_before_distribution)
>
> It's a security feature of Apple, based on which binaries are validated before running on consumer hardware. Since I do not plan to notarize Alter, the [Homebrew installation script]() will automatically remove the `com.apple.quarantine` attribute upon installation.
>
> A better reference could be found for this concept and why invalidating the attribute is important in [this section](https://developer.apple.com/documentation/security/notarizing_macos_software_before_distribution) of the documentation nikitabobko wrote for AeroSpace.

## Project Status

This project is still under active development. Although it's stable enough for
daily-driving, expect breaking changes till v1 is relesed.

## Common Pitfalls

Based on common analysis of the project, a few common pitfalls could be found for this type of project on Macs:

- Self-validating binaries like [Discord]() do not cooperate with the attribute
modifications happening inside, and could very as well broken once they're
customized. To solve this, I've tried incorporating a [blacklist feature]() for
apps which shouldn't be modified at all.

- The [Flutter Engine](https://github.com/flutter/engine) is a part of the
compiled binary (obviously since it's a Flutter project), so it will not be *as
memory-efficient* as it would've been if I had used something like SwiftUI. It's
not really a pitfall, rather something to note when programming on Alter.

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
