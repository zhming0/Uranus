function [] = public_dicomrewrite(sourceDir, targetDir, WindowSelection)
%PUBLIC_DICOMREWRITE    Translate dicom files from source directory to
%                       png in target directory.
%    Input:    Source directory, target directory, windowSelection.
%    Output:    png files.
%    Author:    Tsenmu
%    Date:    2012.01.12
%    Reference:    

	
	if(1)
		d = dir;
		find = 0;
		len = length(d);
		for i = 1 : len
			if(~d(i).isdir)
				continue;
			end
			if (strcmp(d(i).name,targetDir) == 1)
				find = 1;
				break;
			end
		end
		if(find == 0)
			mkdir(targetDir);
		end
	end
	cd(sourceDir);
	directoryVector = dir();
	len = length(directoryVector);
	cd ..;
	if(nargin == 2)
        WindowSelection = 1;
	end
	for i = 1 : len
		cd(sourceDir);
		obj = directoryVector(i);
		if(~obj.isdir)
			img = public_dicom2gray(obj.name, WindowSelection);
			cd ..;
			cd(targetDir);
			fn = java.lang.String(obj.name);
			nfn = java.lang.String('');
			if (fn.endsWith('.dcm'))
				pos = fn.length() - 4;
					if (pos >= 1)
						nfn = fn.substring(0, pos);
					nfn = nfn.concat('.png');
					end
				else
				nfn = fn.concat('.png');
				end
				nfilename = char(nfn);
		imwrite(img, nfilename, 'png');
		end
	cd ..
	end
	
	
	
	
		