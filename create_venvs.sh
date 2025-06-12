#!/bin/zsh
# Script para criar ambientes virtuais em cada subpasta de projeto dentro de promptFlow

cd "$(dirname "$0")"

for dir in promptFlow/*/; do
  if [ -d "$dir" ]; then
    echo "\n==> Processando $dir"
    if [ ! -d "$dir.venv" ]; then
      echo "  - Criando ambiente virtual em $dir.venv"
      python3 -m venv "$dir.venv"
    else
      echo "  - Ambiente virtual já existe em $dir.venv"
    fi
    if [ -f "$dir/requirements.txt" ]; then
      echo "  - Instalando dependências de $dir/requirements.txt"
      source "$dir.venv/bin/activate"
      pip install --upgrade pip
      pip install -r "$dir/requirements.txt"
      deactivate
    else
      echo "  - Nenhum requirements.txt encontrado em $dir"
    fi
  fi
done

echo "\nAmbientes virtuais criados e dependências instaladas!"
