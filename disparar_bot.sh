#!/bin/bash
# Dispara el workflow del bot de señales para que corra puntual.
# Por qué: el programador propio de GitHub es impuntual; el reloj de cron-job.org quedó caído
# (medido el 11/10: las corridas salían cada 5-6 h). Este disparador lo hace puntual.
T=$(grep '^GITHUB_TOKEN_DOLAR=' ~/.hermes/.env | cut -d= -f2)
CODE=$(curl -s -o /dev/null -w '%{http_code}' -m 30 -X POST \
  -H "Authorization: Bearer $T" -H "Accept: application/vnd.github+json" -H "User-Agent: rsi-reloj" \
  -d '{"ref":"main"}' \
  https://api.github.com/repos/COEFR/Hermes-Signal-bot/actions/workflows/bot.yml/dispatches)
echo "$(date -u '+%F %T') dispatch -> $CODE" >> /home/ubuntu/.hermes/data/trading/logs/reloj.log
