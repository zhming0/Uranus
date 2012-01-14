function [] = public_addpath(msrc_path)
%PUBLIC_addpath    Add recursively the msrc_path into Matlab path list.
%    Input:    A string containing the full path of msrc.
%    Output:    
%    Author:    Tsenmu
%    Date:    2012.01.14
%    Reference:    
	addpath(genpath(msrc_path));
	cd(msrc_path);