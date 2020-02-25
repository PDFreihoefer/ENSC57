%%Clearing the workspace
clear all
close all
clc

%%Taking in the videos that we want to process to images
[image, name] = preprocessENSC57('Lighting Images');

%Now we have images for each case and want to establish our costs
opt1 = 29.99+29.99*0.089; %Univivi Lights Cost
opt2 = 52+52*0.089; %CMVision Lights Cost
opt3 = 4.25+4.25*0.089; %IR LED Boards

%With all of this done we can sum the pixel values
j = 0;
k = 0;
l = 0;
dim = size(image);
for i = 1:dim(3)
    if contains(name(i),"Univivi")
       j = j+1;
       sumLightU = sum(sum(image(:,:,i)));
       costPLU(j) = sumLightU/opt1;
    elseif contains(name(i),"CMVision")
       k = k+1;
       sumLightC = sum(sum(image(:,:,i)));
       costPLC(k) = sumLightC/opt2;
    elseif contains(name(i), "IRBoard")
       l = l+1;
       sumLightB = sum(sum(image(:,:,i)));
       costPLB(l) = sumLightB/opt3;
    end
end

%Then we compare costs
