#!/bin/bash

echo "Verificando entorno de instalación..."

# Función para sugerir instalación de Node.js según la distro
sugerir_instalacion_node() {
  echo "Node.js no está instalado."

  if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
      ubuntu|debian)
        echo "Instálalo con:"
        echo "   curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -"
        echo "   sudo apt install -y nodejs"
        ;;
      fedora)
        echo "Instálalo con:"
        echo "   sudo dnf install -y nodejs"
        ;;
      arch)
        echo "Instálalo con:"
        echo "   sudo pacman -S nodejs npm"
        ;;
      *)
        echo "No se reconoció tu distribución. Instálalo desde https://nodejs.org/"
        ;;
    esac
  else
    echo "No se pudo detectar tu sistema operativo. Visita https://nodejs.org/"
  fi

  exit 1
}

# Verifica Node.js
if ! command -v node &> /dev/null; then
  sugerir_instalacion_node
fi

# Verifica npm
if ! command -v npm &> /dev/null; then
  echo "npm no está instalado. Reinstala Node.js correctamente."
  exit 1
fi

# Verifica pnpm
if ! command -v pnpm &> /dev/null; then
  echo "pnpm no está instalado. Instalándolo con npm..."
  npm install -g pnpm

  if ! command -v pnpm &> /dev/null; then
    echo "Falló la instalación de pnpm. Intenta correr:"
    echo "   npm install -g pnpm"
    exit 1
  fi
fi

echo "Todo listo. Instalando dependencias con pnpm..."
pnpm install

echo "Instalación terminada. Ejecuta 'pnpm start' para iniciar el proyecto."
