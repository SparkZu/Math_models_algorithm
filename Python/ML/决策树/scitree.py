from sklearn import tree
from sklearn.datasets import load_wine
from sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt

# import pandas as pd
wine = load_wine()
# print(wine)

# print(pd.concat([pd.DataFrame(wine.data), pd.date_range(wine.target)], axis=1))

X_train, X_test, y_train, y_test = train_test_split(wine.data,
                                                    wine.target,
                                                    test_size=0.3)
feature_name = [
    '酒精', '苹果酸', '灰', '灰的碱性', '镁', '总酚', '类黄酮', '非黄烷类酚类', '花青素', '颜色强度', '色调',
    'od280/od315稀释葡萄酒', '脯氨酸'
]

# 实例化
# clf = tree.DecisionTreeClassifier(criterion='gini',
#                                   random_state=30,
#                                   splitter="random")
# model = clf.fit(X_train, y_train)
# result = clf.score(X_test, y_test)
test = []
for i in range(10):
    clf = tree.DecisionTreeClassifier(max_depth=i + 1,
                                      criterion='entropy',
                                      random_state=30)
    model = clf.fit(X_train, y_train)
    score = clf.score(X_test, y_test)
    test.append(score)
plt.plot(range(1, 11), test, color='blue', label='max_depth')
plt.legend()
plt.show()

# /
