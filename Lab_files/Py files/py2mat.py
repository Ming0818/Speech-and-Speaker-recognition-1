from scipy.io import savemat
import numpy as np

tidigits = np.load('tidigits_python3.npz')
savemat('tidigits.mat', tidigits)

example = np.load('example_python3.npz')
savemat('example.mat', example)