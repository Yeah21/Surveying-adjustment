clc,clear
file='data3.xlsx';
data = xlsread(file);
n3=data(1,13);%n3=input('\n站点共有（包括控制点和观测点）：');
ZB=data(1:n3,20:21);
n1=6;%n1=input('\n控制点是从第几号开始标记的？ ');
n2=10;%n2=input('\n角度观测值的个数：');
t=10;%t=input('\n必要观测值的个数：');
n4=7;%n4=input('\n边长的观测值：');
BC=data(1:n4,12);
jiao=data(1:n2,8:10);
P1=zeros(n2);
for i=1:length(P1)
   P1(i,i)=1; 
end
P2=zeros(n4);
for i=1:length(P2)
    P2(i,i)=100/BC(i);    
end
b1=zeros(n2,2*n1-1);
shuru1=data(1:n2,14:19);
% shuru1=[1,7,8,1,0;2,1,7,2,1;3,2,1,3,2;4,3,2,4,3;9,4,3,5,4;10,9,4,0,5;5,8,7,6,0;2,5,8,7,6;1,2,5,2,7;6,4,9,8,5;10,6,4,9,8;9,10,6,0,9;3,4,6,4,8;5,2,3,7,3];

for i =1:n2
    k=shuru1(i,1);j=shuru1(i,2);h=shuru1(i,3);
    if k>0
        Xk=ZB(k,1);Yk=ZB(k,2);
    else
        Xk=0;Yk=0;
    end
    if h>0
        Xh=ZB(h,1);Yh=ZB(h,2);
    else
        Xh=0;Yh=0;
    end
    Xj=ZB(j,1);Yj=ZB(j,2);
    b1(i,:)=jiaodu(Xk,Yk,Xj,Yj,Xh,Yh...
         ,dms2degrees(jiao(i,:)),k,j,h,n1);%dms2degrees是角度的转换函数
end
b2=zeros(n4,2*n1-1);
QHzhan=zeros(n4,2);
for i =1:n4
   if ~isempty(find(shuru1(:,4)==i, 1))
       c=find(shuru1(:,4)==i);
       QHzhan(i,1)= shuru1(c(1),1);
       QHzhan(i,2)= shuru1(c(1),2);
   else 
       c=find(shuru1(:,5)==i);
       QHzhan(i,1)= shuru1(c(1),2);
       QHzhan(i,2)= shuru1(c(1),3);
   end
end

for i=1:n4
    j=QHzhan(i,1);k=QHzhan(i,2);%输入第i条边的前后站点
    b2(i,:)=bianchang(ZB(j,1),ZB(j,2),ZB(k,1),ZB(k,2),BC(i),j,k,n1);
end
B=[b1(:,1:2*(n1-1));b2(:,1:2*(n1-1))];
l=[b1(:,2*n1-1);b2(:,2*n1-1)];
P=P1;
for i=length(P1)+1:length(P1)+length(P2)
    P(i,i)=P2(i-length(P1),i-length(P1));
end
ni=inv(B'*P*B);
x=ni*B'*P*l;
ZB1=zeros(10,2);
for i = 1:(n1-1)
    ZB1(i,1)=ZB(i,1)+x(2*i-1)/1000;
    ZB1(i,2)=ZB(i,2)+x(2*i)/1000;
    fprintf('\n第%d号站点的坐标为%d %d',i,ZB1(i,1),ZB1(i,2))
end
v=B*x-l;
n=n2+n4;
a=sqrt(v'*P*v/(n-t));
Q=zeros(1,n1-1);
for i = 1:length(Q)
   Q(i)=a*sqrt(ni(2*i-1,2*i-1)+ni(2*i,2*i)); 
   fprintf('\n第%d号站点的精度为%d',i,Q(i))
end