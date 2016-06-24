import sys
import numpy as np
import pandas as pd

try:
    multicov_name = sys.argv[1]
except IndexError:
    multicov_name = '12-273-BM_circular_RNAs.4mc.multicov'

multicov = pd.read_csv(multicov_name, header=None, sep='\t')

even_locs = []
odd_locs = []
evens = []
odds = []
for n in range(len(multicov.index)):
    if n % 2 == 0:
        even_locs.append(multicov.ix[n, 1])
        evens.append(multicov.ix[n, 6])
    else:
        odd_locs.append(multicov.ix[n, 1])
        odds.append(multicov.ix[n, 6])

def process_locs(even_locs, odd_locs):
    first_col = []
    second_col = []
    for a, b in zip(even_locs, odd_locs):
        if a < b:
            first_col.append(a)
            second_col.append(b)
        else:
            first_col.append(b)
            second_col.append(a)
    return first_col, second_col

evens, odds = np.array(evens), np.array(odds)
first_col, second_col = process_locs(even_locs, odd_locs)

total_reads = (evens + odds) / 2.0
circ_reads = np.array(list(multicov[4])[::2])
ratio = circ_reads / total_reads

ratio_df = multicov.ix[::2, :]
ratio_df.loc[:, 1] = first_col
ratio_df.loc[:, 2] = second_col
ratio_df.loc[:, 3] = [name.split('_')[0] for name in ratio_df.loc[:, 3]]
ratio_df.loc[:, 6] = ratio

ratio_df.to_csv(multicov_name.replace('4mc.multicov', 'ratio.txt'), header=False, index=False, sep='\t')

