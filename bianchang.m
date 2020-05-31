function B = bianchang( Xj,Yj,Xk,Yk,L,j,k,n)
% 674.567 506.177
%663.4752 570.71
%65.484 6 10 7
%BIANCHANG Summary of this function goes here
%   Detailed explanation goes here
Xjk=Xk-Xj;
Yjk=Yk-Yj;
Sjk=sqrt(Xjk^2+Yjk^2);
xj=-Xjk/Sjk;
yj=-Yjk/Sjk;
xk=-xj;
yk=-yj;
l=L-Sjk;
B=zeros(1,2*n-1);
    if j<n
        B(2*j-1)=xj;
        B(2*j)=yj;
    end
    if k<n
        B(2*k-1)=xk;
        B(2*k)=yk;
    end
     B(2*n-1)=l*1000;
end

