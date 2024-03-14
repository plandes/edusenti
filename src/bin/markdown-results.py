#!/usr/bin/env python

"""Prepare results for README.md model performance reporting.

"""
from typing import Dict
import re
import pandas as pd


def main():
    repl: Dict[str, str] = {
        'model': 'Model',
        'wF1t': 'F1',
        'wPt': 'Precision',
        'wRt': 'Recall'}
    df: pd.DataFrame = pd.read_csv('result-summary.csv', index_col=0)
    df['model'] = df['name'].apply(lambda s: re.sub(r'.*: (.+): \d$', r'\1', s))
    df = df.sort_values('model')
    df = df[list(map(lambda t: t[0], repl.items()))]
    df = df.rename(columns=repl)
    for c in df.select_dtypes(include='float'):
        df[c] = df[c].apply(lambda x: f'{x * 100:.1f}')
    print(df.to_markdown(index=False))


if (__name__ == '__main__'):
    main()
