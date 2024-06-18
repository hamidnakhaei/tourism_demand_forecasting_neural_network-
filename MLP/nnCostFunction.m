function [E , grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   output_layer_size, ...
                                   X, y)

Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 output_layer_size, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
E = zeros(size(y ,2),1);
delta1=zeros(size(Theta1));
delta2= zeros(size(Theta2));
% Part 1: Feedforward the neural network and return the cost in the
%         variable J.
Y = zeros (size(y'));
for i=1:m
    a1 = X(i,:)';
    %inserting the first layer bais
    a1 = [1;a1];
    %calculating ;hidden layer input
    z1 = Theta1*a1;
    a2 = bipolar(z1);
    %inserting hidden layer bias
    a2 = [1;a2];
    %calculating hidden layer output
    z2 = Theta2*a2;
    a3 = bipolar(z2);
    Y = y(i,:)';
    d3=(a3-Y).*(bipolarGradient(z2));
    % delta Ok = d3
    d2 = ((Theta2(:,2:end)')*d3).*bipolarGradient(z1);
    delta2 = delta2 + d3*a2';
    delta1 = delta1 + d2*a1';
    E = E + (a3 - Y).^2;
end

E = sum (E);
E = E/m;
Theta2_grad = delta2/m;
Theta1_grad = delta1/m;

grad = [Theta1_grad(:);Theta2_grad(:)];
end
