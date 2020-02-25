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
        nameF{i-2} = videos(i).name;
        path = fullfile(videos(i).folder,videos(i).name);
        videoObj = VideoReader(path);
        imageArr = readFrame(videoObj);
        image(:,:,i-2) = double(imageArr(:,:,1));
    end
    name = string(nameF);
end

