%%%%%% 256 colors convert to 64 colors %%%
F_color = readraw('Fruits.raw',500,400,3);
F_color_noisy = readraw('Fruits_noisy.raw',500,400,3);
width_fruit = 500;
height_fruit = 400;
Size_fruit = height_fruit*width_fruit;
Bucket_fruit = Size_fruit/4;% 

%record the index of each entries in order.
Fruit_index_R = [];
Fruit_new_value_R = zeros(Bucket_fruit,1);
for i = 0:255
    [x,y] = find(F_color(:,:,1)==i);
    z = [x y];
    z(:,3) = i;
    Fruit_index_R = [Fruit_index_R;z];
end

Fruit_new_value_R = [];
for i = 1:4
    a  = 0;
    for j = 1:Bucket_fruit
        a = a + Fruit_index_R(j+(i-1)*Bucket_fruit,3);
    end   
    Fruit_new_value_R(1+(i-1)*Bucket_fruit:(i)*Bucket_fruit,1) = a/Bucket_fruit;
end

%index of the enhanced image by method B
Fruit_new_index_R = [Fruit_index_R(:,1:2) Fruit_new_value_R];

%Apply method B
for i = 1:Size_fruit
    Fruit_reduced_R(Fruit_new_index_R(i,1),Fruit_new_index_R(i,2)) = Fruit_new_index_R(i,3);
end

%record the index of each entries in order.
Fruit_index_G = [];
Fruit_new_value_G = zeros(Bucket_fruit,1);
for i = 0:255
    [x,y] = find(F_color(:,:,2)==i);
    z = [x y];
    z(:,3) = i;
    Fruit_index_G = [Fruit_index_G;z];
end

newvalue = zeros(4,1);
Fruit_new_value_G = [];
for i = 1:4
    a  = 0;
    for j = 1:Bucket_fruit
        a = a + Fruit_index_G(j+(i-1)*Bucket_fruit,3);
    end
    Fruit_new_value_G(1+(i-1)*Bucket_fruit:(i)*Bucket_fruit,1) = a/Bucket_fruit;
end

%index of the enhanced image by method B
Fruit_new_index_G = [Fruit_index_G(:,1:2) Fruit_new_value_G];

%Apply method B
for i = 1:Size_fruit
    Fruit_reduced_G(Fruit_new_index_G(i,1),Fruit_new_index_G(i,2)) = Fruit_new_index_G(i,3);
end


%record the index of each entries in order.
Fruit_index_B = [];
Fruit_new_value_B = zeros(Bucket_fruit,1);
for i = 0:255
    [x,y] = find(F_color(:,:,3)==i);
    z = [x y];
    z(:,3) = i;
    Fruit_index_B = [Fruit_index_B;z];
end

newvalue = zeros(4,1);
Fruit_new_value_B = [];
for i = 1:4
    a  = 0;
    for j = 1:Bucket_fruit
        a = a + Fruit_index_B(j+(i-1)*Bucket_fruit,3);
    end
    Fruit_new_value_B(1+(i-1)*Bucket_fruit:(i)*Bucket_fruit,1) = a/Bucket_fruit;
end

%index of the enhanced image by method B
Fruit_new_index_B = [Fruit_index_B(:,1:2) Fruit_new_value_B];

%Apply method B
for i = 1:Size_fruit
    Fruit_reduced_B(Fruit_new_index_B(i,1),Fruit_new_index_B(i,2)) = Fruit_new_index_B(i,3);
end

% figure('NumberTitle', 'off', 'Name', 'filling bucket enhanced image');
% imshow(Fruit_reduced_R/255);
% 
% figure('NumberTitle', 'off', 'Name', 'filling bucket enhanced image');
% imshow(Fruit_reduced_G/255);
% 
% figure('NumberTitle', 'off', 'Name', 'filling bucket enhanced image');
% imshow(Fruit_reduced_B/255);

Fruit_reduced = zeros(height_fruit,width_fruit,3);
Fruit_reduced(:,:,1) = Fruit_reduced_R(:,:);
Fruit_reduced(:,:,2) = Fruit_reduced_G(:,:);
Fruit_reduced(:,:,3) = Fruit_reduced_B(:,:);
figure('NumberTitle', 'off', 'Name', '64 colors');
imshow(Fruit_reduced/255);
% W21 = writeraw(Fruit_reduced, 'Figure 34: 64 colors.raw', 500, 400, 3);


%%%%% 64 color image oilpainting %%%%%
Fruit_oilpaint_3 = oilpaint_pad(Fruit_reduced,3,3);
figure('NumberTitle', 'off', 'Name', '64 colors 3x3 oil paint filter');
imshow(Fruit_oilpaint_3/255);
% W22 = writeraw(Fruit_oilpaint_3, 'Figure 35: 64 colors 3x3 oil paint.raw', 500, 400, 3);

Fruit_oilpaint_5 = oilpaint_pad(Fruit_reduced,5,3);
figure('NumberTitle', 'off', 'Name', '64 colors 5x5 oil paint filter');
imshow(Fruit_oilpaint_5/255);
% W23 = writeraw(Fruit_oilpaint_5, 'Figure 35: 64 colors 5x5 oil paint.raw', 500, 400, 3);

Fruit_oilpaint_7 = oilpaint_pad(Fruit_reduced,7,3);
figure('NumberTitle', 'off', 'Name', '64 colors 7x7 oil paint filter');
imshow(Fruit_oilpaint_7/255);
% W24 = writeraw(Fruit_oilpaint_7, 'Figure 35: 64 colors 7x7 oil paint.raw', 500, 400, 3);

Fruit_oilpaint_9 = oilpaint_pad(Fruit_reduced,9,3);
figure('NumberTitle', 'off', 'Name', '64 colors 9x9 oil paint filter');
imshow(Fruit_oilpaint_9/255);
% W25 = writeraw(Fruit_oilpaint_9, 'Figure 35: 64 colors 9x9 oil paint.raw', 500, 400, 3);

Fruit_oilpaint_11 = oilpaint_pad(Fruit_reduced,11,3);
figure('NumberTitle', 'off', 'Name', '64 colors 11x11 oil paint filter');
imshow(Fruit_oilpaint_11/255);
% W26 = writeraw(Fruit_oilpaint_11, 'Figure 35: 64 colors 11x11 oil paint.raw', 500, 400, 3);


%%%%% 256 colors convert to 512 colorss
Size_fruit = height_fruit*width_fruit;
Bucket_fruit_512 = floor(Size_fruit/8);% 

%record the index of each entries in order.
Fruit_new_value_R_512 = zeros(Bucket_fruit_512,1);

Fruit_new_value_R_512 = [];
for i = 1:8
    a  = 0;
    for j = 1:Bucket_fruit_512
        a = a + Fruit_index_R(j+(i-1)*Bucket_fruit_512,3);
    end
    Fruit_new_value_R_512(1+(i-1)*Bucket_fruit_512:(i)*Bucket_fruit_512,1) = a/Bucket_fruit_512;
end

%index of the enhanced image by method B
Fruit_new_index_R_512 = [Fruit_index_R(:,1:2) Fruit_new_value_R_512];

%Apply method B
for i = 1:Size_fruit
    Fruit_reduced_R_512(Fruit_new_index_R_512(i,1),Fruit_new_index_R_512(i,2)) = Fruit_new_index_R_512(i,3);
end


%record the index of each entries in order.
Fruit_new_value_G_512 = zeros(Bucket_fruit_512,1);

newvalue = zeros(4,1);

Fruit_new_value_G_512 = [];
for i = 1:8
    a  = 0;
    for j = 1:Bucket_fruit_512
        a = a + Fruit_index_G(j+(i-1)*Bucket_fruit_512,3);
    end
    Fruit_new_value_G_512(1+(i-1)*Bucket_fruit_512:(i)*Bucket_fruit_512,1) = a/Bucket_fruit_512;
end

%index of the enhanced image by method B
Fruit_new_index_G_512 = [Fruit_index_G(:,1:2) Fruit_new_value_G_512];

%Apply method B
for i = 1:Size_fruit
    Fruit_reduced_G_512(Fruit_new_index_G_512(i,1),Fruit_new_index_G_512(i,2)) = Fruit_new_index_G_512(i,3);
end


%record the index of each entries in order.
Fruit_new_value_B_512 = zeros(Bucket_fruit_512,1);

Fruit_new_value_B_512 = [];
for i = 1:8
    a  = 0;
    for j = 1:Bucket_fruit_512
        a = a + Fruit_index_B(j+(i-1)*Bucket_fruit_512,3);
    end
    Fruit_new_value_B_512(1+(i-1)*Bucket_fruit_512:(i)*Bucket_fruit_512,1) = a/Bucket_fruit_512;
end

%index of the enhanced image by method B
Fruit_new_index_B_512 = [Fruit_index_B(:,1:2) Fruit_new_value_B_512];

%Apply method B
for i = 1:Size_fruit
    Fruit_reduced_B_512(Fruit_new_index_B_512(i,1),Fruit_new_index_B_512(i,2)) = Fruit_new_index_B_512(i,3);
end

% figure('NumberTitle', 'off', 'Name', 'filling bucket enhanced image');
% imshow(Fruit_reduced_R_512/255);
% figure('NumberTitle', 'off', 'Name', 'filling bucket enhanced image');
% imshow(Fruit_reduced_G_512/255);
% figure('NumberTitle', 'off', 'Name', 'filling bucket enhanced image');
% imshow(Fruit_reduced_B_512/255);

Fruit_reduced_512 = zeros(height_fruit,width_fruit,3);
Fruit_reduced_512(:,:,1) = Fruit_reduced_R_512(:,:);
Fruit_reduced_512(:,:,2) = Fruit_reduced_G_512(:,:);
Fruit_reduced_512(:,:,3) = Fruit_reduced_B_512(:,:);
figure('NumberTitle', 'off', 'Name', '512 colors');
imshow(Fruit_reduced_512/255);
% W27 = writeraw(Fruit_reduced_512, 'Figure 36: 512 colors .raw', 500, 400, 3);


%%%%% 512 color image oilpainting %%%%%
Fruit_oilpaint_3_512 = oilpaint_pad(Fruit_reduced_512,3,3);
figure('NumberTitle', 'off', 'Name', '512 colors 3x3 oil paint filter');
imshow(Fruit_oilpaint_3_512/255);
% W28 = writeraw(Fruit_oilpaint_3_512, 'Figure 37: 512 colors 3x3 oil paint.raw', 500, 400, 3);

Fruit_oilpaint_5_512 = oilpaint_pad(Fruit_reduced_512,5,3);
figure('NumberTitle', 'off', 'Name', '512 colors 5x5 oil paint filter');
imshow(Fruit_oilpaint_5_512/255);
% W29 = writeraw(Fruit_oilpaint_5_512, 'Figure 37: 512 colors 5x5 oil paint.raw', 500, 400, 3);

Fruit_oilpaint_7_512 = oilpaint_pad(Fruit_reduced_512,7,3);
figure('NumberTitle', 'off', 'Name', '512 colors 7x7 oil paint filter');
imshow(Fruit_oilpaint_7_512/255);
% W30 = writeraw(Fruit_oilpaint_7_512, 'Figure 37: 512 colors 7x7 oil paint.raw', 500, 400, 3);

Fruit_oilpaint_9_512 = oilpaint_pad(Fruit_reduced_512,9,3);
figure('NumberTitle', 'off', 'Name', '512 colors 9x9 oil paint filter');
imshow(Fruit_oilpaint_9_512/255);
% W31 = writeraw(Fruit_oilpaint_9_512, 'Figure 37: 512 colors 9x9 oil paint.raw', 500, 400, 3);

Fruit_oilpaint_11_512 = oilpaint_pad(Fruit_reduced_512,11,3);
figure('NumberTitle', 'off', 'Name', '512 colors 11x11 oil paint filter');
imshow(Fruit_oilpaint_11_512/255);
% W32 = writeraw(Fruit_oilpaint_11_512, 'Figure 37: 512 colors 11x11 oil paint.raw', 500, 400, 3);
