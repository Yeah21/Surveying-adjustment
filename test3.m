fprintf('给每条观测边、站点、角度分别编序号。注：控制点的序号必须放在观测点的序号后面\n')
n3=input('\n站点共有（包括控制点和观测点）：');
fprintf('\n按坐标序号顺序依次输入坐标')
ZB=zeros(n3,2);
for i = 1:n3
    fprintf('\n%d号站点',i)
    ZB(i,1)=input('X值：') ;
    ZB(i,2)=input('Y值：') ;
end
n1=input('\n控制点是从第几号开始标记的？ ');
n2=input('\n角度观测值的个数：');
t=input('\n必要观测值的个数：');
n4=input('\n边长的观测值：');
BC=zeros(n4,1);
for i = 1:n4
    fprintf('\n第%d条边观测值',i)
    BC(i)=input('：') ;
end
jiao=zeros(n2,3);
fprintf('分别输入角的度 分 秒')
for i = 1:n2
    fprintf('\n第%d个角的',i)
    jiao(i,1)=input('度：') ;
    jiao(i,2)=input('分：') ;
    jiao(i,3)=input('秒：') ;
end
P1=zeros(n2);
for i=1:length(P1)
   P1(i,i)=1; 
end
P2=zeros(n4);
for i=1:length(P2)
    P2(i,i)=100/BC(i);    
end
b1=zeros(n2,2*n1-1);
shuru1=zeros(n2,5);
fprintf('\n按观测角的顺序输入观测角的三个站点号及两个边长')
for i = 1:n2
    fprintf('\n第%d号角',i)
    shuru1(i,1)=input('\n前站点号：');
    shuru1(i,2)=input('\n观测站号：');
    shuru1(i,3)=input('\n后站点号：');
    shuru1(i,4)=input('\n前站边的序号(若为已知边输0)：');
    shuru1(i,5)=input('\n后站边的序号(若为已知边输0)：');
end

for i =1:n2
    if shuru1(i,4)>0
        Sjh=BC(shuru1(i,4));
    else 
        Sjh=1;
    end
    if shuru1(i,5)>0
        Sjk=BC(shuru1(i,5));
    else 
        Sjk=1;
    end
    k=shuru1(i,1);j=shuru1(i,2);h=shuru1(i,3);
    b1(i,:)=jiaodu(ZB(shuru1(i,1),1),ZB(shuru1(i,1),2),ZB(shuru1(i,2),1),ZB(shuru1(i,2),2),ZB(shuru1(i,3),1),ZB(shuru1(i,3),2)...
        ,Sjh,Sjk,dms2degrees(jiao(i,:)),j,k,h,n1);
end
b2=zeros(n4,2*n1-1);
QHzhan=zeros(n4,2);
for i =1:n4
   if isempty(find(shuru1(:,4)==i))~=1
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
L=[b1(:,2*n1-1);b2(:,2*n1-1)];
P=P1;
for i=length(P1)+1:length(P1)+length(P2)
    P(i,i)=P2(i-length(P1),i-length(P1));
end
ni=inv(B'*P*B);
X=ni*B'*P*L;
for i = 1:(n1-1)
    ZB(i,1)=ZB(i,1)+X(2*i-1);
    ZB(i,2)=ZB(i,2)+X(2*i);
    fprintf('\n第%d号站点的坐标为%d %d',i,ZB(i,1),ZB(i,2))
end
v=B*X-L;
n=n2+n4;
a=sqrt(v'*P*v/(n-t));
Q=zeros(1,n1-1);
for i = 1:length(Q)
   Q(i)=a*sqrt(ni(2*i-1,2*i-1)+ni(2*i,2*i)); 
   fprintf('\n第%d号站点的精度为%d',i,Q(i))
end