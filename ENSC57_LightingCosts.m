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
image = double(image);
dim = size(image);

%Let's compare the light to the maximum light we could deliver in the image
%which would be an array of each pixel value being 255. Atleast that is the
%max value for an 8bit integer that we could record.
maxLight = dim(1)*dim(2)*255/100; %Let's move the decimals of our ratio so it's easier to understand from as a ratio.
%Remember that this value matters only in comparision and not using the
%value to calculate anything, so we can alter it slightly to make it
%"aesthetically" pleasing.

for i = 1:dim(3)
    if contains(name(i),"Univivi")
       j = j+1;
       sumLightU = sum(sum(image(:,:,i)));
       costPLU(j) = sumLightU/opt1/maxLight;
    elseif contains(name(i),"CMVision")
       k = k+1;
       sumLightC = sum(sum(image(:,:,i)));
       costPLC(k) = sumLightC/opt2/maxLight;
    elseif contains(name(i), "IRBoard")
       l = l+1;
       sumLightB = sum(sum(image(:,:,i)));
       costPLB(l) = sumLightB/opt3/maxLight;
    end
end

%Then we compare costs to ISO
xISO = [10000,15000,20000];
figure
hold on 
plot(xISO, costPLB)
plot(xISO, costPLC)
plot(xISO, costPLU(1:length(xISO)))
grid on
xlabel('ISO Value')
ylabel('Light/Cost (PV/$)')
legend('IR LED Boards', 'CMVision', 'Univivi')
