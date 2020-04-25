function [peakPos, direction] = getPeakStart(imRoi)
[Num_peak,direction] = inputdialog;
if direction == 1
    x = 2;
else
    x = size(imRoi,2) - 2;
end
% close(imFig);
% delete(h);
drawingArea = [x, 1, 1, size(imRoi,1)];
figure; imagesc(imRoi);
imAx = gca;
hold(imAx, 'on');
for pInd = 1:Num_peak % mark beginings of wavefronts
    title(imAx, sprintf('place begining of wave #%d and double click it', pInd));
    h = drawpoint(imAx, 'DrawingArea', drawingArea);
    pos = customWait(h);
    h.InteractionsAllowed = 'none';
    scatter(h.Position(1), h.Position(2), 'filled')
    peakPos(pInd) = pos(2);
end
peakPos = sort(peakPos);