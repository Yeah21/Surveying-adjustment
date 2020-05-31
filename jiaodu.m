function B= jiaodu( Xk,Yk,Xj,Yj,Xh,Yh,L,k,j,h,n)
%JIAODU Summary of this function goes here
%   Detailed explanation goes here
 Xk,Yk,Xj,Yj,Xh,Yh
l=zeros(2,1);
L=L*pi/180;
a=180/pi*3600;
% a=206265;
Yjk=Yk-Yj;%
Yjh=Yh-Yj;
Xjk=Xk-Xj;%
Xjh=Xh-Xj;
Shk=sqrt((Xh-Xk)^2+(Yh-Yk)^2);
Shj=sqrt((Xh-Xj)^2+(Yh-Yj)^2);
Skj=sqrt((Xk-Xj)^2+(Yk-Yj)^2);
xj=a*(Yjk/(Skj^2)-Yjh/(Shj^2))/1000;
yj=-a*(Xjk/(Skj^2)-Xjh/(Shj^2))/1000;
xk=-a*Yjk/(Skj)^2/1000;
yk=a*Xjk/(Skj)^2/1000;
xh=a*Yjh/(Shj^2)/1000;
yh=-a*Xjh/(Shj^2)/1000;
    if k~=0&&h~=0
        l(1)=L-acos((Shj^2+Skj^2-Shk^2)/(2*Shj*Skj));
        l(2)=L-2*pi+acos((Shj^2+Skj^2-Shk^2)/(2*Shj*Skj));
    else
        l(1)=0;l(2)=0;
    end
    if abs(l(1))>abs(l(2))
        l(1)=l(2);
    end
    B=zeros(1,2*n-1);
    if (0<h)&&(h<n)
        B(2*h-1)=xh;
        B(2*h)=yh;
    end
    if (0<k)&&(k<n)
        B(2*k-1)=xk;
        B(2*k)=yk;
    end
    if (0<j)&&(j<n)
        B(2*j-1)=xj;
        B(2*j)=yj;
    end
B(2*n-1)=l(1)*a;
end

