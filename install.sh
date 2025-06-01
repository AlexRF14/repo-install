#!/bin/bash

echo " Comprobando si pnpm está instalado..."
if ! command -v pnpm &> /dev/null; then
  echo " pnpm no está instalado. Por favor instálalo con:"
  echo "   npm install -g pnpm"
  exit 1
fi

echo " pnpm encontrado. Instalando dependencias..."
pnpm install

echo " Instalación completada. Ejecuta 'pnpm start' para correr el proyecto."

