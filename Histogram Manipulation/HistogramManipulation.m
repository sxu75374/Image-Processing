% Method A Transfer function histogram manipulation
Toy = readraw('Toy.raw', 400, 560, 1);
figure('NumberTitle', 'off', 'Name', 'Toy.raw');
imshow(Toy/255);

width_toy = 400;
height_toy = 560;

%draw the original histogram
Toy_hist = zeros(1,256);
for i = 1:height_toy
    for j = 1:width_toy
        Toy_hist(1,1+Toy(i,j)) = Toy_hist(1,1+Toy(i,j))+1;%count the frequence
    end
end
figure('NumberTitle', 'off', 'Name', 'Histogram of Frequency of pixels');
bar(Toy_hist);%step 1: obtain histogram
title('Histogram of Frequency of pixels')
xlabel('Intensity Value');
ylabel('Number of Pixels');
figure('NumberTitle', 'off', 'Name', 'Normalized probability histogram');
bar(Toy_hist/(height_toy*width_toy));%step 2: caluculate the normailzed probability histogram 
title('Normalized probability histogram')
xlabel('Intensity Value');
ylabel('Number of Pixels/Total Number of Pixels');

%Caluculate CDF
CDF = zeros(1,256);
Toy_hist_normalizedprob = Toy_hist./(height_toy*width_toy);
CDF(1,1) = Toy_hist_normalizedprob(1,1);
for i = 1:255
    CDF(1,i+1) = CDF(1,i) + Toy_hist_normalizedprob(1,i+1);
end
figure('NumberTitle', 'off', 'Name', 'CDF');
plot(CDF);
title('CDF')
xlim([0 256]);
ylim([0 1]);
xlabel('Intensity Value');
ylabel('Cumulative Probability');

%mapping x
Toy_transfered = [];
Toy_transfered = 255.*CDF();
figure('NumberTitle', 'off', 'Name', 'Transfer function');
plot(Toy_transfered);
title('Transfer function')
xlim([0 256]);
ylim([0 256]);
xlabel('Intensity Value');
ylabel('New Intensity Value for the Same Pixel');

%apply method A on the image
Toy_enhanced_A = zeros(height_toy,width_toy);
for i = 1:height_toy
    for j = 1:width_toy
        Toy_enhanced_A(i,j) = round(Toy_transfered(1,1+Toy(i,j)));
    end
end
figure('NumberTitle', 'off', 'Name', 'Transfer function enhanced image');
imshow(Toy_enhanced_A/255);
W2 = writeraw(Toy_enhanced_A, 'Figure 12: Transfer function enhanced image.raw', 400, 560, 1);

%draw histogram after Method A manipulation
Toy_hist_after_A = zeros(1,256);
for i = 1:height_toy
    for j = 1:width_toy
        Toy_hist_after_A(1,1+Toy_enhanced_A(i,j)) = Toy_hist_after_A(1,1+Toy_enhanced_A(i,j))+1;%count the frequence
    end
end
figure('NumberTitle', 'off', 'Name', 'Histogram of New Frequency of Pixels after applying Transfer Function');
bar(Toy_hist_after_A);%step 1: obtain histogram
title('Histogram of New Frequency of Pixels after applying Transfer Function')
xlabel('Intensity Value');
ylabel('Number of Pixels');

%%
%%% Method B Filling bucket histogram manipulation
Toy = readraw('Toy.raw', 400, 560, 1);
figure('NumberTitle', 'off', 'Name', 'Toy.raw');
imshow(Toy/255);
width_toy = 400;
height_toy = 560;
Size_toy = height_toy*width_toy;
Bucket = Size_toy/256;% =875

%record the index of each entries in order.
Toy_index_B = [];
for i = 0:255
    [x,y] = find(Toy==i);
    z = [x y];
    z(:,3) = i;
    Toy_index_B = [Toy_index_B;z];
end
% fill the bucket
new_mid = [];
Toy_new_value_B = [];
for i = 0:255
    for j = 1:Bucket
        new_mid(:,1) = i;
        Toy_new_value_B = [Toy_new_value_B;new_mid];
    end
end
%index of the enhanced image by method B
Toy_new_index_B = [Toy_index_B(:,1:2) Toy_new_value_B];

%Apply method B
for i = 1:Size_toy
    Toy_enhanced_B(Toy_new_index_B(i,1),Toy_new_index_B(i,2)) = Toy_new_index_B(i,3);
end

figure('NumberTitle', 'off', 'Name', 'filling bucket enhanced image');
imshow(Toy_enhanced_B/255);
W3 = writeraw(Toy_enhanced_B, 'Figure 16: filling bucket enhanced image.raw', 400, 560, 1);

%Histogram of Method B after enhanced
Toy_hist_after_B = zeros(1,256);
for i = 1:height_toy
    for j = 1:width_toy
        Toy_hist_after_B(1,1+Toy_enhanced_B(i,j)) = Toy_hist_after_B(1,1+Toy_enhanced_B(i,j))+1;%count the frequence
    end
end

Toy_cumu_hist_after_B(1,1) = Toy_hist_after_B(1,1);
for i = 2:256
    Toy_cumu_hist_after_B(1,i) = Toy_hist_after_B(1,i) + Toy_cumu_hist_after_B(1,i-1);
end

Toy_cumu_hist_before_B(1,1) = Toy_hist(1,1);
for i = 2:256
    Toy_cumu_hist_before_B(1,i) = Toy_hist(1,i) + Toy_cumu_hist_before_B(1,i-1);
end
figure('NumberTitle', 'off', 'Name', 'Cumulative histogram before applied Method B');
plot(Toy_cumu_hist_before_B);%step 1: obtain histogram
title('Cumulative histogram before applied Method B')
xlim([0 256]);
xlabel('Intensity Value');
ylabel('Number of Pixels');
figure('NumberTitle', 'off', 'Name', 'Cumulative histogram after applied Method B');
plot(Toy_cumu_hist_after_B);%step 1: obtain histogram
title('Cumulative histogram after applied Method B')
xlim([0 256]);
xlabel('Intensity Value');
ylabel('Number of Pixels');
