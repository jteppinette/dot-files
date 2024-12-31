{ pkgs, nixpkgs, ... }:

{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "24.11";

  home.packages = [
    pkgs.dust
    pkgs.gitmux
    pkgs.procs
    pkgs.reattach-to-user-namespace
    pkgs.ripgrep
    pkgs.sd
    pkgs.tlrc
    pkgs.tmux-sessionizer
  ];

  home.file = {
    ".hushlogin".text = "";
    ".config/tms/config.toml".text = ''
      [[search_dirs]]
      path = "~/Software"
      depth = 1
    '';
  };

  home.sessionVariables = {
    NIX_PATH = "nixpkgs=${nixpkgs}";
    GITHUB_TOKEN = "";
  };

  programs.home-manager.enable = true;
  programs.eza.enable = true;
  programs.fd.enable = true;
  programs.bat.enable = true;
  programs.jq.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraLuaConfig = builtins.readFile ./nvim.lua;
    extraPackages = [ pkgs.cargo pkgs.yarn ];
    withNodeJs = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    shellIntegration = {
      enableZshIntegration = true;
    };
    keybindings = { "cmd+t" = "discard_event"; };
    settings = {
      font_size = "16.0";
      macos_option_as_alt = "yes";
      tab_bar_style = "hidden";
    };
  };

  programs.fzf = {
    enable = true;
    defaultCommand = "fd --type f";
    defaultOptions = [ "--preview" "'bat --color=always --style=numbers --line-range=:250 {}'" ];
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      vimf = ''nvim -o "$(fzf)"'';
      fda = "fd --hidden --exclude .git --exclude .direnv --exclude __pycache__ --type f";
      du = "du -A";
    };
    defaultKeymap = "emacs";
    initExtra = ''
      PROMPT='%F{blue}%~%f $ '

      function git-open() { (
          set -e
          git remote >>/dev/null
          remote=''${1:-origin}
          url=$(git config remote.$remote.url | sed "s/git@\(.*\):\(.*\).git/https:\/\/\1\/\2/")
          echo "git: opening $remote $url"
          open $url
      ); }

      if [ -z "$TMUX" ] && [ "$TERM" = "xterm-kitty" ]; then
        tmux new-session -A -c $HOME -s home;
      fi
    '';
  };

  programs.git = {
    enable = true;
    userEmail = "josheppinette@gmail.com";
    userName = "Joshua Taylor Eppinette";
    aliases = {
      conflicts = "diff --name-only --diff-filter=U --relative";
    };
    extraConfig = {
      merge = { conflictstyle = "zdiff3"; };
      init = { defaultBranch = "main"; };
    };
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    terminal = "screen-256color";
    shell = "${pkgs.zsh}/bin/zsh";
    plugins = with pkgs; [
      tmuxPlugins.yank
      tmuxPlugins.sensible
      tmuxPlugins.open
      tmuxPlugins.resurrect
      tmuxPlugins.continuum
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_status_modules_left "session application"
          set -g @catppuccin_status_modules_right "gitmux user date_time"
          set -g @catppuccin_status_left_separator "█"
          set -g @catppuccin_status_right_separator "█"
          set -g @catppuccin_date_time_text "%Y-%m-%d %I:%M %p"
        '';
      }
    ];
    extraConfig = ''
      set -gu default-command
      set -g window-status-current-format ""
      set -g window-status-format ""

      bind s display-popup -E "tms switch"
      bind o display-popup -E "tms"
      bind q run-shell "tms kill"

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
    '';
  };
}
