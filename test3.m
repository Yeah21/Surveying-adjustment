fprintf('��ÿ���۲�ߡ�վ�㡢�Ƕȷֱ����š�ע�����Ƶ����ű�����ڹ۲�����ź���\n')
n3=input('\nվ�㹲�У��������Ƶ�͹۲�㣩��');
fprintf('\n���������˳��������������')
ZB=zeros(n3,2);
for i = 1:n3
    fprintf('\n%d��վ��',i)
    ZB(i,1)=input('Xֵ��') ;
    ZB(i,2)=input('Yֵ��') ;
end
n1=input('\n���Ƶ��Ǵӵڼ��ſ�ʼ��ǵģ� ');
n2=input('\n�Ƕȹ۲�ֵ�ĸ�����');
t=input('\n��Ҫ�۲�ֵ�ĸ�����');
n4=input('\n�߳��Ĺ۲�ֵ��');
BC=zeros(n4,1);
for i = 1:n4
    fprintf('\n��%d���߹۲�ֵ',i)
    BC(i)=input('��') ;
end
jiao=zeros(n2,3);
fprintf('�ֱ�����ǵĶ� �� ��')
for i = 1:n2
    fprintf('\n��%d���ǵ�',i)
    jiao(i,1)=input('�ȣ�') ;
    jiao(i,2)=input('�֣�') ;
    jiao(i,3)=input('�룺') ;
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
fprintf('\n���۲�ǵ�˳������۲�ǵ�����վ��ż������߳�')
for i = 1:n2
    fprintf('\n��%d�Ž�',i)
    shuru1(i,1)=input('\nǰվ��ţ�');
    shuru1(i,2)=input('\n�۲�վ�ţ�');
    shuru1(i,3)=input('\n��վ��ţ�');
    shuru1(i,4)=input('\nǰվ�ߵ����(��Ϊ��֪����0)��');
    shuru1(i,5)=input('\n��վ�ߵ����(��Ϊ��֪����0)��');
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
    j=QHzhan(i,1);k=QHzhan(i,2);%�����i���ߵ�ǰ��վ��
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
    fprintf('\n��%d��վ�������Ϊ%d %d',i,ZB(i,1),ZB(i,2))
end
v=B*X-L;
n=n2+n4;
a=sqrt(v'*P*v/(n-t));
Q=zeros(1,n1-1);
for i = 1:length(Q)
   Q(i)=a*sqrt(ni(2*i-1,2*i-1)+ni(2*i,2*i)); 
   fprintf('\n��%d��վ��ľ���Ϊ%d',i,Q(i))
end