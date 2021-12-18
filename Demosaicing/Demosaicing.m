G = readraw('House.raw',580,440,1);
figure('NumberTitle', 'off', 'Name', 'House.raw');
imshow(G/255);

width = 580;
height = 440;
dim = 3;

%%mirror reflection padding
G_mid = [];
G_expand = [];
G_mid(1,:) = G(2,:);
G_mid(2:height+1,:) = G(:,:);
G_mid(height+2,:) = G(height-1,:);

G_expand(:,1) = G_mid(:,2);
G_expand(:,2:width+1) = G_mid(:,:);
G_expand(:,width+2) = G_mid(:,width-1);

New_rawg = zeros(height,width);

%New raw Green pixel
for i = 3:2:height+1
    for j = 2:2:width
        New_rawg(i-2,j-1) = G_expand(i-1,j);%green in odd row
        New_rawg(i-1,j) = G_expand(i,j+1);%green in even row
        New_rawg(i-1,j-1) = (G_expand(i-1,j)+G_expand(i+1,j)+G_expand(i,j-1)+G_expand(i,j+1))/4;%for the missing Green in Blue pixel
        New_rawg(i-2,j) = (G_expand(i-2,j+1)+G_expand(i,j+1)+G_expand(i-1,j)+G_expand(i-1,j+2))/4;%New_raw()%missing green in red pixel
    end
end
New_rawb = zeros(height,width);
%New raw Blue pixel
for i = 3:2:height+1
    for j = 2:2:width
        New_rawb(i-1,j-1) = G_expand(i,j);%blue in old pic
        New_rawb(i-2,j-1) = (G_expand(i-2,j)+G_expand(i,j))/2;%for the missing Blue in Green pixel, blue is on the up and down
        New_rawb(i-1,j) = (G_expand(i,j)+G_expand(i,j+2))/2;%missing Blue in green pixel, blue is on the left and right
        New_rawb(i-2,j) = (G_expand(i-2,j)+G_expand(i-2,j+2)+G_expand(i,j)+G_expand(i,j+2))/4;%missing Blue in red pixel.
    end
end
New_rawr = zeros(height,width);
%New raw Red pixel
for i = 3:2:height+1
    for j = 2:2:width
        New_rawr(i-2,j) = G_expand(i-1,j+1);%red in old pic
        New_rawr(i-1,j) = (G_expand(i-1,j+1)+G_expand(i+1,j+1))/2;%for the missing Red in Green pixel, red is on the up and down
        New_rawr(i-2,j-1) = (G_expand(i-1,j-1)+G_expand(i-1,j+1))/2;%missing Red in green pixel, red is on the left and right
        New_rawr(i-1,j-1) = (G_expand(i-1,j-1)+G_expand(i-1,j+1)+G_expand(i+1,j-1)+G_expand(i+1,j+1))/4;%missing red in blue pixel.
    end
end
New_raw_image = zeros(height,width,dim);
New_raw_image(:,:,1) = New_rawr(:,:);
New_raw_image(:,:,2) = New_rawg(:,:);
New_raw_image(:,:,3) = New_rawb(:,:);
W = writeraw(New_raw_image, 'Figure 3: demosaicing.raw', 580, 440, 3);
A = readraw('Figure 3: demosaicing.raw',580,440,3);
figure('NumberTitle', 'off', 'Name', 'demosaiced_image.raw');
imshow(A/255);
B = readraw('House_ori.raw',580,440,3);
figure('NumberTitle', 'off', 'Name', 'House_ori.raw');
imshow(B/255);
