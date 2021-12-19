% Floyd
Bridge_ed_Floyd = error_diffusion(Bridge,'Floyd',127);
figure();
imshow(Bridge_ed_Floyd/255);
% W16 = writeraw(Bridge_ed_Floyd, 'Figure 25: Bridge_ed_Floyd',332,501,1);

% JJN
Bridge_ed_JJN = error_diffusion(Bridge,'JJN',127);
figure();
imshow(Bridge_ed_JJN/255);
% W17 = writeraw(Bridge_ed_JJN, 'Figure 25: Bridge_ed_JJN',332,501,1);

% Stucki
Bridge_ed_Stucki = error_diffusion(Bridge,'Stucki',127);
figure();
imshow(Bridge_ed_Stucki/255);
% W18 = writeraw(Bridge_ed_Stucki, 'Figure 25: Bridge_ed_Stucki',332,501,1);
