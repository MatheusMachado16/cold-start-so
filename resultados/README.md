# resultados

| Pasta | Conteúdo |
| --- | --- |
| `brutos/` | Dados reais do estudo: um CSV e um `.meta.json` por rodada, com nome `rodadaN_AAAA-MM-DD_HHMMSS_tag.csv`. Nunca sobrescrever nem editar. A análise lê **todos** os CSVs desta pasta, então testes e ensaios não devem ficar aqui |
| `falhas/` | Últimas linhas do log de contêineres que caíram durante a coleta (evidência de problemas de ambiente) |
| `rastros/` | Eventos do Docker por amostra (não versionados) |

O `.meta.json` de cada rodada guarda a semente, os parâmetros e o snapshot do ambiente (versões de sistema, kernel e Docker, imagens, swap, governador).

## Colunas principais do CSV

A lista completa está na primeira linha de cada arquivo. Métrica indisponível vira célula vazia, nunca 0.

Segue a tabela com cada coluna e uma explicação.

| Grupo | Coluna | Explicação |
|---|---|---|
| Identificação | `config_id` | Identificador da configuração (combinação de fatores) testada. |
| Identificação | `exp` | Identificador do experimento ao qual a amostra pertence. |
| Identificação | `amostra_id` | Identificador único da amostra (uma medição individual). |
| Identificação | `rodada` | Número da rodada de execução em que a amostra foi coletada. |
| Identificação | `repeticao` | Índice da repetição da mesma configuração dentro da rodada. |
| Identificação | `tipo` | Tipo de invocação: `frio` (cold start, ambiente criado do zero) ou `quente` (ambiente já inicializado e reaproveitado). |
| Identificação | `validacao` | Resultado da validação da amostra (por exemplo, se passou nos critérios de aceitação). |
| Identificação | `motivo` | Justificativa associada à validação, geralmente o porquê de uma amostra ser descartada ou marcada. |
| Fatores | `workload` | Carga de trabalho executada na função/contêiner. |
| Fatores | `runtime` | Ambiente de execução usado (linguagem/runtime). |
| Fatores | `pacote` | Pacote ou formato de empacotamento/imagem utilizado (suposição: pode se referir ao tamanho ou tipo de dependências). |
| Fatores | `mem_mib` | Memória configurada (limite solicitado), em MiB. |
| Fatores | `rede` | Modo ou configuração de rede solicitada. |
| Fatores | `cache` | Nível ou estado de cache solicitado (por exemplo, cache de imagem/camadas). |
| Tempos (ms) | `t_created_ms` | Tempo até o contêiner/instância ser criado. |
| Tempos (ms) | `t_started_ms` | Tempo até o contêiner/instância ser iniciado. |
| Tempos (ms) | `t_ready_ms` | Tempo até o serviço ficar pronto para receber requisições. |
| Tempos (ms) | `t_req_cold_ms` | Tempo da primeira requisição em invocação fria. |
| Tempos (ms) | `t_cold_total_ms` | Tempo total do cold start, da criação até a resposta da primeira requisição. |
| Tempos (ms) | `lat_req_ms` | Latência da requisição nas invocações quentes (vazia nas frias). |
| cgroup | `mem_pico_bytes` | Pico de uso de memória do cgroup durante a amostra, em bytes. |
| cgroup | `pgmajfault` | Número de falhas de página maiores (exigem leitura em disco), indicando pressão de memória ou carregamento a partir do disco. |
| cgroup | `io_rbytes` | Bytes lidos de disco pelo cgroup. |
| cgroup | `oom_kill` | Contagem de processos encerrados pelo OOM killer (falta de memória). |
| cgroup | `oom_flag` | Indicador de que ocorreu evento de OOM na amostra. |
| Configuração efetiva | `mem_efetiva_bytes` | Limite de memória realmente aplicado, em bytes (pode diferir do solicitado). |
| Configuração efetiva | `rede_efetiva` | Configuração de rede realmente aplicada. |
| Configuração efetiva | `swap_efetivo_bytes` | Limite de swap realmente aplicado, em bytes. |
| Configuração efetiva | `nano_cpus` | Limite de CPU efetivo, em unidades de 10⁻⁹ CPU (1 CPU = 1.000.000.000). |
| Configuração efetiva | `cache_nivel` | Nível de cache efetivamente presente na execução. |
| Host | `host_*` (temperatura) | Temperatura do host antes da amostra. |
| Host | `host_*` (frequência) | Frequência da CPU do host antes da amostra. |
| Host | `host_*` (memória disponível) | Memória livre no host antes da amostra. |
| Host | `host_*` (swap) | Uso de swap no host antes da amostra. |
| Host | `host_*` (tomada) | Dado da tomada (provavelmente consumo/potência medido por tomada inteligente). |
| Host | `host_*` (governador) | Governador de frequência da CPU (por exemplo, `performance` ou `powersave`). |

**Regra geral:** métrica indisponível fica como célula vazia, nunca 0, para não distorcer médias e comparações.

Resultados e figuras: `../analise/saida/`.
