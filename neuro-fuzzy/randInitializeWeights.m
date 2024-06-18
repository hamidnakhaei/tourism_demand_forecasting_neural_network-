function W = randInitializeWeights(L_in, L_out)

W = zeros(L_out, 1 + L_in);
%One e?ective strategy for choosing epsilom_init is to base it on the
%number of units in the network. A good choice of init is 
%init = ?6 /?(L_in+L_out)
epsilon_init = sqrt(6)/sqrt(L_in + L_out);
W = rand(L_out, 1 + L_in) * 2 * epsilon_init - epsilon_init; 

end
