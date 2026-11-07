#!/usr/bin/env python3
"""Análise dos CSVs brutos: estatísticas descritivas, diagnóstico metodológico e gráficos.

  ./analise/analisar.py                                  # todos os CSVs de resultados/brutos
  ./analise/analisar.py resultados/brutos/rodada0_*.csv  # arquivos específicos
  ./analise/analisar.py --saida piloto                   # prefixo dos arquivos gerados

Gera em analise/saida/: resumo_<p>.csv, comparacoes_<p>.csv, diagnostico_<p>.md e figuras fig_<p>_*.png
"""
from __future__ import annotations

from collections import namedtuple
from pathlib import Path

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt  # noqa: E402
import numpy as np  
import pandas as pd 
from scipy import stats  # noqa: E402


    
def correlacaoVariaveis(data: pd.DataFrame):
    matriz_corr = data.corr(numeric_only=True)
    matriz_corr.to_excel("matriz_correlacao.xlsx")


if __name__  == '__main__':
    rodada = pd.read_csv("resultados/brutos/rodada0_2026-11-01_110508_piloto.csv")
    correlacaoVariaveis(rodada)