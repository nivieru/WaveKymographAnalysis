function [Num_peak,direction]=inputdialog
hfig=figure('CloseRequestFcn',@close_req_fun,'menu','none');
hfig.Position([3,4]) = [220,200];
opt_list={'left->right','right->left'};
defaultans='4';
%set defaults
Num_peak=defaultans;
direction=opt_list{1};
%create GUI
set(hfig,'menu','none')
uicontrol('Style', 'text', 'String', 'Number of waves:', ...
    'Parent',hfig,'Units','Normalized', ...
    'Position', [0, .8, .45, .1]);
field=uicontrol('Style', 'Edit', 'String', Num_peak, ...
    'Parent',hfig,'Units','Normalized', ...
    'Position', [.47, .8, .2, .1]);
uicontrol('Style', 'text', 'String', 'Direction on kymograph:', ...
    'Parent',hfig,'Units','Normalized', ...
    'Position', [0, .55, .6, .1]);
dropdown=uicontrol('Style', 'popupmenu', 'String', opt_list, ...
    'Parent',hfig,'Units','Normalized', ...
    'Position', [.62, .55, .35, .1]);
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
    Num_peak=str2num(field.String);
    direction=dropdown.Value;
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