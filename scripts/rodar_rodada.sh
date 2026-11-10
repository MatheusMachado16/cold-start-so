#!/usr/bin/env bash
# Uma rodada da coleta principal: 26 configurações x 30 frios (+50 quentes), ordem embaralhada.
# Uso: ./scripts/rodar_rodada.sh N [--sem-servicos]      (N = 1, 2 ou 3)
set -euo pipefail
RAIZ="$(cd "$(dirname "$0")/.." && pwd)"; cd "$RAIZ"
N="${1:?uso: ./scripts/rodar_rodada.sh N [--sem-servicos]}"
./scripts/00_verificar_host.sh || true
if [ "${2:-}" != "--sem-servicos" ]; then
  ./scripts/servicos.sh up
  python3 scripts/semear_servicos.py
fi
# o E4 (cache descartado) precisa descartar caches sem pedir senha: testa antes de começar
if [ "$(id -u)" != 0 ]; then
  sudo -n sh -c "sync; echo 3 > /proc/sys/vm/drop_caches" || { echo "ERRO: sudo sem senha indisponível para drop_caches"; exit 1; }
fi
# impede suspensão e ociosidade durante a coleta
systemd-inhibit --what=sleep:idle --who="cold-start" --why="coleta rodada $N" \
  python3 orquestrador/run_experimento.py --rodada "$N" --tag principal --eventos
echo "Rodada $N concluída. Confira o CSV em resultados/brutos/"