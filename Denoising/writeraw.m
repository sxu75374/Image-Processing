%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   (1) Shuai Xu           %%%
%%%   (2) 4922836719         %%%
%%%   (3) sxu75374@usc.edu   %%%
%%%   (4) 2/7/2021           %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function W = writeraw(G, filename, width, height, dim)
	disp([' Save to '  filename ' ...']);
	fid = fopen(filename,'wb');
	G = permute(G, [2 1 3]); 
    Size=(width*height);
    N = [];
    for i = 1:dim
	%store G into 1*dim*width*height matrix N in the order of R-G-B
        N(i:dim:Size*dim) = G(1+(i-1)*Size:(i)*Size);
    end
	W = fwrite(fid, N, 'uchar');
	fclose(fid);
	G = permute(G, [2 1 3]);
end