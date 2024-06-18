function [z , zv , zt , zf , validation] = pca (x , xv , xt , xf)
% applying pca for trtaining data set
m = numel(x);
x = x';
xv = xv';
xt = xt';
xf = xf';
sigma = (1/m)*x*x';
[U, S, V] = svd(sigma);
% k is the dimention of reduced data
k = 2;  
Ureduce = U(:,1:k);
size (Ureduce);
P = 0;
Q = 0;
for p = 1:k
    P = P + S(p , p);
end
for q = 1:22
    Q = Q + S(q,q);
end
% validation shows how much of variance is retained
validation = P/Q;
z = (Ureduce'*x)';
zv = (Ureduce'*xv)';
zt = (Ureduce'*xt)';
zf = (Ureduce'*xf)';
end