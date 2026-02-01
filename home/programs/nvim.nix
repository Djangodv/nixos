{ project-root, config, inputs, pkgs, ... }:
let
  neovim-nightly = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
in
{
  programs.neovim = {
    enable = true;
    package = neovim-nightly;
		viAlias = true;
		vimAlias = true;
    # package = inputs.nvim.packages.${pkgs.system}.default;
    plugins = with pkgs.vimPlugins; [
      # LSP server configurations
      # nvim-lspconfig
      # mason-nvim
      # mason-lspconfig-nvim # Bridge mason & lspconfig
      # markdown-preview-nvim
      # gitsigns-nvim
      # kanagawa-nvim
    ];
  };

  xdg.configFile."nvim" = {
		source = config.lib.file.mkOutOfStoreSymlink "/home/user/Github/nixos/nvim";
    # source = "${project-root}/nvim";
    # source = ./conf;
    recursive = true;
    force = true;
  };

	home.packages = with pkgs; [
		pyright
		lua-language-server
		llvmPackages_20.clang-tools
		# bat
	];
	
}
