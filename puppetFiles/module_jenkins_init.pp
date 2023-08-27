class jenkins {
# Se agrega la llave para instalar jenkins
  exec { 'install-jenkins-key':
    command => '/usr/bin/curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null'
  }

# Se agrega el repositorio
  -> file { '/etc/apt/sources.list.d/jenkins.list':
    ensure => file,
    source => 'puppet:///modules/jenkins/jenkins_repository_file.list'
  }

# Se actualiza los repositorios
  -> exec { 'update-repositories':
    command => '/usr/bin/apt-get update'
  }

# Se instalan los paquetes de java-11 y jenkins
  package { 'openjdk-11-jre':
    ensure => installed
  }

  package { 'jenkins':
    ensure => installed
  }
# Cambiar puerto de jenkins al 8082
  -> exec { 'change-jenkins-port':
    command => "/usr/bin/sed -i 's/Environment=\"JENKINS_PORT=8080\"/Environment=\"JENKINS_PORT=8082\"/' /lib/systemd/system/jenkins.service"
  }
  -> exec { 'reload-systemd-daemon':
    command => "/usr/bin/systemctl daemon-reload"
  }
  -> exec { 'reload-service':
    command => '/usr/bin/systemctl restart jenkins'
  }

# Iniciar el servicio de jenkins
  service {'jenkins':
    ensure => running
  }
}
