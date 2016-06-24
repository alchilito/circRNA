#! usr/local/bin/python

#import python modules
#import sys
import pandas as pd
#import glob

#folder = sys.argv[1]
#flist = glob.glob(folder+'/fusions_merge_*.csv')

#import dataframes
#df_list = []
#for fname in flist:
#	df = pd.read_csv(fname, sep=',', header=False, index_col=False)
#	df_list.append(df)

#df_initial = pd.merge(df_list[0], df_list[1], on='id', how='outer', suffixes=['_1', '_2']).fillna(0)
#n = 2
#for df in df_list[n:]:
#    df_initial = pd.merge(df_initial, df_list[n], on='id', how='outer', suffixes=['_'+str(n), '_'+str(n+1)]).fillna(0)
#    n = n + 1


df1 = pd.read_table('circular_RNAs_1.txt',  header=None, index_col=False)
df2 = pd.read_table('circular_RNAs_2.txt',  header=None, index_col=False)
df3 = pd.read_table('circular_RNAs_3.txt',  header=None, index_col=False)
df4 = pd.read_table('circular_RNAs_4.txt',  header=None, index_col=False)


#merge and generate a final table

df_a = pd.merge(df1, df2, how='outer').fillna(0)
df_b = pd.merge(df_a, df3, how='outer').fillna(0)
df_c = pd.merge(df_b, df4, how='outer').fillna(0)



df_c.to_csv('circular_RNAs.txt', sep='\t', header=None, index=False)