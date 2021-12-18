%% remove the noise of gray image by Gaussian & Uniform filter
%load the image
F = readraw('Fruits_gray.raw',500,400,1);
figure('NumberTitle', 'off', 'Name', 'Fruits_gray.raw');
imshow(F/255);
F_noisy = readraw('Fruits_gray_noisy.raw',500,400,1);
figure('NumberTitle', 'off', 'Name', 'Fruits_gray_noisy.raw');
imshow(F_noisy/255);

width_fruit = 500;
height_fruit = 400;
Size_fruit = height_fruit*width_fruit;
Noisy = zeros(height_fruit,width_fruit); 
Noisy_hist = zeros(1,511);%X = S+N (max:255+255)
for i = 1:height_fruit
    for j = 1:width_fruit
        Noisy(i,j) = F_noisy(i,j)-F(i,j)+255; %X=S+N
        Noisy_hist(1,1+Noisy(i,j)) =  Noisy_hist(1,1+Noisy(i,j))+1;
    end
end
%distribution histogram of the noise.
figure('NumberTitle', 'off', 'Name', 'Distribution histogram of the noise');
plot(Noisy_hist);
title(' Distribution histogram of the noise')
xlim([0 511]);

%filter
filter_uniform_33 = [1/9 1/9 1/9;1/9 1/9 1/9; 1/9 1/9 1/9];
filter_gaussian_33 = [1/16 1/8 1/16;1/8 1/4 1/8;1/16 1/8 1/16];
filter_uniform_55 = [1/25 1/25 1/25 1/25 1/25; 1/25 1/25 1/25 1/25 1/25;1/25 1/25 1/25 1/25 1/25;1/25 1/25 1/25 1/25 1/25;1/25 1/25 1/25 1/25 1/25;];
filter_gaussian_55 = 1/273.*[1 4 7 4 1; 4 16 26 16 4; 7 26 41 26 7;4 16 26 16 4;1 4 7 4 1];

%%%apply 3*3 filter to denoising
% 3x3 uniform
F_denoising_uniform_33 = convolute_pad(F_noisy, filter_uniform_33);
figure('NumberTitle', 'off', 'Name', 'Denoising image by 3*3 Uniform filter');
imshow(F_denoising_uniform_33/255);
% W4 = writeraw(F_denoising_uniform_33, 'Figure 20: Denoising image by 3*3 Uniform filter.raw', 500, 400, 1);

% 3x3 gaussian
F_denoising_gaussian_33 = convolute_pad(F_noisy, filter_gaussian_33);
figure('NumberTitle', 'off', 'Name', 'Denoising image by 3*3 Gaussian filter');
imshow(F_denoising_gaussian_33/255);
% W5 = writeraw(F_denoising_gaussian_33, 'Figure 21: Denoising image by 3*3 Gaussian filter.raw', 500, 400, 1);

%%%5*5 filter denoising
% 5x5 uniform
F_denoising_uniform_55 = convolute_pad(F_noisy,filter_uniform_55);
figure('NumberTitle', 'off', 'Name', 'Denoising image by 5*5 Uniform filter');
imshow(F_denoising_uniform_55/255);
% W6 = writeraw(F_denoising_uniform_55, 'Figure 22: Denoising image by 5*5 Uniform filter.raw', 500, 400, 1);

% 5x5 gaussian
F_denoising_gaussian_55 = convolute_pad(F_noisy,filter_gaussian_55);
figure('NumberTitle', 'off', 'Name', 'Denoising image by 5*5 Gaussian filter');
imshow(F_denoising_gaussian_55/255);
% W7 = writeraw(F_denoising_gaussian_55, 'Figure 23: Denoising image by 5*5 Gaussian filter.raw', 500, 400, 1);


%% remove the noise of gray image by Biliteral filter
% biliteral 
F_denoising_biliteral_3 = biliteral_pad(F_noisy,10,10,3);
figure('NumberTitle', 'off', 'Name', 'Denoising image by biliteral filter3');
% W8 = writeraw(F_denoising_biliteral_3, 'Figure 25: Denoising image by 3x3 biliteral filter.raw', 500, 400, 1);
imshow(F_denoising_biliteral_3/255);

F_denoising_biliteral_5 = biliteral_pad(F_noisy,8,25,5);%10 10
figure('NumberTitle', 'off', 'Name', 'Denoising image by 3x3 biliteral filter');
imshow(F_denoising_biliteral_5/255);
% W9 = writeraw(F_denoising_biliteral_5, 'Figure 25: Denoising image by 5x5 biliteral filter.raw', 500, 400, 1);


F_denoising_biliteral_7 = biliteral_pad(F_noisy,8,25,7);
figure('NumberTitle', 'off', 'Name', 'Denoising image by biliteral filter7');
imshow(F_denoising_biliteral_7/255);
% W10 = writeraw(F_denoising_biliteral_7, 'Figure 25: Denoising image by 7x7 biliteral filter.raw', 500, 400, 1);


F_denoising_biliteral_9 = biliteral_pad(F_noisy,8,25,9);
figure('NumberTitle', 'off', 'Name', 'Denoising image by biliteral filter9');
imshow(F_denoising_biliteral_9/255);
% W11 = writeraw(F_denoising_biliteral_9, 'Figure 25: Denoising image by 9x9 biliteral filter.raw', 500, 400, 1);

F_denoising_biliteral_11 = biliteral_pad(F_noisy,8,25,11);
figure('NumberTitle', 'off', 'Name', 'Denoising image by biliteral filter11');
imshow(F_denoising_biliteral_11/255);
% W12 = writeraw(F_denoising_biliteral_11, 'Figure 25: Denoising image by 11x11 biliteral filter.raw', 500, 400, 1);



%% remove the noise of gray image by Non-Local Means filter
% Non-local Means
F_noisy = readraw('Fruits_gray_noisy.raw',500,400,1);
F_denoising_nlm = imnlmfilt(F_noisy, 'DegreeOfSmoothing',10,'SearchWindowSize',21,'ComparisonWindowSize',5);% 10 21 5
figure('NumberTitle', 'off', 'Name', 'Denoising image by NLM');
imshow(F_denoising_nlm/255);
% W13 = writeraw(F_denoising_nlm, 'Figure 26: Denoising image by NLM.raw', 500, 400, 1);
