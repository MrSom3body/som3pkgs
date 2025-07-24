# 📦 som3pkgs

You can find all my custom packages in this repo to import them into your flake.
Some also provide custom modules if it makes sense (can be seen in the table).

| Package           | Use                                                                                                                          | Module |
| ----------------- | ---------------------------------------------------------------------------------------------------------------------------- | :----: |
| `auto-kbd-bl`     | Automatically turn the keyboard backlight on when the screen brightness falls under a threshold                              |   ✅   |
| `fnott-dnd`       | Toggle `fnott`'s DND status (because it doesn't provide a way to toggle it :( )                                              |   ❌   |
| `fuzzel-goodies`  | Fuzzel scripts for a bunch of functionality like: emoji picker, file picker, hyprland window picker, ...                     |   ❌   |
| `gns3-auto-confg` | Automatically create basic configuration files for cisco devices                                                             |   ❌   |
| `hyprcast`        | Record your screen with wl-screenrec with notification support (most useful when run with a key bind)                        |   ❌   |
| `power-monitor`   | Automatically switch between power-saver and performance mode when plugging or unplugging your laptop (copied from @fufexan) |   ✅   |
| `touchpad-toggle` | Toggle your touchpad on Hyprland                                                                                             |   ❌   |
| `wl-ocr`          | OCR your screen on wayland                                                                                                   |   ❌   |

## 🚀 Using them

To use them put this into your inputs:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    som3pkgs = {
      url = "github:MrSom3body/som3pkgs";
      # this will break reproducibility, but lower the instances of nixpkgs
      # in flake.lock and possibly duplicated dependencies
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{
    nixpkgs,
    ...
  }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
        (
          {pkgs, ...}: let
            inherit (pkgs) system;
          in {
            environment.systemPackages = [
              inputs.som3pkgs.packages.${system}.fuzzel-goodies
            ];
          }
        )
      ];
    };
  };
}

```

## 💾 Credits & Resources

- [getchoo/getchpkgs](https://github.com/getchoo/getchpkgs) for giving me an
  idea to split out my packages
- [fufexan/dotfiles](https://github.com/fufexan/dotfiles) for the wl-ocr script
