<img src="macos/Runner/Assets.xcassets/AppIcon.appiconset/icon_512x512@2x.png" width="40%" height="40%" align="right" alt="Alter Icon">

# Alter

Alter is a minimal macOS app which can be used to customize your app icons with ease. <br>
📦 Works on **macOS Sonoma 14 or newer.**

## Table of Contents

- [Key Features](#key-features)
- [Installation](#installation)
- [Roadmap](#roadmap)
- [Backstory](#backstory)
- [Common Pitfalls](#common-pitfalls)
- [Contributing](#contributing)
- [License](#license)

## Key Features

- Simple workflow for changing regular app icons
- Beautiful UI with low overhead using [Flutter](https://flutter.dev/)
- Both [.png]() and [.icns]() usable as valid formats for icons
- Doesn't require disabling [SIP (System Integrity Protection)]()
- Continuous and managed app synchronization in the background
- Icon modification using application-default attributes

## Installation

🍺 Install Alter using [Homebrew](https://brew.sh/) **(Recommended)**:

```bash
brew install --cask hitblast/tap/alter
```

Alternatively, use [GitHub Releases](https://github.com/hitblast/alter/releases) to download the latest builds.

> [!IMPORTANT]
> By using Alter, you acknowledge that Alter is not [notarized.](https://developer.apple.com/documentation/security/notarizing_macos_software_before_distribution)
>
> It's a security feature of Apple, based on which binaries are validated before running on consumer hardware. Since I do not plan to notarize Alter, the [Homebrew installation script]() will automatically remove the `com.apple.quarantine` attribute upon installation.
>
> A better reference could be found for this concept and why invalidating the attribute is important in [this section](https://developer.apple.com/documentation/security/notarizing_macos_software_before_distribution) of the documentation nikitabobko wrote for AeroSpace.

## Roadmap

After the initial release of v1 for this project, my target is to take the whole codebase
and enhance it by entirely using [Swift]() and [SwiftUI]() with an identical user experience.
Since Flutter is a great framework for creating production-ready prototypes, I figured it'd
be best for the users that I migrate the toolchain to be Apple's native.

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

---

## Common Pitfalls

Based on common analysis of the project, a few issues have been found for this type of project on Macs:

- Self-validating binaries like [Discord](https://discord.com/) do not cooperate with the attribute
modifications happening inside, and could very as well broken once they're
customized. To solve this, I've tried incorporating a blacklist of
apps which should be prohibited from modifying unless the user really desires.

- The [Flutter Engine](https://github.com/flutter/engine) is a part of the
compiled binary (obviously since it's a Flutter project), so there will always be a tiny
burden of a few megabytes worth of memory usage unless Flutter is optimized further.

- For now, Alter cannot modify the system apps on macOS due to SIP (System Integrity Protection) being a thing.

## Contributing

Contributions are always welcome. If you are a developer who is willing to improve *any* aspect of the application,
consider reading [dev-docs/DEVELOPMENT.md](/dev-docs/DEVELOPMENT.md) for everything related to
reproducing the development environment and more. If you have already attached the development environment, however,
consider following through the ethical guidelines of contributing written in [CONTRIBUTING.md](/CONTRIBUTING.md).

## License

This project has been licensed under the [MIT License](./LICENSE).
