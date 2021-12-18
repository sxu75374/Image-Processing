%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   (1) Shuai Xu           %%%
%%%   (2) 4922836719         %%%
%%%   (3) sxu75374@usc.edu   %%%
%%%   (4) 2/7/2021           %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function recovered_image = median_pad(original_image,dim)

filtersize = 3;
height = length(original_image(:,1,:));
width = length(original_image(1,:,:));
%padding rows
mid = zeros(height+filtersize-1,width,dim);
for d = 1:dim
    for i = 1:(filtersize-1)/2
        for j = 1:width
            mid(i,j,d) = original_image(filtersize+1-i-(filtersize-1)/2,j,d);
        end
    end
    mid((filtersize+1)/2:(filtersize-1)/2+height,:,d) = original_image(:,:,d);
end
for d = 1:dim
    for i = 1:(filtersize-1)/2
        for j = 1:width
            mid(height+(filtersize-1)/2+i,j,d) = mid(height-i+(filtersize-1)/2,j,d);
        end
    end
end

%padding columns
padded_image = zeros(height+filtersize-1,width+filtersize-1,dim);
for d = 1:dim
    for i = 1:height+filtersize-1
        for j = 1:(filtersize-1)/2
            padded_image(i,j,d) = mid(i,filtersize+1-j-(filtersize-1)/2,d);
        end
    end
    padded_image(:,(filtersize+1)/2:(filtersize+1)/2+width-1,d) = mid(:,:,d);
end
for d = 1:dim
    for i = 1:height+filtersize-1
        for j = 1:(filtersize-1)/2
             padded_image(i,width+(filtersize-1)/2+j,d) = padded_image(i,width-j+(filtersize-1)/2,d);
        end
    end
end

height_padded = length(padded_image(:,1,:));
width_padded = length(padded_image(1,:,:));
l = zeros(1,9);
s = zeros(3,3);
nl = zeros(1,9);
height_recovered = height_padded-2;
width_recovered = width_padded-2;

recovered_image = zeros(height_recovered,width_recovered,dim);
for d = 1:dim
    for i = 1:height_padded-2
        for j = 1:width_padded-2
            for m = 1:3
                for n = 1:3
                    s(m,n) = padded_image(i+m-1,j+n-1,d);
                end
            end  
            l(1:9) = s(1:m*n);
            nl(1,:) = sort(l);
            recovered_image(i,j,d) = nl(1,5);
        end
    end
    
    
end

