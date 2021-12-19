Elephant = readraw('elephant.raw',481,321,3);
Elephant_gray = convert_to_gray(Elephant,481,321);
figure();
imshow(Elephant/255);
figure();
imshow(Elephant_gray/255);

sobel_row = 1/4*[1,0,-1;2,0,-2;1,0,-1];
sobel_col = 1/4*[-1,-2,-1;0,0,0;1,2,1];

Elephant_gray_gradient_row = convolute_pad(Elephant_gray,sobel_row);
Elephant_gray_gradient_row_normalized = normalize(Elephant_gray_gradient_row);
figure('NumberTitle', 'off', 'Name', 'Elephant_x_gradient.raw');
imshow(Elephant_gray_gradient_row_normalized);
% W1 = writeraw(Elephant_gray_gradient_row_normalized.*255, 'Figure 1: Elephant_x_gradient', 481,321,1);

Elephant_gray_gradient_col = convolute_pad(Elephant_gray,sobel_col);
Elephant_gray_gradient_col_normalized = normalize(Elephant_gray_gradient_col);
figure('NumberTitle', 'off', 'Name', 'Elephant_y_gradient.raw');
imshow(Elephant_gray_gradient_col_normalized);
% W2 = writeraw(Elephant_gray_gradient_col_normalized.*255, 'Figure 1: Elephant_y_gradient', 481,321,1);

%use non-normalized Gx Gy
Elephant_sobel_black = sqrt(Elephant_gray_gradient_row.^2+Elephant_gray_gradient_col.^2);
Elephant_sobel_black_normalized = normalize(Elephant_sobel_black);

hist_e = zeros(1,256);
for i =1:321
    for j = 1:481
        hist_e(1,1+round(Elephant_sobel_black_normalized(i,j)*255)) =  hist_e(1,1+round(Elephant_sobel_black_normalized(i,j)*255))+1;
    end
end
%figure();
%plot(hist_e);
cdf_e =zeros(1,256);
histprob_e = hist_e./(321*481);
cdf_e(1,1) = histprob_e(1,1);
for i = 1:255
    cdf_e(1,i+1) = cdf_e(1,i) + histprob_e(1,1+i);
end
figure('NumberTitle', 'off', 'Name', 'Sobel CDF of elephant with threshold 90%');
plot(cdf_e);
title('Sobel CDF of elephant with threshold 90%');
xlim([0 256]);
ylim([0 1]);

figure('NumberTitle', 'off', 'Name', 'Elephant_Sobel_edge255bg0.raw');
imshow(Elephant_sobel_black_normalized);
% W3 = writeraw(Elephant_sobel_black_normalized.*255, 'Figure 3: Elephant_sobel_black_normalized', 481,321,1);

%set sobel threshold
Elephant_sobel_white = 1 - sobel_threshold(Elephant_sobel_black_normalized,0.2745);
figure('NumberTitle', 'off', 'Name', 'Elephant_Sobel_edge0bg255 with thre 0.2745(90%).raw');
imshow(Elephant_sobel_white);
% W4 = writeraw(Elephant_sobel_white.*255, 'Figure 3: Elephant_sobel_white', 481,321,1);


Ski = readraw('ski_person.raw',321,481,3);
Ski_gray = convert_to_gray(Ski,321,481);
figure();
imshow(Ski/255);
figure();
imshow(Ski_gray/255);

Ski_gray_gradient_row = convolute_pad(Ski_gray,sobel_row);
Ski_gray_gradient_row_normalized = normalize(Ski_gray_gradient_row);
figure('NumberTitle', 'off', 'Name', 'Ski_x_gradient.raw');
imshow(Ski_gray_gradient_row_normalized);
% W5 = writeraw(Ski_gray_gradient_row_normalized.*255, 'Figure 4: Ski_x_gradient', 321,481,1);

Ski_gray_gradient_col = convolute_pad(Ski_gray,sobel_col);
Ski_gray_gradient_col_normalized = normalize(Ski_gray_gradient_col);
figure('NumberTitle', 'off', 'Name', 'Ski_y_gradient.raw');
imshow(Ski_gray_gradient_col_normalized);
% W6 = writeraw(Ski_gray_gradient_col_normalized.*255, 'Figure 4: Ski_y_gradient', 321,481,1);

%use non-normalized Gx Gy
Ski_sobel_black = sqrt(abs(Ski_gray_gradient_row).^2+abs(Ski_gray_gradient_col).^2);
Ski_sobel_black_normalized = normalize(Ski_sobel_black);

hist_s = zeros(1,256);
for i =1:481
    for j = 1:321
        hist_s(1,1+round(Ski_sobel_black_normalized(i,j)*255)) =  hist_s(1,1+round(Ski_sobel_black_normalized(i,j)*255))+1;
    end
end
%figure();
%plot(hist_s);
cdf_s =zeros(1,256);
histprob_s = hist_s./(321*481);
cdf_s(1,1) = histprob_s(1,1);
for i = 1:255
    cdf_s(1,i+1) = cdf_s(1,i) + histprob_s(1,1+i);
end
figure('NumberTitle', 'off', 'Name', 'Sobel CDF of ski_person with threshold 90%');
plot(cdf_s);
title('Sobel CDF of elephant with threshold 90%')
xlim([0 256]);
ylim([0 1]);

figure('NumberTitle', 'off', 'Name', 'Ski_Sobel_edge0bg255.raw');
imshow(Ski_sobel_black_normalized);
% W7 = writeraw(Ski_sobel_black_normalized.*255, 'Figure 6: Ski_sobel_black_normalized', 321,481,1);

%set sobel threshold
Ski_sobel_white = 1 - sobel_threshold(Ski_sobel_black_normalized,0.176);
figure('NumberTitle', 'off', 'Name', 'Ski_Sobel_edge0bg255.raw');
imshow(Ski_sobel_white);
% W8 = writeraw(Ski_sobel_white.*255, 'Figure 6: Ski_sobel_white', 321,481,1);
