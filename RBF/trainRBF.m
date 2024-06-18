function [Centers, betas, Theta] = trainRBF(X_train, y_train, numRBFeurons, beta)
    m = size(X_train, 1);
    %% Select RBF Centers and Parameters
    % Pick random samples as the initial centroids.
    init_Centroids = kMeansInitCentroids(X_train, numRBFeurons);
    
    % Run k-means clustering, with at most 100 iterations.
    [Centers, memberships] = kMeans(X_train, init_Centroids, 100);
        
    % Compute Beta Coefficients

    
    % Simply use the same user-provided beta coefficient for all neurons.
    betas = ones(size(Centers, 1), 1) * beta;
    %betas = computeRBFBetas(X_train, Centers, memberships);
    betas
    %% Train Output Weights
    numRBFeurons = size(Centers, 1);
    X_activ = zeros(m, numRBFeurons);
    for (i = 1 : m)
       
        input = X_train(i, :);
        p = getRBFActivations(Centers, betas, input);
        X_activ(i, :) = p';
    end
    % nomralizing
        X_activ = bsxfun(@rdivide, X_activ, sum(X_activ, 2));
    % Add a column of 1s for the bias term.
    X_activ = [ones(m, 1), X_activ];
    %learning coefficien
    etta = 4;
    % initializing random theta
    L_in = numRBFeurons; 
    L_out = 1;
    epsilon_init = sqrt(6)/sqrt(L_in + L_out);
    Theta = rand(1 + L_in , L_out) * 2 * epsilon_init - epsilon_init;
    y = y_train;
    [J, grad] = costFunctionRBFN(Theta, X_activ, y);
    J1 = J;
    J2 = J+1;
    Jmax = 4e-2;
     while (abs(J) > Jmax)
         if etta > .01
            if J2>J1
                etta = 0.7*etta;
            elseif J2<J1
                etta = 1.1*etta;
            end
         elseif etta < .001
             etta = etta * 1.1;
         end
         X_activ = zeros(m, numRBFeurons);
         for (i = 1 : m)
               input = X_train(i, :);
               p = getRBFActivations(Centers, betas, input);
               X_activ(i, :) = p';
         end
    % normalizing
        X_activ = bsxfun(@rdivide, X_activ, sum(X_activ, 2));
    X_activ = [ones(m, 1), X_activ];
    J1 = J;
    [J, grad] = costFunctionRBFN(Theta, X_activ, y) ; 
    J2 = J;
     updated_Theta = SD (Theta , grad , etta) ;
     Theta = updated_Theta;
     J
     end
    Theta = pinv(X_activ' * X_activ) * X_activ' * y_train;   
    
end

