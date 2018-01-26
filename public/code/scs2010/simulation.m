clc
clear
A = [1 0;1 1];
B = [1;0.5];
C = eye(2);
Q = eye(2);
R = eye(2);
W = eye(2);
U = 1;
n = 2;
m = 2;
P = 0;
S = 0;
for i = 1:100
    P = A*P*A'+Q-A*P*C'*inv(C*P*C'+R)*C*P*A';
    S = A'*S*A +W - A'*S*B*inv(B'*S*B+U)*B'*S*A;
end
K = P*C'*inv(C*P*C'+R);
L = -inv(B'*S*B+U)*B'*S*A;

cP = C*P*C' + R;
invcP = inv(cP);

Gamma = [0;1];
grammian = -[K*Gamma (A-K*C*A)*K*Gamma];
tmp = inv(grammian)*[0;1];
ya(1) = tmp(2);
ya(2) = tmp(1);
for i = 3:31
    ya(i) = ya(i-2) - 1;
end

e(:,1) = -K*Gamma*ya(1);
z(:,1) = -Gamma*ya(1);
for i=2:21
    e(:,i) = (A-K*C*A) * e(:,i-1) - K*Gamma * ya(i);
    z(:,i) = C*A * e(:,i-1) + Gamma * ya(i);
end

M = max(norm(z(:,1)),norm(z(:,2)));
e = e/M;
ya = ya/M;
z = z/M;
for i = 1:21
    normz(i) = norm(z(:,i));
end

hatx(:,1) = K*z(:,1);
for i = 2:21
    hatx(:,i) = (A+B*L)*hatx(:,i-1)+K*z(:,i);
end
x = hatx + e;

figure(1)
hold on
plot(0:20,x(1,:),'b-','Linewidth',2);
plot(0:20,x(2,:),'r+--','Linewidth',2);
plot(0:20,normz,'ko-.','Linewidth',2);
legend('$\Delta \dot{x_k}$', '$\Delta x_k$', '$D(z`_k\|z_k)$','location','best');
h = legend;
set(h, 'interpreter', 'latex','fontsize',16)
xlabel('k','fontsize',12);
h = gca;
set(h,'Fontsize',12);
hold off


thre = chi2inv(0.95,m);
for index = 1:50000
    x = sqrt(P) * randn(n,1);
    hatx1 = zeros(n,1);
    for i = 1:31
        y(:,i) = x(:,i) + sqrt(R) * randn(m,1)+Gamma*ya(i);
        residue = y(:,i) - C * hatx1(:,i);
        normresidue(i,index) = residue'*invcP*residue;
        hatx2(:,i) = hatx1(:,i) + K * residue;
        u(:,i) = L*hatx2(:,i); 
        hatx1(:,i+1) = A*hatx2(:,i) + B*u(:,i) ;
        x(:,i+1) = A*x(:,i) + B*u(:,i)+sqrt(Q)*randn(n,1);
    end
end
normresidue = (normresidue > thre);
detectionprob = sum(normresidue,2)/50000;

figure(2)
hold on
plot(0:20,detectionprob(11:31),'k','Linewidth',2);

xlabel('k','fontsize',12);
ylabel('Probability of Detection','fontsize',12);
h = gca;
set(h,'Fontsize',12);
hold off

