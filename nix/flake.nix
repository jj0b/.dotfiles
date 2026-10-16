{
  description = "zen nix-darwin and Linux home-manager flake";

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
    # Tracks nixpkgs-unstable. Omarchy is Arch, so Linux uses home-manager
    # rather than a NixOS configuration.
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, homebrew-core, homebrew-cask, home-manager }:
  let
    # Tools that exist in nixpkgs on both macOS and Linux.
    commonPackages = pkgs: [
      pkgs.neovim
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

    # Homebrew formulae with nixpkgs builds. macOS keeps installing these
    # through Homebrew; Linux has no Homebrew in this flake.
    linuxPackages = pkgs: [
      pkgs.bun
      pkgs.gh
      pkgs.nodejs
      pkgs.pnpm
      pkgs.stripe-cli
    ];

    mkLinuxHome = system: home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      modules = [
        ({ pkgs, ... }: {
          home.username = "jason";
          home.homeDirectory = "/home/jason";
          # Set once, when this profile is first created. Do not bump it on
          # later home-manager upgrades.
          home.stateVersion = "26.05";
          home.packages = commonPackages pkgs ++ linuxPackages pkgs;
          programs.home-manager.enable = true;
        })
      ];
    };

    configuration = { pkgs, ... }: {

      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = commonPackages pkgs;

      homebrew = {
        enable = true;

        taps = [
          "homebrew/core"
          "homebrew/cask"
        ];

        brews = [
          "bun"
          "gh"
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
    # macOS: darwin-rebuild switch --flake ~/.dotfiles/nix#zen
    #
    # Linux, including Omarchy (x86_64). Install Nix, then:
    #   nix run github:nix-community/home-manager -- switch --flake ~/.dotfiles/nix#jason
    # Later switches can use the home-manager that profile installed:
    #   home-manager switch --flake ~/.dotfiles/nix#jason
    # ARM Linux uses ~/.dotfiles/nix#jason-aarch64.
    # Dotfiles stay with install.sh (stow). This does not replace Omarchy's configs.
    darwinConfigurations."zen" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            # ~/.zshrc already runs `brew shellenv`. The default integration
            # writes another one into /etc/zshrc, which duplicates PATH in
            # nested shells. Takes effect on the next darwin-rebuild.
            enableZshIntegration = false;
            # Apple Silicon Only
            enableRosetta = true;
            # User owning the Homebrew prefix
            user = "jason";

            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
            };

            mutableTaps = false;
          };
        }
      ];
    };

    homeConfigurations = {
      jason = mkLinuxHome "x86_64-linux";
      jason-aarch64 = mkLinuxHome "aarch64-linux";
    };
  };
}
