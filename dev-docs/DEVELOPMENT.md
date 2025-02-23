# Developer's Guide

This guide walks you through the setup and development process for contributing to Alter.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Setup](#setup)

## Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (latest)
- [mise](https://mise.jdx.dev) (**optional**, latest)
- [CocoaPods](https://cocoapods.org) (optional, latest) [as a part of the Flutter dependency chain]

## Code Editor

You can use any code editor for following along the guide. I have personally used [Zed](https://zed.dev) for this
particular setup. If you're using Zed, this gives you a few benefits since the configuration files have been
bundled with this repository:

  - Low memory overhead while debugging Alter (excluding Flutter).
  - [Spawning tasks](https://zed.dev/docs/tasks) for building a production release instead of depending on `mise` / `flutter` directly.

## Setup

- Step 1: Clone the repository.

```bash
# HTTPS
git clone https://github.com/hitblast/alter.git

# SSH
git clone git@github.com:hitblast/alter.git
```

- Step 2: Install the dependencies.

  i. With `mise` (recommended):

  ```bash
  mise install && flutter pub get
  ```

  ii. Without `mise`:

  ```bash
  # Install Flutter SDK for your platform separately.
  flutter pub get
  ```

- Step 3: Build a production release.

  ```bash
  mise run build
  # this is the same as running: flutter build macos --verbose --release --tree-shake-icons
  ```
