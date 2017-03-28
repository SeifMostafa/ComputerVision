function [ idx ] = findClosest( ColVec , ref )
max=10000;
ref
for ii = 1:length(ColVec)
    
     if abs(ColVec(1,ii) - abs(ref)) < max
             max=abs(ColVec(1,ii) - abs(ref)) ;
             idx=ii;
     end
end
end

