function z = predict(Centers, betas, Theta, input)
    phis = getRBFActivations(Centers, betas, input);
    
    % Normalize the neuron activations.  
        phis = phis ./ sum(phis);
    % Add a 1 for bias
    phis = [1; phis];
    z = Theta' * phis;
        
end