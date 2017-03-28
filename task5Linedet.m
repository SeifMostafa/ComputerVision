I = rgb2gray(imread ('/home/azizax/Documents/fci/Second/ComputerVision/Tasks/Hough-LineDetection/lines.jpg'));
I_edgeDetected_byCanny = edge(I,'canny');

[rows, cols] = size(I);

pi=180;
rhomax = sqrt(rows^2 + cols^2);   
ntheta = 18; % theta step by 10
nrho = 30;

matrix_of_R_and_Theta = zeros(ntheta, nrho);
matrix_of_x_values = zeros(ntheta,nrho);
matrix_of_y_values = zeros(ntheta,nrho);

drho =  2*rhomax/(nrho-1);   
dtheta = pi/ntheta;                
theta = 10:+dtheta:pi;
[x,y,s] = find(I_edgeDetected_byCanny);
figure(3)
imshow(I)
hold on
for index = 1:length(s)
            if s(index)  
                   plot(x(index),y(index), 'r.','MarkerSize',50)
                for thetaindex = 1:ntheta
                    rho = x(index)*cos(theta(thetaindex)) + y(index)*sin(theta(thetaindex));
                    rhoindex = round(rho/drho + nrho/2);
        
                    matrix_of_R_and_Theta(thetaindex,rhoindex) = matrix_of_R_and_Theta(thetaindex,rhoindex) + 1;
                    matrix_of_x_values(thetaindex,rhoindex) =x(index);
                    matrix_of_y_values(thetaindex,rhoindex)=y(index);
                end
            end
end
%hold off

ToBeLine = 500;
ToBePeak = 200;
[result_rows,result_cols] =size(matrix_of_R_and_Theta);
figure
imshow(I)
hold on
for i=1:result_rows-1
    for j=1:result_cols-1
       
        if matrix_of_R_and_Theta(i,j)>=ToBeLine
            line(matrix_of_x_values(i,j),matrix_of_y_values(i,j), 'r.','MarkerSize',20)
        end
    end
end

for i=1:result_rows
    for j=1:result_cols
        if matrix_of_R_and_Theta(i,j)>=ToBePeak && matrix_of_R_and_Theta(i,j)<= ToBeLine
            plot(matrix_of_x_values(i,j),matrix_of_y_values(i,j), 'b.','MarkerSize',10)
        end
    end
end
hold off



