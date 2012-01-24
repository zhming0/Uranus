function path = io_getfile( fileType , title )
%IO_GETFILE Open a file choosing dialog
%    Input:    file type limit (eg. *.urw) , dialog title
%    Output:    the path of the selected file
%    Author:    Davidaq
%    Date:    2012.1.14
%    Reference:
    [fname,dir]=uigetfile(fileType,title);
    path=strcat(dir,fname);
end

