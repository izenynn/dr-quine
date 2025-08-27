# dr-quine

## Status

- Status: on going
- Result: -
- Observations: (null)

## Info

42 school project.

This project is about discovering the recursion theorem of Kleene!
The challenge is to write a program whose output is its own source code.
The rules are simple:

- Self-replication: The program’s output must be an exact copy of its source code.
- No peeking: You can’t just open the source file and print its contents. That’s cheating.
- No input: The program must be completely self-contained. It can’t ask for any input to do its job.

### Included quines:

- `Collean`: prints its own source code.
- `Grace`: outputs its source code to a child file.
- `Sully`: outputs its source code to `X` files, where `X` is defined in the original source code.

## Build

### Dependencies:

- [CMake](https://cmake.org/download/) (>= 3.18).
- [Ninja](https://ninja-build.org/).

### 1. Configure with `Ninja`:

```bash
cmake -B build -G "Ninja Multi-Config" .
```

Alternatively, use a [Visual Studio generator](https://cmake.org/cmake/help/v3.18/manual/cmake-generators.7.html#visual-studio-generators)
to create a solution:

```bash
# 64-bit
cmake -B build -G "Visual Studio 17 2022" -A x64 .
# 32-bit
cmake -B build -G "Visual Studio 17 2022" -A Win32 .
```

### 2. Build:

```bash
cmake --build build --config Release
```

The [Ninja Multi-Config](https://cmake.org/cmake/help/v3.18/generator/Ninja%20Multi-Config.html)
generator lets you use other build types ([`CMAKE_BUILD_TYPE`](https://cmake.org/cmake/help/v3.18/variable/CMAKE_BUILD_TYPE.html))
like "`Debug`" or "`RelWithDebInfo`", apart from "`Release`".
`Asan` builds are also supported, they enable the address sanitizer.

The resulting binaries are in `build/<build-type>/`.

### Windows notes

To build and use `CMake` you can open a developer powershell, or load the
Visual Studio command-line tools by running [`vcvarsall.bat`](https://learn.microsoft.com/en-us/cpp/build/building-on-the-command-line#developer_command_file_locations) (locations vary) in your shell:
```
# 32-bit
path\to\vcvarsall\vcvarsall.bat x86
# 64-bit
path\to\vcvarsall\vcvarsall.bat amd64
```

##
[![forthebadge](https://forthebadge.com/images/badges/made-with-c.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/you-didnt-ask-for-this.svg)](https://forthebadge.com)