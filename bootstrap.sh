# Navegamos a la carpeta del proyecto
cd /vagrant/public

# Instalamos nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash

# Actualizamos source de bash para usar el comando nuevo de nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Instalamos node 18
nvm install v18

# Instalamos dependencias del proyecto
npm i

# Instalamos servidor http de node
npm install -g http-server
