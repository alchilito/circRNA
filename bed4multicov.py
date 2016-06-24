import sys
import pandas as pd

try:
    circ_bed_name = sys.argv[1]
except IndexError:
    circ_bed_name = '12-273-BM_circular_RNAs.txt'

circ_bed = pd.read_csv(circ_bed_name, header=None, sep='\t')

circ_tab = circ_bed[[0, 1, 2, 60, 4, 5]]
circ_tab.columns = ['chrom', 'cStart', 'cEnd', 'gene', 'circ_reads', 'strand']
new_chrom = [c.split('~')[0] for c in circ_tab['chrom']]
new_gene = [c.split(',')[0] for c in circ_tab['gene']]
new_strand = [c[0] for c in circ_tab['strand']]
circ_tab.loc[:, 'chrom'] = new_chrom
circ_tab.loc[:, 'gene'] = ['{0}_{1}'.format(g, n) for g,n in zip(new_gene, range(len(new_gene)))]
circ_tab.loc[:, 'strand'] = new_strand

circ_mc = pd.DataFrame(columns=circ_tab.columns, index=range(len(circ_tab)*2))
c = 0
for n in range(len(circ_bed.index)):
    circ = circ_tab.iloc[n]
    circ1, circ2 = circ.copy(), circ.copy()
    cStart, cEnd = circ['cStart'], circ['cEnd']
    circ1['cStart'], circ1['cEnd'] = cStart-1, cStart+1
    circ2['cStart'], circ2['cEnd'] = cEnd-1, cEnd+1
    circ_mc.ix[c, :] = circ1
    c += 1
    circ_mc.ix[c, :] = circ2
    c += 1

circ_mc.to_csv(circ_bed_name[:-4]+'.4mc.bed', sep='\t', header=False, index=False)



