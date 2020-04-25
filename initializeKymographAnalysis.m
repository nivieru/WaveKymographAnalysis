function dirName = initializeKymographAnalysis(filename, parent)
    if ~exist('filename','var') || isempty(filename) || ~isfile(filename)
        [file,folder] = uigetfile('*');
        filename = fullfile(folder, file);
    end
    rkym = readKymograph(filename);
    [im_mean, frames] = averageKymograph(rkym);
    rs = ROIKymograph(im_mean);
    imRoi = im_mean(:,rs);
    [peakPos, direction] = getPeakStart(imRoi);
    dirName = sprintf('%s rs=%d-%d frames=%d-%d peakPos= %s', file, rs(1),rs(end), frames(1), frames(end), sprintf(' %d', round(peakPos)));
    if exist('parent', 'var') && ~isempty(parent)
        dirName = fullfile(parent, dirName);
    end
    mkdir(dirName);
    copyfile(filename, fullfile(dirName,'kymograph.tif'));
    save(fullfile(dirName,'parameters'), 'filename', 'rs', 'frames', 'peakPos', 'direction');
end

