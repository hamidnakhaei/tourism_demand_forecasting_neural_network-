# Tourism Demand Forecasting Multi-layer Perceptron Neural Network, Radial Basis Function Neural Network, and Neuro-fuzzy Time Series

### Objective:
Forecasting Iran's tourism demand during 2017 and 2018
### Methodologies: 
  1. Multi-layer Perceptron Neural Network
  2. Radial basis function Neural Network
  3. Neuro-fuzzy Time Series
### Data:
**Period:** from 1995 to 2016
**Inputs:**
1. National inputs:
  - Costomer Price Index in Iran
  - The number of beds available at hotels in Iran
  - The average accommodation costs in Iran
2. International inputs:
  - A set of countries the most outbound tourists to Iran is extracted, and their GDP and population is considered, resulting in total 22 International inputs. A Principal Component Analysis (PCA) is conducted giving the final 2 international inputs.
### Muli-leyer Perceptron
- 5 inputs, 20 neurons on the hidden layer, and 1 output
- steepest descend
- 70% of data for training, 20% for cross-validation (k-fold), and 10% for testing
### Radial Basis Function
- 5 inputs, 20 neurons on the hidden layer, and 1 outpu
- $\Psi = exp \left( - \frac{{\left( x_i-c_{ij} \right) }^2}{2 \times \sigma_j^2} \right)$
- k-means clustering is used to find $C_{ij}$, intialized from randomly chosen points from the training set.
- For finding the wieghts, the same approach as MLP is conducted.
### Neuro-fuzzy Time Series
- The difference between the number of tourists in two consecutive years is considered. $d(t-1,t) = obs(t) - obs(t-1)$
- The universe of discourse is defined as: $U = \left[ \min{d(t-1,t)} , \max{d(t-1,t)} \right] = [-516000 , 846000]$
- This universe of discourse is partitioned into 10 equal-length subset and a trapezoid fuzzy set is defined on each subset.
- 

- 
