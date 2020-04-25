function rkym = readKymograph(filename)
info=imfinfo(filename);
Size_info=size(info);
number_of_frames=Size_info(1,1);
w = info(1).Width;
h = info(1).Height;
rkym = zeros(h, w, number_of_frames);
for i=1:number_of_frames
    raw_im = imread(filename,i);
    rkym(:,:,i) = (im2double(raw_im));          %% reading all images
end