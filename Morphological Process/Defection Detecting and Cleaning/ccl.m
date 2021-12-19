function [A,link,new] = ccl(pad)

height = length(pad(:,1));
width = length(pad(1,:));
label = pad;
% eqt = zeros(1,1000);
l = 0;
c = 0;
A=zeros();
link = cell(1,200);
for i = 2:height-1
    for j = 2:width-1
        c = c+1;
        if label(i,j)==1
            %check neighbour label
            if (label(i,j-1)==0)&&(label(i-1,j-1)==0)&&(label(i-1,j)==0)&&(label(i-1,j+1)==0)
                l = l+1;
                label(i,j)=label(i,j)+l;
                link{1,label(i,j)} = union(label(i,j), link{1,label(i,j)});
                A(c,1) = label(i,j);
            else
                L=[label(i,j-1),label(i-1,j-1),label(i-1,j),label(i-1,j+1)];
                label(i,j)=min(L(L>0));
                 E = unique([label(i,j-1),label(i-1,j-1),label(i-1,j),label(i-1,j+1),label(i,j)]);
                 lenE = length(E);
                 for k = 1:lenE
                     if E(k) ~= 0
                        link{1,label(i,j)} = union(E(k), link{1,label(i,j)});
                     end
                 end
%                  len = length(E);
                    % check the table
                 for k = 1:lenE
                     A(c,k) = E(1,k);
                 end

            end
        end
    end
end
new = label;
end
                
                
    