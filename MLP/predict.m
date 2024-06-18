function p = predict(Theta1, Theta2, X)
m = size(X, 1);        
Y = zeros (size(Theta2 , 1) , m);
for i=1:m
    a1=X(i,:)';
    %inserting the first layer bais
    a1=[1;a1];
    %calculating ;hidden layer input
    z1 = Theta1*a1;
    a2=bipolar(z1);
    %inserting hidden layer bias
    a2=[1;a2];
    %calculating hidden layer output
    z2 = Theta2*a2;
    a3=bipolar(z2);
    Y(:,i) = a3;
    
end
p = Y';
end
