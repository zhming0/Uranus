function public_generateTformUrw_entry()
    inFileName = input('');
    outFileName = input('');
    urwpath = io_prompt('.\Tform.urw', 'Please enter the path of urw to be saved:');
    tform = io_prompt('[0.4972   -0.2722   -0.5375  138.1875;0.2889   -0.6889   -0.1000  174.5000;0.9806    1.0944    0.9875 -272.4375;0 0 0 1]', 'Please enter the transform matrix:');
    public_generateTformUrw(urwpath, tform);
end