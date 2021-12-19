function filtered_image = convolute_pad(original_image,filter)

height = length(original_image(:,1));
width = length(original_image(1,:));
filtersize = length(filter(1,:));
%padding rows
mid = zeros(height+filtersize-1,width);
for i = 1:(filtersize-1)/2
    for j = 1:width
        mid(i,j) = original_image(filtersize+1-i-(filtersize-1)/2,j);
    end
end
mid((filtersize+1)/2:(filtersize-1)/2+height,:) = original_image(:,:);
for i = 1:(filtersize-1)/2
    for j = 1:width
        mid(height+(filtersize-1)/2+i,j) = mid(height-i+(filtersize-1)/2,j);
    end
end

%padding columns
padded_image = zeros(height+filtersize-1,width+filtersize-1);
for i = 1:height+filtersize-1
    for j = 1:(filtersize-1)/2
        padded_image(i,j) = mid(i,filtersize+1-j-(filtersize-1)/2);
    end
end
padded_image(:,(filtersize+1)/2:(filtersize+1)/2+width-1) = mid(:,:);
for i = 1:height+filtersize-1
    for j = 1:(filtersize-1)/2
         padded_image(i,width+(filtersize-1)/2+j) = padded_image(i,width-j+(filtersize-1)/2);
    end
end

% convolution part
height_padded = length(padded_image(:,1));
width_padded = length(padded_image(1,:));
height_filter = length(filter(:,1));%number of the rows of the filter
width_filter = length(filter(1,:));%number of the columns of the filter
height_recovered = height_padded-height_filter+1;
width_recovered = width_padded-width_filter+1;

filtered_image = zeros(height_recovered,width_recovered);
for i = 1:height_padded-height_filter+1
    for j = 1:width_padded-width_filter+1
        for m = 1:height_filter
            for n = 1:width_filter
                 filtered_image(i,j) = filtered_image(i,j) + padded_image(i+m-1,j+n-1)*filter(m,n);
            end
        end
    end
end
end