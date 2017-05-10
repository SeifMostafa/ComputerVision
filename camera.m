%Camera
%[u,v,w]= k.*R.*T.*[x,y,z];         //  general rule
u = [880 43 270 886 745 943];
v = [214 203 197 347 302 128];
x = [312.747 305.796 307.694 310.149 311.937 311.202];
y = [ 309.140 311.649 312.358 307.18 310.105 307.572];
z = [30.086 30.356 30.418 29.298 29.216 30.682];
M = zeros(12,11);
B=zeros(12,1);
k=1;
for i=1 : 6
    M(k,:)= [x(i),y(i),z(i),1,0,0,0,0,-u(i)*x(i),-u(i)*y(i),-u(i)*z(i)];
    M(k+1,:)= [0,0,0,0,x(i),y(i),z(i),1,-v(i)*x(i),-u(i)*y(i),-u(i)*z(i)];
    
    B(k)=u(i);
    B(k+1)=v(i);
    k=k+2;
end
%XX = pinv(M)*B 
XX = (pinv((M'*M))*M')*B;
XX=XX';
XX(12)=1;
KR = zeros(3,4);
k=1;
for i=1:3
    KR(i,:)= XX(k:k+3);
    k=k+4;
end
KR= KR(:,1:3);      % remove last col


r=sqrt((KR(3,3)^2)+(KR(3,2)^2));
c = KR(3,3)/r;
s = KR(3,2)/r;
RX = [1 0 0 ; 0 c s ; 0 -s c ];
KR=KR*RX;
%KR
r=sqrt(KR(3,3)^2+KR(3,1)^2);
c = KR(3,3)/r;
s = KR(3,1)/r;
RY = [0 1 0 ; c 0 s ; -s 0 c ];
KR=KR*RY;
% doesn't 
r=sqrt(KR(3,3)^2+KR(2,1)^2);
c = KR(3,3)/r;
s = KR(2,1)/r;
RZ = [0 0 1 ;c s 0 ; -s c 0 ];
KR=KR*RZ;



