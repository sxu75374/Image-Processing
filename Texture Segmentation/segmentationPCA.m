function new = segmentationPCA(original,windowsize,filterbank,pcadim)

height = length(original(:,1));
width = length(original(1,:));
new = zeros(height,width);
filtered_image = zeros(height,width,25);

% filter image by 25 filters, to get a feature set (h*w*25 matrix)
imagesize = 360*575;
count = 1;
image_submean = original;
% image_submean = original - mean(original(:));
for i = 1:5
    for j = 1:5
        pad = padding(image_submean,5);
        a = convolute(pad,filterbank(:,:,count));
        filtered_image(:,:,count) = a;
        count = count+1;
    end
end

pad4window = zeros(height+windowsize-1,width+windowsize-1,25);

for i = 1:25
    pad4window(:,:,i) = padding(filtered_image(:,:,i),windowsize);
end

% G = fspecial('gaussian',[windowsize windowsize],2);
energy = zeros(height*width,25);
for k = 1:25
    c = 0;
    for i = 1+(windowsize-1)/2:height+(windowsize-1)/2
        for j = 1+(windowsize-1)/2:width+(windowsize-1)/2
            c = c+1;
            energy(c,k) = sum(sum(pad4window(i-(windowsize-1)/2:i+(windowsize-1)/2,j-(windowsize-1)/2:j+(windowsize-1)/2,k).^2))/windowsize^2;
        end
    end
end

% normalize
energy = energy./energy(:,1);
feature_vector_24 = zeros(imagesize,24);
feature_vector_24(:,:) = energy(:,2:25);
coef = pca(feature_vector_24,'NumComponents',pcadim);
feature_pca = (feature_vector_24-mean(feature_vector_24))*coef;

% keep pcadimD feature and use kmeans to classify
clas_km = kmeans(feature_pca,5);% coudl change to 8
count = 1;
for i = 1:height
    for j = 1:width
        if clas_km(count,1)==1
            new(i,j) = 0;
        end
        if clas_km(count,1)==2
            new(i,j) = 63;
        end
        if clas_km(count,1)==3
            new(i,j) = 127;
        end
        if clas_km(count,1)==4
            new(i,j) = 191;
        end
        if clas_km(count,1)==5
            new(i,j) = 255;
        end
        % use if we use 8 clusters 
%         if clas_km(count,1)==1
%             new(i,j) = 0;
%         end
%         if clas_km(count,1)==2
%             new(i,j) = 36;
%         end
%         if clas_km(count,1)==3
%             new(i,j) = 72;
%         end
%         if clas_km(count,1)==4
%             new(i,j) = 108;
%         end
%         if clas_km(count,1)==5
%             new(i,j) = 144;
%         end
%         if clas_km(count,1)==6
%             new(i,j) = 180;
%         end
%         if clas_km(count,1)==7
%             new(i,j) = 216;
%         end
%         if clas_km(count,1)==8
%             new(i,j) = 252;
%         end
        count = count+1;
    end
end

end

