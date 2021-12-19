Fish = readraw('fish.raw',640,426,3);
figure();
imshow(Fish/255);
Fish_cmy = convert_to_cmy(Fish);
figure();
imshow(Fish_cmy/255);

%%%%%%%% Separate Error Diffusion %%%%%%%%
Fish_Floyd_c = error_diffusion(Fish_cmy(:,:,1),'Floyd',127);
Fish_Floyd_m = error_diffusion(Fish_cmy(:,:,2),'Floyd',127);
Fish_Floyd_y = error_diffusion(Fish_cmy(:,:,3),'Floyd',127);

Fish_Floyd_cmy(:,:,1) = Fish_Floyd_c;
Fish_Floyd_cmy(:,:,2) = Fish_Floyd_m;
Fish_Floyd_cmy(:,:,3) = Fish_Floyd_y;
Fish_Floyd = convert_to_cmy(Fish_Floyd_cmy);
figure();
imshow(Fish_Floyd/255);
% W19 = writeraw(Fish_Floyd, 'Figure 26: Fish_Floyd',640,426,1);


% Fish_Floyd_r = error_diffusion(Fish(:,:,1),'Floyd',127);
% Fish_Floyd_g = error_diffusion(Fish(:,:,2),'Floyd',127);
% Fish_Floyd_b = error_diffusion(Fish(:,:,3),'Floyd',127);
% Fish_Floyd_rgb(:,:,1) = Fish_Floyd_r;
% Fish_Floyd_rgb(:,:,2) = Fish_Floyd_g;
% Fish_Floyd_rgb(:,:,3) = Fish_Floyd_b;
% figure();
% imshow(Fish_Floyd_rgb/255);

%%%%%%%% MBVQ-based Error Diffusion %%%%%%%%
test = MBVQ(Fish);
figure();
imshow(test/255);
W20 = writeraw(test, 'Figure 27: MBVQ—based Error Diffusion',640,426,1);
