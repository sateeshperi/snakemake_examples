import numpy as np

filename = snakemake.input[0]

eigh_data = np.load(filename)
eigh_sum = eigh_data.sum(axis=0).sum()

savename = snakemake.output[0]
np.save(savename, eigh_sum)