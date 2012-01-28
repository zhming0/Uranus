d = public_urw2dataset('C:\Users\acer\Desktop\ct_axis.urw');
[r, c, ~, h] = size(d);
found = false;
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
figure; plot(rsqrt_norm);