# Actualizamos source de bash para usar el comando nuevo de nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

cd /vagrant/

# Iniciamos servidor web en el puerto 8080
http-server
