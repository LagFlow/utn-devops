# Vamos a la carpeta del proyecto
cd /vagrant

# Iniciamos los contenedores de la aplicación
sudo docker compose up -d

# Instalamos node si no existe
if ! which node > /dev/null; then
    sudo snap install node --classic
fi
