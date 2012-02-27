function point = centralFitting3_getPoint( inFile )
%CENTRALFITTING3_GETPOINT Find the special farterst point
%   Detailed explanation goes here
d = public_urw2dataset(inFile);
[~, ~, ~, h] = size(d);
rp = zeros(1, h); cp = zeros(1, h);
for z = 1: h
    [rp(1, z), cp(1, z)] = find(d(:, :, 1, z));
end
rm = mean(rp); cm = mean(cp);

rpsq = (rp - rm) .* (rp - rm);
cpsq = (cp - cm) .* (cp - cm);

rsq = rpsq + cpsq;
rsqrt = sqrt(rsq);
rsqrt_mean = mean(rsqrt);
rsqrt_std = std(rsqrt);
rsqrt_norm = (rsqrt - rsqrt_mean)/ rsqrt_std;
[~,mi]=min(rsqrt_norm);
point=[cp(1,mi) rp(1,mi) mi];

end