function y = mf (x , interv_input)

y = zeros (1 ,10);
y(1) = trapmf(x,[interv_input(1) interv_input(1) interv_input(2) interv_input(3)]);
y(2) = trapmf(x,[interv_input(1) interv_input(2) interv_input(3) interv_input(4)]);
y(3) = trapmf(x,[interv_input(2) interv_input(3) interv_input(4) interv_input(5)]);
y(4) = trapmf(x,[interv_input(3) interv_input(4) interv_input(5) interv_input(6)]);
y(5) = trapmf(x,[interv_input(4) interv_input(5) interv_input(6) interv_input(7)]);
y(6) = trapmf(x,[interv_input(5) interv_input(6) interv_input(7) interv_input(8)]);
y(7) = trapmf(x,[interv_input(6) interv_input(7) interv_input(8) interv_input(9)]);
y(8) = trapmf(x,[interv_input(7) interv_input(8) interv_input(9) interv_input(10)]);
y(9) = trapmf(x,[interv_input(8) interv_input(9) interv_input(10) interv_input(11)]);
y(10) = trapmf(x,[interv_input(9) interv_input(10) interv_input(11) interv_input(11)]);
end
