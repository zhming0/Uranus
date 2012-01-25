mr = public_urw2dataset('F:\IR\mr.urw');
ct = public_urw2dataset('F:\IR\res.urw');

[ds_F, ~] = fusion(ct, [], mr, [], 170);



public_dataset2urw('F:\IR\merge.urw', ds_F, []);