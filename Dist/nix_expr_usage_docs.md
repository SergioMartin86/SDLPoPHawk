## Available attributes

<!-- MARKER_FOR_HELPER_SCRIPT_START -->
Installables:

Version | Attr for asms | Attr for EmuHawk | Attr for DiscoHawk
--:|:--|:--|:--
2.9.2 dev (CWD) | `bizhawkAssemblies` | `emuhawk` | `discohawk`
2.9.1 | (`bizhawkAssemblies-latest-bin`&nbsp;=&nbsp;) `bizhawkAssemblies-2_9_1-bin` | (`emuhawk-latest-bin`&nbsp;=&nbsp;) `emuhawk-2_9_1-bin` | (`discohawk-latest-bin`&nbsp;=&nbsp;) `discohawk-2_9_1-bin`
2.9.1 from source | (`bizhawkAssemblies-latest`&nbsp;=&nbsp;) `bizhawkAssemblies-2_9_1` | (`emuhawk-latest`&nbsp;=&nbsp;) `emuhawk-2_9_1` | (`discohawk-latest`&nbsp;=&nbsp;) `discohawk-2_9_1`
|||
2.9 | `bizhawkAssemblies-2_9-bin` | `emuhawk-2_9-bin` | DIY
2.9 from source | DIY | `emuhawk-2_9` | DIY
2.8 | `bizhawkAssemblies-2_8-bin` | `emuhawk-2_8-bin` | DIY
2.8 from source | DIY | `emuhawk-2_8` | DIY
2.7 | `bizhawkAssemblies-2_7-bin` | `emuhawk-2_7-bin` | DIY
2.7 from source | DIY | `emuhawk-2_7` | DIY
2.6.3 | `bizhawkAssemblies-2_6_3-bin` | `emuhawk-2_6_3-bin` | DIY
2.6.3 from source | DIY | `emuhawk-2_6_3` | DIY
2.6.2 | `bizhawkAssemblies-2_6_2-bin` | `emuhawk-2_6_2-bin` | DIY
2.6.2 from source | DIY | `emuhawk-2_6_2` | DIY
2.6.1 | `bizhawkAssemblies-2_6_1-bin` | `emuhawk-2_6_1-bin` | DIY
2.6.1 from source | DIY | `emuhawk-2_6_1` | DIY
2.6 | `bizhawkAssemblies-2_6-bin` | `emuhawk-2_6-bin` | DIY
2.6 from source | DIY | `emuhawk-2_6` | DIY
2.5.2 | `bizhawkAssemblies-2_5_2-bin` | `emuhawk-2_5_2-bin` | DIY
2.5.1 | `bizhawkAssemblies-2_5_1-bin` | `emuhawk-2_5_1-bin` | DIY
2.5 | `bizhawkAssemblies-2_5-bin` | `emuhawk-2_5-bin` | DIY
2.4.2 | `bizhawkAssemblies-2_4_2-bin` | `emuhawk-2_4_2-bin` | DIY
2.4.1 | `bizhawkAssemblies-2_4_1-bin` | `emuhawk-2_4_1-bin` | DIY
2.4 | `bizhawkAssemblies-2_4-bin` | `emuhawk-2_4-bin` | DIY
2.3.3 | `bizhawkAssemblies-2_3_3-bin` | `emuhawk-2_3_3-bin` | DIY
2.3.2 | `bizhawkAssemblies-2_3_2-bin` | `emuhawk-2_3_2-bin` | DIY

Nix functions and data:
- `buildAssembliesFor`
- `buildDiscoHawkInstallableFor`
- `buildEmuHawkInstallableFor`
- `buildExtraManagedDepsFor`
- `buildUnmanagedDepsFor`
- `depsForHistoricalRelease`
- `launchScriptsForLocalBuild`
- `releaseTagSourceInfos`
- `splitReleaseArtifact`
<!-- MARKER_FOR_HELPER_SCRIPT_END -->

There are a few parameters you can tweak without writing a full Nix expression:
- `--arg forNixOS false` wraps the final executable with [nixGL](https://github.com/nix-community/nixGL) so it can run on normal distros.
- `--argstr buildConfig Debug` builds the BizHawk solution in Debug configuration.
- `--argstr extraDefines "CoolFeatureFlag"` adds to `<DefineConstants/>`.
- `--arg initConfig {}` can be used to set up keybinds and such, though you probably won't want to use `--arg` for that.
- Check the source for the full list.

Every installable can also be used with `nix-shell`. Omitting `-A` is the same as `nix-shell -A emuhawk-latest`.
<!-- TODO haven't implemented LSPs
Bring your own IDE, or pass e.g. `--arg useVSCode true` for one that's ready to use. Alternatives: `useKate`, and `useNanoAndCola`.
-->

The `emuhawk-*` (and `discohawk-*`) attrs are wrappers, so `nix-build --check` won't rebuild the assemblies.
You can use e.g. `-A emuhawk-latest.assemblies --check`.

The `bizhawkAssemblies-*` attrs (and `*.assemblies`) each have 4 outputs: `!out`, `!assets`, `!extraUnmanagedDeps`, and `!waterboxCores`.
See `packages.nix` for more detail and help with overriding.

## Building local copy of repo (incl. changes)

### Use Nix on local source (CWD)

As per the above table:
```sh
nix-build --pure -A emuhawk
result/bin/emuhawk-* --mono-no-redirect

# may need to run this first if the checked-in copy of `Dist/deps.nix` hasn't been updated:
nix-build --pure -A emuhawk.fetch-deps && ./result
```

### Use dotnet from Nix

```sh
nix-shell # = `nix-shell -A emuhawk-latest`
# (in shell):
Dist/BuildDebug.sh # = `dotnet build -c Debug BizHawk.sln`
emuhawk-monort-local # = `cd output && mono EmuHawk.exe`

# if deps (besides NuGet packages) have changed, may need to do this instead, but it will do a slow copy of the repo to the Nix store
nix-shell -A emuhawk
```
