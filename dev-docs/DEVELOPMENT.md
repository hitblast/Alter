# Developer's Guide

This guide walks you through the setup and development process for contributing to Alter.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Code Editor](#code-editor)
- [Setup](#setup)
- [File Hierarchy](#file-hierarchy)

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

## File Hierarchy

Like all other Flutter projects, Alter's primary code resides in the [lib/](lib) directory.

```bash
lib
├── core # A
├── gen # B
├── models # C
├── pages # D
├── providers # E
├── services # F
└── utils # G
```

- **A**: The core mechanics of the app. This includes the following:
  1. Database I/O functions, along with basic utility functions for interacting with it.
  2. Sequences to spawn UI components such as dialogs and sheets. These basically contain the logic behind.
  3. Functions / methods to actually set / unset / update icons.
- **B**: Generated code for managing assets for the app.
- **C**: Classes and models. The primary ones are:
  1. `App`: Represents an app which has been customized by Alter.
  2. `CommandResult` Often used by section A for processing icon modification.
- **D**: Pages and screens. These are the primary view components.
- **E**: State management providers. Primary used for storing `riverpod` providers.
- **F**: Background services such as integrity checks.
- **G**: Utility functions for using across the whole source code.
