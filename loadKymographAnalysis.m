function kymAnalysis = loadKymographAnalysis(dirName)
    if ~exist('dirName','var') || isempty(dirName)
        dirName = uigetdir;
    end
    kymAnalysis.dirName = dirName;
    resFile = fullfile(dirName,'results.mat');
    parFile = fullfile(dirName,'parameters.mat');
    ROIFile = fullfile(dirName,'ROI.mat');
    if exist(resFile,'file')
        kymAnalysis.results = load(resFile);
    end
    if exist(parFile,'file')
        kymAnalysis.params = load(parFile);
    end
    if exist(ROIFile,'file')
        kymAnalysis.imROI = load(ROIFile);
    end
end
