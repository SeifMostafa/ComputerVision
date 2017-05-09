I = imread ('/home/azizax/Desktop/ps1-input0a.jpg');
%rotI = imrotate(I,-33,'crop');
I_edgeDetected_byCanny = edge(I,'canny');
[M,N]=size(I);
rhomax = ceil(sqrt(M^2 + N^2));  
dtheta=10;
theta=linspace(-90,90,ceil(90/dtheta)+1);  % 1 will be undo later
h=zeros(rhomax*2,length(theta));
[x,y,s] = find(I_edgeDetected_byCanny);
%x=x-1; y=y-1;
THRESHOLD = 10;

imshow(I);
hold on;
for index = 1:size(s)
                for thetaindex = 1:length(theta)
                    rho = round(x(index)*cosd(theta(thetaindex)) + y(index)*sind(theta(thetaindex)));
                    rho = rho +rhomax;
                    h(rho,thetaindex)=h(rho,thetaindex)+1;
                end     
end

for i=1:rhomax*2
    for j=1:length(theta)
        if h(i,j)>THRESHOLD
            h(i,j) = 1;
        else
            h(i,j)=0;
        end 
    end
end

for index = 1:size(s)-1
                for thetaindex = 1:length(theta)
                    rho = round(x(index)*cosd(theta(thetaindex)) + y(index)*sind(theta(thetaindex)));
                    rho = rho +rhomax;
                    if h(rho,thetaindex) == 1
                                              %  line([x(index),y(index)],[x(index+1),y(index+1)]);
                      plot(x(index),y(index),'.r');
                    end
                end     
end
hold off;
