function [] = public_tform2urw(urwpath, tform)
    fp = fopen(urwpath, 'w');
    fwrite(fp, uint8(zeros(1, 5)), 'uint8');
    fwrite(fp, tform);
    fclose(fp);
end