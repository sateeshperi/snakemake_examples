import numpy as np

filenames = snakemake.input

sum_all = np.zeros(len(filenames))

for i,filename in enumerate(filenames):
    sum_all[i] =  np.load(filename)
    sum_sort = np.sort(sum_all)

with open(snakemake.output[0], "w") as tf:
    tf.write(str(sum_sort))