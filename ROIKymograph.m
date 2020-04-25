function rs = ROIKymograph(im_mean)
imFig = figure; imagesc(im_mean);
imAx = gca;
title(imAx, 'Select area for analysis');
h = drawrectangle(imAx);
pos = customWait(h);
rMin = max([0,round(pos(1))]);
rMax = min([size(im_mean,2), round(pos(3)+pos(1))]);
rs = rMin:rMax;

