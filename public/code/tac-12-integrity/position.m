A = [1 0;1 1];
B = [1;0];
Gamma = [0;1];
U = 1;
W = eye(2);
Q = eye(2);
R = eye(2);
C = eye(2);
S = eye(2);
P = eye(2);
for i = 1:100
S = A'*S*A+W-A'*S*B/(B'*S*B+U)*B'*S*A;
end
L = -inv(B'*S*B+U)*B'*S*A;
for i = 1:100
P = A*P*A'+Q-A*P*C'/(C*P*C'+R)*C*P*A';
end
K = P*C'/(C*P*C'+R);
Pz = C*P*C'+R;
invPz = inv(Pz);
tA = [A+B*L -B*L;zeros(2) A-K*C*A];
tB = [zeros(2,1);-K*Gamma];
tC = sqrtm(invPz)*[zeros(2,2) C*A];
tD = sqrtm(invPz)*[Gamma];

Cin = zeros(4);

for i = 1:20
    Cin  = tA'*Cin*tA  + tC'*tC - (tA'*Cin*tB+tC'*tD)/ (tB'*Cin*tB+tD'*tD)* (tB'*Cin*tA+tD'*tC);
end

Rin{1} = 10000*eye(4);
hA = inv(tA);
hB = -inv(tA)*tB;
hC = tC * inv(tA);
hD = tD -tC* inv(tA)*tB;
for i=1:19
    Rin{i+1} = hA'*Rin{i}*hA + hC'*hC + Cin - (hA'*Rin{i}*hB+hC'*hD)/(hB'*Rin{i}*hB+hD'*hD)*(hB'*Rin{i}*hA+hD'*hC);
end

for i = 2:9
    X = inv(Rin{i});
    X = inv(X(3:4,3:4));
    plotellipsoid
    hold on
end
