from sklearn import datasets
from sklearn import svm
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score

# print(data.head())
iris = datasets.load_iris()
X = iris.data
y = iris.target
# print(X, y)
classes = ['Iris Setosa', 'Iris Ver', 'Iris Vir']

#训练集测试集
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

#训练过程
model = svm.SVC()
model.fit(X_train, y_train)
#
print(model)

prediction = model.predict(X_test)
acc = accuracy_score(y_test, prediction)
print("predictions:", prediction)
print("acc:", acc)

for i in range(len(prediction)):
    print(prediction[i], y_test[i])
