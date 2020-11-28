import numpy as np

n = 8
size = 1000

for i in range(n):
    random_data = np.random.random((size,size))
    savename = snakemake.output[0]
    np.save(savename, random_data)