function [X_train , y_train , X_validation , y_validation ,...
                X_test , y_test , validation , ymean , ymax , ymin , X_future] = normalizer...
                (X , y , Xv , yv , Xt , yt , Xf)
% in this function we normalize all datas
% the mapping from raw data to normalized
% is found from training data and then 
% the same mapping is applied to validation
% and test data
%% finding mean, max and min
M = zeros (size(X,2),1);
minimum = zeros (size(X,2),1);
maximum = zeros (size(X,2),1);
for i = 1:size(X,2)
    M(i) = mean(X(:,i));    %M(i) = mean value of i-th row
    minimum (i) = min(X(:,i));  %minimum(i) = minimum value of i-th row
    maximum (i) = max(X(:,i)) ; %maximum(i) = maximum value of i-th row
end
ymean = mean(y);
ymax = max (y);
ymin = min (y);
%% input train data normalization
for i = 1:size(X,1)
    for j = 1:size(X ,2)
        X(i,j) = (X(i,j) - M(j)) / (maximum (j) - minimum (j));
    end
end
%% input validation data normalization
for i = 1:size(Xv,1)
    for j = 1:size(Xv ,2)
        Xv(i,j) = (Xv(i,j) - M(j)) / (maximum (j) - minimum (j));
    end
end
%% input test data normalization
for i = 1:size(Xt,1)
    for j = 1:size(Xt ,2)
        Xt(i,j) = (Xt(i,j) - M(j)) / (maximum (j) - minimum (j));
    end
end
%% input future dara normalization
for i = 1:size(Xf,1)
    for j = 1:size(Xf ,2)
        Xf(i,j) = (Xf(i,j) - M(j)) / (maximum (j) - minimum (j));
    end
end
%% output data normalization
for i = 1:numel(y)
        y(i) = (y(i) - ymean) / (ymax - ymin);
end
for i = 1:numel(yv)
        yv(i) = (yv(i) - ymean) / (ymax - ymin);
end
for i = 1:numel(yt)
        yt(i) = (yt(i) - ymean) / (ymax - ymin);
end
y_train = y;
y_validation = yv;
y_test = yt;
%% PCA implementation
x = X;
xv = Xv;
xt = Xt;
xf = Xf;
x (: , 23:25) = [];
xv (: , 23:25) = [];
xt(: , 23:25) = [];
xf (: , 23:25) = [];
[z , zv , zt , zf , validation] = pca (x , xv , xt ,xf );
%% output
X_train = [z , X(:,23:25)];
X_validation = [zv , Xv(:,23:25)];
X_test = [zt , Xt(:,23:25)];
X_future = [zf , Xf(:,23:25)];
end




