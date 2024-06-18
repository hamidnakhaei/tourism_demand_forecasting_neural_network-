%% Initialization
clear all ; close all; clc

%% defining NN properties
input_layer_size  = 10;    % 4 Inputs
hidden_layer_size = 20;    % 9 hidden units
output_layer_size = 10;   % 1 out put equevalent to incoming number of tourists  
                
%% Loading Data
%  We start by first loading the dataset. 
% Load Training Data
% implementing k_fold cross validation method
load('DATA');
% k = number of folds
k = 4; % 4 validation data
% ith is fold number ith 
ith = 3; 
% randomizing the order of data
sell = randperm ( size(input , 1));
% selecting two first rows of randomized data for final test 
% X = input;
% y = output;
% m = size(input, 1);
% for i = 1:m
%     input (i,:) = X (sell(i) , :);
%     output (i,:) = y(sell(i) , :);
% end
% Xt is test input data set, yt is test output data set
% selecting first 2 rows for test
[X , y , Xv , yv , Xt , yt] = Kfold (input , output , k ,ith);
pause;
%%  Initializing Pameters 

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, output_layer_size);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

%%  Compute Cost (Feedforward)
fprintf('\nFeedforward Using Neural Network ...\n')

[E , grad] = nnCostFunction(initial_nn_params, input_layer_size, hidden_layer_size, ...
                   output_layer_size, X, y);

fprintf(['Cost at initial parameters without regularization: %f '], E);
pause;
%%  Training NN 
%training NN with SD method
nn_params = initial_nn_params;

% etta is training rate
etta = 20;
number_of_max_epochs = 10000;
E2 = E;
%Jmax is the cost that we can tolerate
Emax = 5e-2;
for  i = 1:number_of_max_epochs
    if E >= Emax
        %avoiding of local mins
        E1 = E;
        if etta > .03
            if E2 > E1
                etta = 0.7*etta;
            elseif E2 < E1
                etta = 1.1*etta;
            end
        end
        nn_params = SD (nn_params , input_layer_size, ...
                          hidden_layer_size, output_layer_size, grad, etta); 
        [E, grad] = nnCostFunction(nn_params, input_layer_size, ...
                          hidden_layer_size, output_layer_size, X, y);
        E2 = E;
        E
    else
        fprintf('stopped after %d epochs with %f cost value' , i , E);
        break;
    end
end
fprintf('stopped stopped because of maximum epoch');

Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 output_layer_size, (hidden_layer_size + 1));
E
pause;
%%  whoing Weights 
fprintf('\n shoing Neural Network weights... \n')
display(Theta1(:, 2:end));
pause;
display(Theta2(:, 2:end));

pause;

%% validation
pred = predict(Theta1, Theta2, Xv);
pred
c = pred - yv;
c = c.^2;
c = sum(sum(c));
c = c^(1/2)
%% test
test = predict ( Theta1 , Theta2 , Xt);
test