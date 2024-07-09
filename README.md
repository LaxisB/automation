# Automation

some pc automation stuff


Bakeware releases don't work at the moment! use normal mix releases

## Installation

As this is a windows-focused application, we need to install some tooling first. If you already have a working elixir env, skip to step 4

1. get [scoop](https://scoop.sh) via powershell
   ```powershell
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
   ```
2. install build tools and elixir
   ```bash
    scoop bucket add extras
    scoop install extras/vcredist2022 make mingw zstd erlang elixir

   ```
3. set up hex
   ```bash
    mix local.hex
    mix local.rebar
   ```
4. install deps
   ```bash
   mix deps.get
   mix deps.compile # for bakeware
   ```
5. build the thing
   ```bash
   mix release
   ```

