from sklearn import datasets
from sklearn import linear_model
import matplotlib
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split

boston = datasets.load_boston()
X = boston.data
y = boston.target

print(X)
