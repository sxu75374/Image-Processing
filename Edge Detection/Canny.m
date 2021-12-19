Elephant = readraw('elephant.raw',481,321,3);
Elephant_canny_black = edge(Elephant_gray,'Canny',[0.18,0.42]);
figure();
imshow(Elephant_canny_black);
% W9 = writeraw(Elephant_canny_black.*255, 'Figure 8: Elephant_canny_black', 481,321,1);

Ski = readraw('ski_person.raw',321,481,3);
Ski_canny_black = edge(Ski_gray,'Canny',[0.06,0.2]);
figure();
imshow(Ski_canny_black);
% W10 = writeraw(Ski_canny_black, 'Figure 9: Ski_canny_black',321,481,1);
