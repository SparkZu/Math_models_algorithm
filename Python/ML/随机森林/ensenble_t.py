from sklearn.datasets import load_breast_cancer
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import GridSearchCV
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

bc = load_breast_cancer()
print(bc.data.shape)
param_grid = {'max_depth': np.arange(1, 20, 1)}
rfc = RandomForestClassifier(n_estimators=39, random_state=90)
GS = GridSearchCV(rfc, param_grid, cv=10)
print(GS.fit(bc.data, bc.target))
print(GS.best_params_)
