function [peakLocs,peakP] = findWavePeaks(y, prevPeaks, initialPeakPos)
meanDist = mean(diff(sort(initialPeakPos))); %distance between peaks
N = length(prevPeaks); % number of waves
if mod(N,2) == 1
    offsets = -floor(N/2):floor(N/2);
else
    offsets = -(N-1)/2:(N-1)/2;
end
approxPos = mean(prevPeaks) + offsets*meanDist; % guess waves position from mean position of waves in the last step and the distance between waves.
peakArea = round(meanDist/2);
for pInd=1:length(prevPeaks)
    if isnan(prevPeaks)
        peakLocs(pInd) = nan;
        peakP(pInd) = nan;
    else
        tCut = max([1,round(approxPos(pInd) - peakArea)]):min([length(y),round( approxPos(pInd) + peakArea)]);
        yCut = y(tCut);
        [pks,locs,w,p] = findpeaks(yCut);
        if(length(pks) == 0)
            peakLocs(pInd) = nan;
            peakP(pInd) = nan;
            warning('can''t find peaks');
        else
            locs = locs + (tCut(1) - 1);
            pksScore = p; %give a scor to each peak based on preominence. We could include a penalty for distance from last step as commented below.
%            pksScore = (p-min(p))./(1+ abs(locs - approxPos(pInd))); % or maybe:
%            pksScore = (p-min(p))./sqrt(1+ abs(locs - approxPos(pInd))); % 
            [SortedPksScore, Isort] = sort(pksScore,'descend' );
            peakLocs(pInd) = locs(Isort(1));
            peakP(pInd) = p(Isort(1));
        end
    end
end
[sortedLocs,I] = sort(peakLocs);
diffLocks = diff(sortedLocs);
Ind = find(diffLocks == 0);
peakLocs(I(Ind)) = nan;
peakP(I(Ind)) = nan;