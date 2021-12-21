% thinning spring
[loop_of_thinning_spring,spring_t] = thinning(spring_normal);
figure();
imshow(spring_t)

% thinning flower
[loop_of_thinning_flower,flower_t] = thinning(flower_normal);
figure();
imshow(flower_t)

% thinning jar
[loop_of_thinning_jar,jar_t] = thinning(jar_normal);
figure();
imshow(jar_t)
