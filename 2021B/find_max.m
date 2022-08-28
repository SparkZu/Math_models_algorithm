%%

[x,flag]=fmincon(@target_C4,[1,1,1,1,300],[],[],[],[],[25,0.01,25,1,250],[300,0.1,300,3,500])

%%

X_reg_1=[ones(size(X_reg,1),1),X_reg]
[b,bint,r,rint,stats]=regress(y_reg_acho,X_reg_1)

%%
