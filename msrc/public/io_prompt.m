function ret = io_prompt( defaultValue , promptMessage )
%PUBLIC_PROMPT    Ask for the user to input data
%    Input:    default input value, input hint shown to the user
%    Output:    the actual input of the user
%    Author:    Davidaq
%    Date:    2012.1.14
%    Reference:

    if ischar(defaultValue)
        type='s';
        fmt='%s';
    else
        type='n';
        if defaultValue==floor(defaultValue)
            fmt='%d';
        else
            fmt='%f';
        end
    end
    fprintf(strcat('''''i''%s''%s''',fmt,'\n'),promptMessage,type,defaultValue);
    ret=input('');

end