from sklearn import tree
from sklearn.datasets import load_wine
from sklearn.model_selection import train_test_split
import pandas as pd

wine = load_wine()
print(wine)
# print(pd.concat([pd.DataFrame(wine.data), pd.date_range(wine.target)], axis=1))
X_train, X_test, y_train, y_test = train_test_split(wine.data,
                                                    wine.target,
                                                    test_size=0.3)

#实例化
clf = tree.DecisionTreeClassifier()
model = clf.fit(X_train, y_train)
result = clf.score(X_test, y_test)
print(result)
