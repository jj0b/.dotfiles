{
  description = "zen nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
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
    microsoft-git = {
      url = "github:microsoft/homebrew-git";
      flake = false;
    };
    oven-sh-bun = {
      url = "github:oven-sh/homebrew-bun";
      flake = false;
    };
    supabase-tap = {
      url = "github:supabase/homebrew-tap";
      flake = false;
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle, microsoft-git, oven-sh-bun, supabase-tap }:
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
#          pkgs.tmuxPlugins.resurrect
          pkgs.tmuxPlugins.continuum
          pkgs.tmuxPlugins.yank
          pkgs.tmuxPlugins.vim-tmux-navigator
        ];

      homebrew = {
        enable = true;

        taps = [
          "supabase/tap"
        ];

        brews = [
          "bun"
          "nvm"
          "pnpm"
          "supabase"
        ];
        
        casks = [
          "qlmarkdown"
          "git-credential-manager"
        ];

        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
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

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

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
        ({ config, ... }: {
          homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
        })
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
              "microsoft/homebrew-git" = microsoft-git;
              "oven-sh/homebrew-bun" = oven-sh-bun;
              "supabase/homebrew-tap" = supabase-tap;
            };

            mutableTaps = false;
          };
        }
      ];
    };
  };
}
