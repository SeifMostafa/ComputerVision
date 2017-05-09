function [ D ] = subs( A,B )
s = size(A);
for ii=1:s(1)
  for jj=1:s(2)
    D{ii,jj} = A{ii,jj} - B{ii,jj};
  end
end
end

