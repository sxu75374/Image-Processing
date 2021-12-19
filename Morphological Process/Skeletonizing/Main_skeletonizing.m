% skeletonizing spring
[loop_of_skeletonizing_spring,spring_k] = skeletonizing(spring_normal);
figure();
imshow(spring_k)

% skeletonizing flower
[loop_of_skeletonizing_flower,flower_k] = skeletonizing(flower_normal);
figure();
imshow(flower_k)

% skeletonizing jar
[loop_of_skeletonizing_jar,jar_k] = skeletonizing(jar_normal);
figure();
imshow(jar_k)
