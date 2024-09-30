# Node

brew install nvm

echo "Use nvm to install node LTS"
nvm install --lts

echo "Installing typescript-language-server, eslint_d and prettierd, emmet-ls"
npm install -g typescript-language-server eslint_d @fsouza/prettierd emmet-ls vscode-langservers-extracted
