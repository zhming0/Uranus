function io_progress( progress , total )
%IO_PROGRESS displays the progress of the current running process
%    Input:    a number from 0.0~1.0.
%    Output:    
%    Author:    DavidAQ
%    Date:    2012.01.24
%    Reference:  

if(nargin>1)
    progress=double(progress)/double(total);
end

try
    lst=evalin('caller','io_progress_lst');
catch
    assignin('caller','io_progress_lst',0);
    lst=0;
end
if(abs(progress-lst)>0.05)
    fprintf('''''p''%f\n',progress);
    assignin('caller','io_progress_lst',progress);
end

end

