function [] = centralFitting3_histeq_findLevel_test()
    img = imread('F:\IR\image_data\using\1\MR1\1\06255400.png');
    level = centralFitting3_histeq_findLevel(img);
    display(level);
end