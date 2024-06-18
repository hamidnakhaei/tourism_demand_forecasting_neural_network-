function [E, grad] = costFunctionRBFN(theta, X, y)

m = length(y); % number of training examples
a3 = zeros(m, 1);
a3 = X * theta;
diff = a3 - y;

% Take the squared difference.
sqrdDiff = diff.^2;

% Take the sum of all the squared differences.
E = sum(sqrdDiff);

% Divide by 2m to get the average squared difference.
E = E / (2 * m);
grad = zeros(size(theta));
grad = X' * diff;
grad = grad / m;

end
