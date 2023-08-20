# Navegamos a la carpeta del proyecto
cd /vagrant

# Instalamos docker
# Instalamos dependencias
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

# Agregamos llave GPG de docker
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Configuramos el repositorio de docker
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Actualizamos repositorios
sudo apt-get update

# Instalamos la última versión de docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Clonamos el repositorio de la aplicación
git clone https://github.com/LagFlow/utn-devops-nextjs-app.git nextjs-app

# Creamos la imagen de la aplicación
sudo docker build -t nextjs-app .

# Levantamos los contenedores de la aplicación y la base de datos
sudo docker compose up -d
