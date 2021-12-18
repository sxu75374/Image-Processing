function G = readraw(filename, width, height, dim)
%readraw - read RAW format grey scale image of square size into matrix G
% Usage:	G = readraw(filename)
    
	disp(['	Retrieving Image ' filename ' ...']);
	% Get file ID for file
	fid=fopen(filename,'rb');

	% Check if file exists
	if (fid == -1)
	  	error('can not open input image file press CTRL-C to exit \n');
	  	pause
	end

	% Get all the pixels from the image
	pixel = fread(fid, inf, 'uchar');

	% Close file
	fclose(fid);

	% Calculate length/width, assuming image is square
	%[width, height]=size(pixel);
	Size=(width*height);
	%N=sqrt(Size);
    %N = ceil(N);
    
	% Construct matrix
	G = zeros(width, height, dim);
    for i = 1:dim
	% Write pixels into matrix
        G(1+(i-1)*Size:(i)*Size) = pixel(i:dim:dim*Size);
    end
	% Transpose matrix, to orient it properly
    %G = reshape(G,width,height,dim);
	%G = G';
    G = permute(G, [2 1 3]);%because it's 3D matrix, use permute to switch 1st & 2nd dimension
end %function
