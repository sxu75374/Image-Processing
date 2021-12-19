%% 1. fixed thresholding
Bridge = readraw('bridge.raw',332,501,1);
Bridge_bw = convert_to_bw(Bridge,128);
figure();
imshow(Bridge_bw/255);
% W11 = writeraw(Bridge_bw, 'Figure 24: Bridge_bw',332,501,1);

%% 2. random thresholding
Bridge_random = random_thresholding(Bridge);
figure();
imshow(Bridge_random/255);
% W12 = writeraw(Bridge_random, 'Figure 24: Bridge_random',332,501,1);

%% 3. dithering matrix
I2 = [1 2; 3 0];
I4 = [4*I2+1 4*I2+2; 4*I2+3 4*I2];
I8 = [4*I4+1 4*I4+2; 4*I4+3 4*I4];
I16 = [4*I8+1 4*I8+2; 4*I8+3 4*I8];
I32 = [4*I16+1 4*I16+2; 4*I16+3 4*I16];

Bridge_dithering_2 = dithering_matrix(Bridge,I2);
figure();
imshow(Bridge_dithering_2/255);
% W13 = writeraw(Bridge_dithering_2, 'Figure 24: Bridge_dithering_2',332,501,1);

Bridge_dithering_8 = dithering_matrix(Bridge,I8);
figure();
imshow(Bridge_dithering_8/255);
% W14 = writeraw(Bridge_dithering_8, 'Figure 24: Bridge_dithering_8',332,501,1);

Bridge_dithering_32 = dithering_matrix(Bridge,I32);
figure();
imshow(Bridge_dithering_32/255);
% W15 = writeraw(Bridge_dithering_32, 'Figure 24: Bridge_dithering_32',332,501,1);
