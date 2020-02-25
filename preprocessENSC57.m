function [image, name] = preprocessENSC57(videodir)
%Preprocessing our video files and creating images that we can analyze for
%other useful information. For this project we are using monochromatic
%cameras which means that the three channels of the image file (RGB) will
%all be the same. So we also want to ignore that information because it's
%unnecessary and we will be able to run the code faster.

%Given the directory we need to read it and all of the videos inside
videos = dir(videodir);
nameF = {};
    for i = 3:length(videos)
        %This gives us the file names if we want to use that later
        nameF{i-2} = videos(i).name;
        %This is the actual path to each video
        path = fullfile(videos(i).folder,videos(i).name);
        %We read the image using MATLAB
        videoObj = VideoReader(path);
        %Now we take the very first frame and create an array of values
        %that represent the image in MATLAB.
        imageArr = readFrame(videoObj);
        %imageArr is a nxnx3 array. The 3rd dimension represents the
        %channels of the image (RGB). However, in our case we are using a
        %monochromatic camera, so we will only take 1 channel because they
        %all are equal. Doing this might speed up/make analysis of many
        %images easier.
        image(:,:,i-2) = imageArr(:,:,1);
    end
    name = string(nameF);
end

