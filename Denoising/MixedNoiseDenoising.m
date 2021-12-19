%% Remove mixed noise (Salt & Pepper noise + Gaussian noise) of color image
% remove mixed noise of color image
F_color = readraw('Fruits.raw',500,400,3);
figure('NumberTitle', 'off', 'Name', 'Fruits_color.raw');
imshow(F_color/255);

F_color_noisy = readraw('Fruits_noisy.raw',500,400,3);
figure('NumberTitle', 'off', 'Name', 'Fruits_color_noisy.raw');
zzzz = F_color_noisy(:,:,1);
imshow(F_color_noisy/255);

width_fruit = 500;
height_fruit = 400;

%show the noise in three channel by the histogram
dim_color = 3;
Noisy_color = zeros(height_fruit,width_fruit,3); 
Noisy_R = zeros(height_fruit,width_fruit); 
Noisy_G = zeros(height_fruit,width_fruit); 
Noisy_B = zeros(height_fruit,width_fruit); 
Noisy_hist_R = zeros(1,511);%X = S+N (max:255+255)
Noisy_hist_G = zeros(1,511);
Noisy_hist_B = zeros(1,511);
for d = 1:dim_color
    for i = 1:height_fruit
        for j = 1:width_fruit
            Noisy_color(i,j,d) = F_color_noisy(i,j,d)-F_color(i,j,d)+255; %X=S+N
            if d == 1
            Noisy_hist_R(1,1+Noisy_color(i,j,1)) =  Noisy_hist_R(1,1+Noisy_color(i,j,1))+1;
            end
            if d == 2
            Noisy_hist_G(1,1+Noisy_color(i,j,2)) =  Noisy_hist_G(1,1+Noisy_color(i,j,2))+1;
            end
            if d == 3
            Noisy_hist_B(1,1+Noisy_color(i,j,3)) =  Noisy_hist_B(1,1+Noisy_color(i,j,3))+1;
            end
        end
    end
end
%show the distribution histogram of the noise.
figure('NumberTitle', 'off', 'Name', 'Distribution histogram of the noise of channel R');
plot(Noisy_hist_R);
title('Distribution histogram of the noise of channel R')
xlim([0 511]);
figure('NumberTitle', 'off', 'Name', 'Distribution histogram of the noise of channel G');
plot(Noisy_hist_G);
title('Distribution histogram of the noise of channel G')
xlim([0 511]);
figure('NumberTitle', 'off', 'Name', 'Distribution histogram of the noise of channel B');
plot(Noisy_hist_B);
title('Distribution histogram of the noise of channel B')
xlim([0 511]);

filter_uniform_33 = [1/9 1/9 1/9;1/9 1/9 1/9; 1/9 1/9 1/9];
filter_gaussian_33 = [1/16 1/8 1/16;1/8 1/4 1/8;1/16 1/8 1/16];
filter_uniform_55 = [1/25 1/25 1/25 1/25 1/25; 1/25 1/25 1/25 1/25 1/25;1/25 1/25 1/25 1/25 1/25;1/25 1/25 1/25 1/25 1/25;1/25 1/25 1/25 1/25 1/25;];
filter_gaussian_55 = 1/273.*[1 4 7 4 1; 4 16 26 16 4; 7 26 41 26 7;4 16 26 16 4;1 4 7 4 1];


%%%%%%% original cascade sequence: SP-Gaussian %%%%%%%
%%%firstly, remove pepper and salt noise
F_color_denoising_SP = median_pad(F_color_noisy,3);%T=90 better? small:filter harder
figure('NumberTitle', 'off', 'Name', 'F_color_denoising_median');
imshow(F_color_denoising_SP/255);
% W14 = writeraw(F_color_denoising_SP, 'Figure 28: remove impulse noise by Median filter.raw', 500, 400, 3);

%then denoising color image by 33 uniform
F_color_denoising_uniform_33 = zeros(height_fruit,width_fruit,3);
for i =1:3
    F_color_denoising_uniform_33(:,:,i) = convolute_pad(F_color_denoising_SP(:,:,i), filter_uniform_33);
end
figure('NumberTitle', 'off', 'Name', 'F_color_denoising_uniform_33');
imshow(F_color_denoising_uniform_33/255);

%denoising color image by 33 gaussian
F_color_denoising_gaussian_33 = zeros(height_fruit,width_fruit,1);
for i = 1:3
    F_color_denoising_gaussian_33(:,:,i) = convolute_pad(F_color_denoising_SP(:,:,i), filter_gaussian_33);
end
figure('NumberTitle', 'off', 'Name', 'F_color_denoising_gaussian_33');
imshow(F_color_denoising_gaussian_33/255);

%%denoising color image by 33 biliteral
F_color_denoising_biliteral_33 = zeros(height_fruit,width_fruit,1);
for i = 1:3
    F_color_denoising_biliteral_33(:,:,i) = biliteral_pad(F_color_denoising_SP(:,:,i),100,100,3);
end
figure('NumberTitle', 'off', 'Name', 'F_color_denoising_biliteral_33');
imshow(F_color_denoising_biliteral_33/255);

%%denoising color image by 77 biliteral for each channel RGB
F_color_denoising_biliteral_RGB = zeros(height_fruit,width_fruit,1);
for i = 1:3
    F_color_denoising_biliteral_RGB(:,:,i) = biliteral_pad(F_color_denoising_SP(:,:,i),8,25,7);
end
figure('NumberTitle', 'off', 'Name', 'F_color_denoising_biliteral_77_R');
imshow(F_color_denoising_biliteral_RGB/255);

F_color_denoising_mixed_SP = zeros(height_fruit,width_fruit,3);
for i = 1:3
    F_color_denoising_mixed_SP(:,:,i) = F_color_denoising_biliteral_RGB(:,:,i);
end
figure('NumberTitle', 'off', 'Name', 'F_color_denoising_mixed_SP_B77');
imshow(F_color_denoising_mixed_SP/255);
% W15 = writeraw(F_color_denoising_mixed_SP_B, 'Figure 28: Median-7x7 Biliteral.raw', 500, 400, 3);


%%%%%%% inverse cascade sequence: Gaussian-SP %%%%%%%
%first biliteral
F_color_denoising_biliteral_77_RGB = zeros(height_fruit,width_fruit,3);
for i =1:3
    F_color_denoising_biliteral_77_RGB(:,:,i) = biliteral_pad(F_color_noisy(:,:,i),8,25,7);
end

F_color_denoising_biliteral_77_nosp = zeros(height_fruit,width_fruit,3);
for i =1:3
    F_color_denoising_biliteral_77_nosp(:,:,i) = F_color_denoising_biliteral_77_RGB(:,:,i);
end
figure('NumberTitle', 'off', 'Name', 'F_color_denoising_biliteral_77_nosp');
imshow(F_color_denoising_biliteral_77_nosp/255);
% W16 = writeraw(F_color_denoising_biliteral_77_nosp, 'Figure 29: 7x7 Biliteral remove addtive first.raw', 500, 400, 3);

% Then median
F_color_denoising_mixed_B_median = zeros(height_fruit,width_fruit,3);
F_color_denoising_mixed_B_median = median_pad(F_color_denoising_biliteral_77_nosp,3);
figure('NumberTitle', 'off', 'Name', 'F_color_denoising_mixed_B77_median');
imshow(F_color_denoising_mixed_B_median/255);
% W17 = writeraw(F_color_denoising_mixed_B_median, 'Figure 29: 7x7 Biliteral-Median.raw', 500, 400, 3);


%%%%%%% original cascade sequence: SP-NLM %%%%%%%
F_color_denoising_mixed_SP_nlm = zeros(height_fruit,width_fruit,3);
F_denoising_nlm_RGB = zeros(height_fruit,width_fruit,1);
for i =1:3
    F_color_denoising_mixed_SP_nlm(:,:,i) = imnlmfilt(F_color_denoising_SP(:,:,i), 'DegreeOfSmoothing',10,'SearchWindowSize',25,'ComparisonWindowSize',7);
end
figure('NumberTitle', 'off', 'Name', 'F_color_denoising_SP_nlm');
imshow(F_color_denoising_mixed_SP_nlm/255);
% W18 = writeraw(F_color_denoising_mixed_SP_nlm, 'Figure 30: Best result, Median-NLM.raw', 500, 400, 3);


%%%%%%% inverse cascade sequence: NLM-sp %%%%%%%
F_color_denoising_mixed_nlm_nosp = zeros(height_fruit,width_fruit,3);
F_denoising_nlm_RGB_nosp = zeros(height_fruit,width_fruit,3);
for i =1:3
    F_color_denoising_mixed_nlm_nosp(:,:,i) = imnlmfilt(F_color_noisy(:,:,i), 'DegreeOfSmoothing',10,'SearchWindowSize',25,'ComparisonWindowSize',7);
end
figure('NumberTitle', 'off', 'Name', 'F_color_denoising_nlm_nosp');
imshow(F_color_denoising_mixed_nlm_nosp/255);
% W19 = writeraw(F_color_denoising_mixed_nlm_nosp, 'Figure 31: NLM remove addtive first.raw', 500, 400, 3);

%%% then remove impulse
F_color_denoising_mixed_nlm_sp = median_pad(F_color_denoising_mixed_nlm_nosp,3);
figure('NumberTitle', 'off', 'Name', 'F_color_denoising_mixed_nlm_sp');
imshow(F_color_denoising_mixed_nlm_sp/255);
% W20 = writeraw(F_color_denoising_mixed_nlm_sp, 'Figure 31: NLM-Median.raw', 500, 400, 3);
