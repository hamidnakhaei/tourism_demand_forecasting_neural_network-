function updated_Theta = SD (nn_params , input_layer_size, ...
                          hidden_layer_size, output_layer_size , ...
                          grad , etta)
                      
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 output_layer_size, (hidden_layer_size + 1));

 Theta1_grad = reshape(grad(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2_grad = reshape(grad((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 output_layer_size, (hidden_layer_size + 1));  

Theta1 = Theta1 - etta*Theta1_grad;
Theta2 = Theta2 - etta*Theta2_grad;
updated_Theta = [Theta1(:); Theta2(:)];

end