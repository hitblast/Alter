# Developer's Guide

This guide walks you through the setup and development process for contributing to Alter.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Code Editor](#code-editor)
- [Setup](#setup)
- [File Hierarchy](#file-hierarchy)
- [Formatting](#formatting)

## Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (latest)
- [mise](https://mise.jdx.dev) (**optional**, latest)
- [CocoaPods](https://cocoapods.org) (optional, latest) [as a part of the Flutter dependency chain]

## Code Editor

You can use any code editor for following along the guide. I have personally used [Zed](https://zed.dev) for this
particular setup. If you're using Zed, this gives you a few benefits since the configuration files have been
bundled with this repository:

  - Low memory overhead while debugging Alter (excluding Flutter).
  - [Spawning tasks](https://zed.dev/docs/tasks) for building a production release instead of depending on `mise`/`flutter` directly.

## Setup

- Step 1: Clone the repository.

```bash
# HTTPS
git clone https://github.com/hitblast/Alter.git

# SSH
git clone git@github.com:hitblast/Alter.git

# Enter the directory.
cd Alter
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

Like all other Flutter projects, Alter's primary code resides in the [lib/](../lib/) directory.

```bash
lib
├── core # A
├── models # B
├── pages # C
├── providers # D
├── services # E
└── utils # F
```

- (A) The Core

This directory contains the code for the primary business logic of the application (e.g. to set and unset icons).
It also contains other things such as icon backup logic, app blacklisting (a currently essential part to be contributed on),
database CRUD operations and more. It also holds some reproducible UI components such as alert boxes and dialogs.

- (B) Models

This directory holds the essential data structure models used by the `core` module and other providers.

- (C) Pages

This holds the primary UI components of the application. Alter has three, primary pages:

    1. The starter page (when no apps have been modified),
    2. The icon chooser page (which shows up as a sheet), and
    3. The apps list page (when apps have been modified).

Alter can also show an error page but it's currently underdeveloped.

- (D) Providers/State Management

The state management logic of the application is handled by [riverpod](https://riverpod.dev/), which in my opinion is a
more convenient option (and advanced) than packages such as BloC and Provider.

- (E) Services

Background services are assigned in this module

- (F) Utils

A simple module for utility functions. Write any boilerplate here!

## Formatting

This project uses traditional Dart code formatting principles for the entire codebase. If you are a developer
who is working on any concurrent issue/task on Alter, integrate your changes by executing:

```bash
dart format .
```

This project also uses the following development dependencies for additional linting support.
Refer to the [pubspec.yaml](../pubspec.yaml) file for more information:

- `flutter_lints`
- `custom_lint`
- `riverpod_lint`
