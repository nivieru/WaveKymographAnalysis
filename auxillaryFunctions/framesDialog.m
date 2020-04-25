function frames = framesDialog(TotalFrames)
hfig=figure('CloseRequestFcn',@close_req_fun,'menu','none');
hfig.Position([3,4]) = [220,200];
framesStr=sprintf('1:%d',TotalFrames);

%create GUI
set(hfig,'menu','none')
uicontrol('Style', 'text', 'String', 'Frames to average:', ...
    'Parent',hfig,'Units','Normalized', ...
    'Position', [0, .8, .45, .1]);
field=uicontrol('Style', 'Edit', 'String', framesStr, ...
    'Parent',hfig,'Units','Normalized', ...
    'Position', [.47, .8, .2, .1]);
uicontrol('Style', 'pushbutton', 'String', 'OK', ...
    'Parent',hfig,'Units','Normalized', ...
    'Position', [.1 .1 .35 .2],...
    'Callback','close(gcbf)');
cancel=uicontrol('Style', 'pushbutton', 'String', 'cancel', ...
    'Parent',hfig,'Units','Normalized', ...
    'Position', [.55 .1 .35 .2],...
    'Tag','0','Callback',@cancelfun);
%wait for figure being closed (with OK button or window close)
uiwait(hfig)
%figure is now closing
if strcmp(cancel.Tag,'0')%not canceled, get actual inputs
    frames=str2num(field.String);
end
%actually close the figure
delete(hfig)
end
function cancelfun(h,~)
set(h,'Tag','1')
uiresume
end
function close_req_fun(~,~)
uiresume
end