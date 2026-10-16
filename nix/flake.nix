{
  description = "zen nix-darwin system flake";

  inputs = {
    # Neovim in `environment.systemPackages` comes from this pin (pkgs.neovim).
    # To pick up a newer Neovim (e.g. patch releases like 0.12.1 → 0.12.2), refresh
    # the lock — there is no separate Neovim flake input:
    #   nix flake update ./nix
    # then `darwin-rebuild switch --flake ~/.dotfiles/nix#zen` (or your `dr` alias).
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    # nix-homebrew's default brew (5.1.7) cannot load current homebrew-core
    # formulae (`post_install_steps`, patch `file`). Keep brew current with the tap.
    nix-homebrew.inputs.brew-src.url = "github:Homebrew/brew/7.0.9";
    nix-homebrew.inputs.brew-src.flake = false;
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle }:
  let
    configuration = { pkgs, ... }: {

      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ pkgs.neovim
          pkgs.tmux
          pkgs.stow
          pkgs.lsd
          pkgs.bat
          pkgs.fzf
          pkgs.zoxide
          pkgs.ripgrep
          pkgs.fd
          pkgs.coreutils
          pkgs.lazygit
          pkgs.go
          pkgs.go-migrate
          pkgs.go-task
          pkgs.rustc
          pkgs.cargo     
          pkgs.rust-analyzer
          pkgs.tmuxPlugins.sensible
          pkgs.tmuxPlugins.yank
          pkgs.gnupg
          pkgs.doppler
          pkgs.supabase-cli
          pkgs.python313
          pkgs.poetry
          pkgs.dotenv-cli
          pkgs.julia-bin
          pkgs.pulumi
          pkgs.pulumiPackages.pulumi-python
          pkgs.awscli2
        ];

      homebrew = {
        enable = true;

        taps = [
          "homebrew/core"
          "homebrew/cask"
          "homebrew/bundle"
        ];

        brews = [
          "bun"
          "gh"
          "nvm"
          "pnpm"
          "stripe-cli"
          "supabase"
          # Vite+ (`vp`, `vpr`, `vpx`). nixpkgs has no package yet (`pkgs.vp` is an
          # unrelated image viewer; the vite-plus PR is still open), so this comes
          # from the locked homebrew-core tap. `vp upgrade` defers to Homebrew.
          "vite-plus"
        ];
        
        casks = [
          "qlmarkdown"
          "git-credential-manager"
          "ngrok"
        ];

        onActivation.cleanup = "zap";
        # Stay on the locked taps. Upgrade still runs on every activation, so a
        # plain `dr` catches formulae and casks up after the lock moves.
        onActivation.autoUpdate = false;
        onActivation.upgrade = true;
      };

      system.defaults = {
        dock.autohide = true;
        dock.magnification = true;
        dock.tilesize = 48;
        dock.largesize = 74;
        finder.FXPreferredViewStyle = "clmv";
        loginwindow.GuestEnabled = false;
        NSGlobalDomain.AppleICUForce24HourTime = true;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
        NSGlobalDomain.KeyRepeat = 2;
        NSGlobalDomain.AppleShowAllExtensions = true;
        ".GlobalPreferences"."com.apple.mouse.scaling" = 2.0;
        NSGlobalDomain.ApplePressAndHoldEnabled = false;
      };

      system.activationScripts.postActivation.text = ''
        # Screenshot preview duration
        defaults write com.apple.screencaptureui "thumbnailExpiration" -float 15
        killall SystemUIServer
      '';

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";
      nix.settings.download-buffer-size = "128M";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.primaryUser = "jason";

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#zen
    darwinConfigurations."zen" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            # Apple Silicon Only
            enableRosetta = true;
            # User owning the Homebrew prefix
            user = "jason";

            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
              "homebrew/homebrew-bundle" = homebrew-bundle;
            };

            mutableTaps = false;
          };
        }
      ];
    };
  };
}
