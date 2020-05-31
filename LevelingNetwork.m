clc,clear
file='data.xlsx'; %file='data1.xlsx';
data = xlsread(file);
n=data(1,7);
t=data(1,8);
know_station_num=data(1,9);
f=zeros(know_station_num,1);
t1=zeros(know_station_num,1);
for i =1:know_station_num
    f(i)=data(i,10);
    t1(i)=data(i,11);
end
t1=roundn(t1,-3);
S=zeros(n,1);
B=zeros(n,t);
l=zeros(n,1);
H=data(:,4);
for i = 1:n
   x=data(i,2);%ǰ�ӵ��
   y=data(i,3);%���ӵ��
   h=data(i,4);%input('ǰ���ӵ�ĸ߲�:');
   s=data(i,5);%input('ǰ���ӵ�ľ���:');
   S(i)=s;
   if any(f==x)
      location=find(f==x);
      l(i)=-t1(location)+h;
   elseif any(f==y)
      location=find(f==y);
      l(i)=t1(location)+h;
   else
      l(i)=h;
   end
   if ~any(x==f)
      B(i,x)=1;
   end
   if ~any(y==f)
      B(i,y)=-1;
   end
end
P=zeros(n,n);
for i=1:n
   P(i,i)=1/S(i);
end
ni=inv(B'*P*B); 
X=ni*B'*P*l;
v=B*X-l;
L=roundn(H+v,-4);
xlswrite(file, L, 'Sheet1', 'F2')  
Q=ni;
Q1=B*Q*B';
m0=sqrt(v'*P*v/(n-t));
for i = 1:length(Q)
   fprintf('��%d�ŵ�̵߳ľ���%d\n',i,m0*sqrt(Q(i,i)))
end
for i = 1:length(Q1)
   fprintf('��%d���۲��ߵľ���%d\n',i,m0*sqrt(Q1(i,i)))
end
