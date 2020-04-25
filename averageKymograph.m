function [im_mean, frames] = averageKymograph(rkym, frames)
if ~exist('frames', 'var')
    implay(rkym./max(rkym(:))) % view kymograph frames
    frames = framesDialog(size(rkym,3)); %select which frames to average
elseif isempty(frames)
    frames = 1:size(rkym,3);
end
im_mean = mean(rkym(:,:,frames),3);