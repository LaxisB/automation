# Automation

**TODO: Add description**

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

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `automation` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:automation, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/automation>.

