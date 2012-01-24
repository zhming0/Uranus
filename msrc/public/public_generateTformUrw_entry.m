function public_generateTformUrw_entry()
    inFileName = input('');
    outFileName = input('');
    urwpath = io_prompt('.\Tform.urw', 'Please enter the path of urw to be saved:');
    tform = io_prompt('[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1]', 'Please enter the transform matrix:');
    generateTformUrw(urwpath, tform);
end