function gaussFit = gaussianFit(y, peakLocs, prevFits,plotFlag)
warning('off','curvefit:cfit:subsasgn:coeffsClearingConfBounds');
L = size(peakLocs,2);
    if L > 10
        startFrom = L - 9;
    else
        startFrom = 1;
    end
muEst = round(mean(peakLocs(1,startFrom:L),'omitnan'));
peakDistEst = round(mean(diff(sort(peakLocs(:,startFrom:length(prevFits)))),'all','omitnan')/2);

x = 1:length(y);
xCut = round(max([1,muEst - peakDistEst/2])):round(min([x(end), muEst + peakDistEst/2]));
yCut = y(xCut);
% nl = noiseLevel(yCut);
% yData = im_mean(:,r)-mean(im_mean(:,r));
% ySub = yCut - nl;
% gaussFit = fit(xCut',ySub,'gauss1');
fitfunc = @(a1,b1,c1, z ,x) z + a1.*exp(-((x-b1)/c1).^2); % gaussian + const

if isempty(prevFits)
    uc1 =  peakDistEst/4;
    lc1 = 0.01; %not sure about that
else
    for i=startFrom:(L-1)
        prevC1(i - startFrom + 1) = prevFits{i}.c1;
    end
    meanC1 = mean(prevC1);
    uc1 = min([meanC1*1.5, peakDistEst/4]); 
    lc1 = meanC1/2;  
end
sz = mean(yCut);
sa1 = yCut(muEst - xCut(1) + 1) - sz;
sb1 = muEst;
sc1 = peakDistEst/8;
startPoint = [sa1, sb1, sc1, sz];
uz = max(yCut);
ua1 = Inf;
ub1 = xCut(end);
upperBound = [ua1, ub1, uc1, uz];
lz = min(yCut);
la1 = -Inf;
lb1 = xCut(1);
lowerBound = [la1, lb1, lc1, lz];
try
    gaussFit = fit(xCut',yCut,fitfunc, 'StartPoint', startPoint, 'upper', upperBound, 'lower', lowerBound);
catch
    warning('can''t fit, using previous fit');
    gaussFit = prevFits{end};
end
nl = gaussFit.z;
gaussFitCenterd = gaussFit;
gaussFitCenterd.z = 0; % zero background;
gaussFitCenterd.b1 = mean([x(1),x(end)]); % move Gaussian to center fit

yGaussFit = gaussFitCenterd(x);
if sum(yGaussFit) == 0
    gaussFit = prevFits{end};
    gaussFitCenterd = gaussFit;
    gaussFitCenterd.z = 0;
    gaussFitCenterd.b1 = mean([x(1),x(end)]);
    yGaussFit = gaussFitCenterd(x);
end

if( exist('plotFlag','var') && plotFlag)
    figure; plot(y);
    hold on; plot(gaussFit);
    plot(smoothed);
    legend('data', 'gaussian fit', 'smoothed');
end
warning('on','curvefit:cfit:subsasgn:coeffsClearingConfBounds');
