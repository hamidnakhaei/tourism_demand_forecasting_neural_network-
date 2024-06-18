function [X_train , y_train , X_validation , y_validation ,...
                X_test , y_test , validation , ymean , ymax , ymin] = ...
                Kfold (raw_X , raw_y , k , ith)
% X is training input data set, y is training output data set
% Xv is validation input data set, yv is validation output data set
% Xt is test input data set, yt is test output data set

Xt = raw_X (22:23 , :);
yt = raw_y (22:23 , :);

raw_X (22:23 , :) = [];
raw_y (22:23 , :) = [];

s = (ith - 1)*k + 1;  % starting row of validation data
e = ith*k;            % ending row of validation data
Xv = raw_X (s:e , :);
X = raw_X;
X (s:e , :) = [];
yv = raw_y (s:e , :);
y = raw_y;
y (s:e , :) = [];
[X_train , y_train , X_validation , y_validation ,...
                X_test , y_test , validation , ymean , ymax , ymin] = ...
                normalizer (X , y , Xv , yv , Xt , yt);



end