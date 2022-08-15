import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

select_supplier = ['S140', 'S229', 'S361']
file0 = pd.read_excel('附件1 近5年402家供应商的相关数据.xlsx', 0)
file1 = pd.read_excel('附件1 近5年402家供应商的相关数据.xlsx', 1)

for supplier in select_supplier:
    plt.figure(figsize=(10, 5), dpi=400)
    lw = 2
    X = np.tile(np.arange(1, 25), (1, 10)).T
    X_plot = np.linspace(1, 24, 24)
    y = np.array(file1[file1['供应商ID'] == supplier].iloc[:, 2:]).ravel()
    descrip = pd.DataFrame(
        np.array(file1[file1['供应商ID'] == supplier].iloc[:, 2:]).reshape(
            -1, 24)).describe()
    y_mean = descrip.loc['mean', :]
    y_std = descrip.loc['std', :]
    plt.scatter(X, y, c='grey', label='data')
    plt.plot(X_plot,
             y_mean,
             color='darkorange',
             lw=lw,
             alpha=0.9,
             lable='mean')
    plt.fill_between(X_plot,
                     y_mean - 1. * y_std,
                     y_mean + 1. * y_std,
                     color='darkorange',
                     alpha=0.2)
    plt.xlabel('data')
    plt.ylabel('target')
    plt.title(f'供应商ID{supplier}')
    plt.legend(loc='best', prop={'size': 8})
    plt.show()

print("d")