function g = bipolar(z)

g = (1.0 - exp(-z)) ./ (1.0 + exp(-z));
end