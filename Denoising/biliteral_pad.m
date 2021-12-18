function denoised_image = biliteral_pad(original_image,sigma_c,sigma_s,filter_size)



height = length(original_image(:,1));
width = length(original_image(1,:));
%padding rows
mid = zeros(height+filter_size-1,width);
for i = 1:(filter_size-1)/2
    for j = 1:width
        mid(i,j) = original_image(filter_size+1-i-(filter_size-1)/2,j);
    end
end
mid((filter_size+1)/2:(filter_size-1)/2+height,:) = original_image(:,:);
for i = 1:(filter_size-1)/2
    for j = 1:width
        mid(height+(filter_size-1)/2+i,j) = mid(height-i+(filter_size-1)/2,j);
    end
end

%padding columns
expanded_image = zeros(height+filter_size-1,width+filter_size-1);
for i = 1:height+filter_size-1
    for j = 1:(filter_size-1)/2
        expanded_image(i,j) = mid(i,filter_size+1-j-(filter_size-1)/2);
    end
end
expanded_image(:,(filter_size+1)/2:(filter_size+1)/2+width-1) = mid(:,:);
for i = 1:height+filter_size-1
    for j = 1:(filter_size-1)/2
         expanded_image(i,width+(filter_size-1)/2+j) = expanded_image(i,width-j+(filter_size-1)/2);
    end
end


% biliteral
height_pad = length(expanded_image(:,1));
width_pad = length(expanded_image(1,:));

denoised_image_pad = zeros(height_pad,width_pad);
for i = (filter_size+1)/2:height_pad-(filter_size-1)/2
    for j = (filter_size+1)/2:width_pad-(filter_size-1)/2
        x1 = 0;
        x2 = 0;
        for k = i-(filter_size-1)/2:i+(filter_size-1)/2
            for l = j-(filter_size-1)/2:j+(filter_size-1)/2
                w = exp((-(i-k)^2-(j-l)^2)/(2*sigma_c^2)-((abs(expanded_image(i,j)-expanded_image(k,l)))^2)/(2*sigma_s^2));
                %if k == i && l == j 
                %    w = 0;
                %end
                x1 = x1 + expanded_image(k,l)*w;
                x2 = x2 + w;
            end
        end
        denoised_image_pad(i-(filter_size-1)/2,j-(filter_size-1)/2) = x1/x2;
    end
end

denoised_image(:,:) = denoised_image_pad(1:height,1:width);

end