%plot ellipsoid x'Xx<=1
[V D] = eig(X);
theta = linspace(0,2*pi,200);


x = V(1,1) *sin(theta)/sqrt(D(1,1)) + V(1,2) *cos(theta)/sqrt(D(2,2));
y = V(2,1) *sin(theta)/sqrt(D(1,1)) + V(2,2) *cos(theta)/sqrt(D(2,2));
plot(x,y);