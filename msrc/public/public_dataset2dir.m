function [] =  public_dataset2dir(dirpath, dataset)
    if(~isdir(dirpath))
        mkdir(dirpath);
    end
    [dirpath,~ ,~] = fileparts(dirpath);
    [~, ~, h] = size(squeeze(dataset));
    for z = 1 : h
        imwrite(dataset(:, :, z), [dirpath,'\',num2str(z, '%d'),'.png'], 'png');
    end
end