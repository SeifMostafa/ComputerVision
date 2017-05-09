function [ I_ED ] = edgeDetector( Type ,I,THRESHOLD )
filterY=zeros(3,3);
filterX=zeros(3,3);
if Type == 0   %sobel
    filterX = [-1 0 1 ; -2 0 2 ; -1 0 1];
    filterY = [1 2 1 ; 0 0 0 ; -1 -2 -1];
elseif Type == 1 %prewitt
    filterX = [-1 0 1 ; -1 0 1 ; -1 0 1];
    filterY = [1 1 1 ; 0 0 0 ; -1 -1 -1];
elseif Type == 2 %roberts
    filterX = [0 1 ; -1 0];
    filterY = [1 0;0 -1];
end
[M,N] = size(I);
I_ED = zeros(M,N);
for i=2:M-1
    for j=2:N-1
       d=sqrt(((sum(sum(double(filterX).* double(I(i-1:i+1,j-1:j+1)))))^2)+((sum(sum(double(filterY).*double(I(i-1:i+1,j-1:j+1)))))^2));
        if d>THRESHOLD
            I_ED(i,j) =1;
        else I_ED(i,j) =0;
        end
    end
end

end




