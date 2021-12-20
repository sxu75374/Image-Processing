%% texture segmentation
composite = double(imread('composite.png'));
figure()
imshow(composite/255)
r = segmentation(composite,5,filterbank);
figure('Name','25D')
%W1 = writeraw(r, 'Figure 10: segmentation with 25D feature.raw', 575, 360, 1);
imshow(r/255)
  
% pca segmentation
r2 = segmentationPCA(composite,5,filterbank,3);
figure('Name','3D')
%W2 = writeraw(r, 'Figure 11: segmentation with PCA3.raw',  575, 360, 1);
imshow(r2/255)

r3 = segmentationPCA(composite,5,filterbank,7);
figure('Name','7D')
%W3 = writeraw(r, 'Figure 13: segmentation with PCA7.raw',  575, 360, 1);
imshow(r3/255)
