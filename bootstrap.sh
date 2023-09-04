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


# Instalación de puppet
# Se agrega el repositorio
wget https://apt.puppet.com/puppet7-release-focal.deb -P /tmp/
sudo dpkg -i /tmp/puppet7-release-focal.deb

# Actualizamos repositorios
sudo apt-get update
  
# Instalamos java 11
sudo apt-get install -y openjdk-11-jre

# Instalamos puppet server
sudo apt-get install -y puppetserver

# Definimos en nombre del host de la máquina virtual a "puppet"
sudo echo "127.0.0.1  puppetserver  puppet" >> /etc/hosts

# Movemos el archivo de configuración de puppet para que use 512mb de ram
sudo cp /vagrant/puppetFiles/puppetserver /etc/default/puppetserver

# Movemos los archivos de manifests de puppet
sudo cp /vagrant/puppetFiles/manifest_site.pp /etc/puppetlabs/code/environments/production/manifests/site.pp
sudo mkdir -p /etc/puppetlabs/code/environments/production/modules/jenkins/manifests
sudo cp /vagrant/puppetFiles/module_jenkins_init.pp /etc/puppetlabs/code/environments/production/modules/jenkins/manifests/init.pp
sudo mkdir -p /etc/puppetlabs/code/environments/production/modules/jenkins/files
sudo cp /vagrant/puppetFiles/jenkins_repository_file.list /etc/puppetlabs/code/environments/production/modules/jenkins/files/jenkins_repository_file.list

# Habilitamos comunicación en el firewall de ubuntu
sudo sed -i 's/DEFAULT_FORWARD_POLICY="DROP"/DEFAULT_FORWARD_POLICY="ACCEPT"/' /etc/default/ufw

# Ejecutamos el servicio de puppet-server
sudo /opt/puppetlabs/bin/puppet resource service puppetserver ensure=running enable=true

# Ejecutamos el servicio de puppet-agent
sudo /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true

# Conectamos puppet-agent
sudo /opt/puppetlabs/bin/puppet ssl bootstrap

# Instalar node para ejecutar pipelines de jenkins
sudo snap install node --classic