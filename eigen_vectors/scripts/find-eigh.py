import numpy as np

filename = snakemake.input[0]

random_data = np.load(filename)
eigh_values, _ = np.linalg.eigh(random_data)

savename = snakemake.output[0]
np.save(savename, eigh_values)