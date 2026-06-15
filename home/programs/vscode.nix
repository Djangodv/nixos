{ pkgs, ... }:
{

	# Create custom .desktop entry for VSCode so 'dev-shell' is used at startup
	# Source: https://nix-community.github.io/home-manager/options.xhtml#opt-xdg.desktopEntries
	xdg.desktopEntries.code = {

		categories = [ "Utility" "TextEditor" "Development" "IDE" ];
		comment= "Code Editing. Redefined.";
		# "bash -c <command>" executes the specified command inside a new bash instance
		exec = ''/run/current-system/sw/bin/dev-shell -c "code %F"'';
		genericName = "Text Editor";
		icon = "vscode";
		name = "Visual Studio Code";
		startupNotify = true;
		type = "Application";
		settings = {
			Keywords = "vscode";
			StartupWMClass = "Code";
			Version = "1.5";
		};

		actions = {
			"new-empty-window" = {
				exec = ''/run/current-system/sw/bin/dev-shell -c "code --new-window %F"'';
				icon = "vscode";
				name = "New Empty Window";
			};
		};
	};

	# Enable VSCode
	programs.vscode = {
		enable = true;
	};

	# Source: https://davi.sh/blog/2024/11/nix-vscode/
	programs.vscode.profiles.default = {

		# Extensions
		extensions = with pkgs.vscode-extensions; [
			vscodevim.vim
			formulahendry.code-runner
			yzane.markdown-pdf
			vscodevim.vim
			tomoki1207.pdf
			ms-vscode.cpptools
			ms-python.python
			ritwickdey.liveserver
			bbenoist.nix
		];

		# Generate settings.json:
    userSettings = {

		# Focus on terminal after executing a file
		"terminal.integrated.focusAfterRun" = "terminal";
		# Use tab to cycle through list of completions
		"editor.tabCompletion" = "on";
		# Autosave files upon changing editor focus
		"files.autoSave" = "afterDelay"; # Used to be "onFocusChange"
		# Never ask for confirmation when performing certain actions
		"security.workspace.trust.untrustedFiles" = "open";
		"explorer.confirmDragAndDrop" = false;
		"explorer.confirmDelete" = false;
		# Show snippets as first item in autocomplete menu (enables snippet completion w. tab in *.md files)
		"editor.snippetSuggestions" = "top";

		# Visual preferences
		"workbench.sideBar.location" = "right";
		"window.commandCenter" = false; # Search bar at the top
		"workbench.layoutControl.enabled" = false; # Top-right layout controls
		# "chat.commandCenter.enabled" = false;
		"editor.minimap.enabled" = false; # Code mini-map
		"workbench.activityBar.location" = "top";
		"window.menuBarVisibility" = "compact"; # Top-left menu

		# Disable AI chat feature
		"chat.disableAIFeatures" = true; 
		# Hide secondary sidebar
		"workbench.secondarySideBar.defaultVisibility" = "hidden";
		# Disble annoying hint to start copilot in new empty file
		"workbench.editor.empty.hint" = "hidden";

		# Extension related settings
		
		# Exceptions for certain keysbindings to be handled by VSCode
		"vim.handleKeys" = {
			# <c-k> in VSCode is used for a bunch of keyboard shortcuts
			"<C-k>" = false;
			"<C-j>" = false;
			"<C-p>" = false;
			"<C-b>" = false;
			"<C-h>" = false;
			"<C-w>" = false;
			"<C-d>" = false;
			"<C-n>" = false;
			"<C-a>" = false;
		};

		"vim.normalModeKeyBindings" = [
			{
				"before" = ["<space>"];
				"after" = [":"];
			}
		];

		"vim.visualModeKeyBindings" = [
			{
				"before" = ["<space>"];
				"after" = [":"];
			}
		];

		"code-runner.runInTerminal" = true;
		"code-runner.executorMap" = {
			"cpp" = "cd $dir && g++ $fileName -o $fileNameWithoutExt && $dir$fileNameWithoutExt";
			"python" = "python -u";
		};

		# Deprecated
		# Never insert a space after commenting code w. <c-/>
		# "editor.comments.insertSpace" = false;
		# Open new window horizontally = "down" (default value: "right")
		# "workbench.editor.openSideBySideDirection" = "down";
		# Use a vimrc file for specifying keybindings
		# "vim.vimrc.enable" = true;

	};

		# Generate keybindings.json
		keybindings = [
			# Source: https://github.com/microsoft/vscode/issues/37366#issuecomment-566011854
			{
				"key" = "ctrl+tab";
				"command" = "workbench.action.quickOpenPreviousRecentlyUsedEditor";
				"when" = "!inEditorsPicker";
			}
			{
				"key" = "ctrl+shift+v";
				"command" = "markdown.showPreviewToSide";
				"when" = "!notebookEditorFocused && editorLangId == 'markdown'";
			}
			{
				"key" = "ctrl+j";
				"command" = "workbench.action.quickOpenSelectNext";
				"when" = "inQuickOpen";
			}
			{
				"key" = "ctrl+k";
				"command" = "workbench.action.quickOpenSelectPrevious";
				"when" = "inQuickOpen";
			}
			{
				"key" = "ctrl+l ctrl+f";
				"command" = "search.action.openNewEditor";
				"when" = "!terminalFocus";
			}
			{
				"key" = "ctrl+l ctrl+c";
				"command" = "workbench.files.action.collapseExplorerFolders";
				"when" = "!terminalFocus";
			}
			{
				"key" = "ctrl-j";
				"command" = "selectNextSuggestion";
				"when" = "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus || suggestWidgetVisible && textInputFocus && !suggestWidgetHasFocusedSuggestion";
			}
			{
				"key" = "ctrl-k";
				"command" = "selectPrevSuggestion";
				"when" = "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus || suggestWidgetVisible && textInputFocus && !suggestWidgetHasFocusedSuggestion";
			}
		];
		
	};

}