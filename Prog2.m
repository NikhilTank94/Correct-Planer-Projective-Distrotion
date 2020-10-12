clear
clc

img = imread('cise.jpeg');
NumberOfPoints = 4; % input('input no. of pts: ');
% pt = Get2DPoints(img, NumberOfPoints); %[694,990,1000,696;110,176,222,160]; 
% pt = round(pt); 

corr = zeros(size(img),'uint8');
proj_pt = Get2DPoints(corr, NumberOfPoints); %[250 250 350 350; 1000 1250 1250 1000];
proj_pt = round(proj_pt);
% 
% % applying DLT and finging h1 h2 h3 h4 h5 h6 h7 h8, h9=1
% syms h1 h2 h3 h4 h5 h6 h7 h8 
% E1 = pt(1,1)*h1 + pt(2,1)*h2 + h3 - (pt(1,1)*proj_pt(1,1))*h7 - (pt(2,1)*proj_pt(1,1))*h8 - proj_pt(1,1)==0;
% E2 = pt(1,1)*h4 + pt(2,1)*h5 + h6 - (proj_pt(2,1)*pt(1,1))*h7 - (proj_pt(2,1)*pt(2,1))*h8 - proj_pt(2,1)==0;
% E3 = pt(1,2)*h1 + pt(2,2)*h2 + h3 - (pt(1,2)*proj_pt(1,2))*h7 - (pt(2,2)*proj_pt(1,2))*h8 - proj_pt(1,2)==0;
% E4 = pt(1,2)*h4 + pt(2,2)*h5 + h6 - (proj_pt(2,2)*pt(1,2))*h7 - (proj_pt(2,2)*pt(2,2))*h8 - proj_pt(2,2)==0;
% E5 = pt(1,3)*h1 + pt(2,3)*h2 + h3 - (pt(1,3)*proj_pt(1,3))*h7 - (pt(2,3)*proj_pt(1,3))*h8 - proj_pt(1,3)==0;
% E6 = pt(1,3)*h4 + pt(2,3)*h5 + h6 - (proj_pt(2,3)*pt(1,3))*h7 - (proj_pt(2,3)*pt(2,3))*h8 - proj_pt(2,3)==0;
% E7 = pt(1,4)*h1 + pt(2,4)*h2 + h3 - (pt(1,4)*proj_pt(1,4))*h7 - (pt(2,4)*proj_pt(1,4))*h8 - proj_pt(1,4)==0;
% E8 = pt(1,4)*h4 + pt(2,4)*h5 + h6 - (proj_pt(2,4)*pt(1,4))*h7 - (proj_pt(2,4)*pt(2,4))*h8 - proj_pt(2,4)==0;
% 
% Equation = [E1 E2 E3 E4 E5 E6 E7 E8];
% H = solve(Equation, [h1 h2 h3 h4 h5 h6 h7 h8]); %the row matrix in H
% proj_h = [H.h1 H.h2 H.h3; H.h4 H.h5 H.h6; H.h7 H.h8 1]; % projection matrix H
% proj_h = double(proj_h);
% 
% inv_proj_h=inv(proj_h);
% 
% % getting the corrected image
% %corr = imwarp(img,proj_h);
% for z = 1:size(img,3)
% for x = 1:size(img,1)%where x,y are pt in unprojected image
%     for y = 1:size(img,2)
%         B = inv_proj_h*[x; y; 1];
%         B = round(B / (B(3,1)));
%         if (B(1,1)>=1 && B(2,1)>=1 && B(1,1)<=size(img,1) && B(2,1)<=size(img,2)) % to limit the mapping into matrix
%             corr(x,y,z)=img(B(1,1),B(2,1),z); % unprojected pt image
%         end    
%     end
% end
% end
% imshow(corr);




