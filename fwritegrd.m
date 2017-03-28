function fwritegrd(grd,cz,fN)

% write a GRD file
%
% Input arguments
%
%     rst   data raster (elevation, discharge, water depth, ...)
%     cz    cell size
%     fN    file name
%
% Last update: 02/2017

% Open file
IN = fopen(fN,'wb');
if IN == -1
    error('Unable to open the requested file')
end

[sizeX,sizeY] = size(grd);

% Write header

fwrite(IN,'DSBB','char');
fwrite(IN,size(grd),'short');
fwrite(IN,0,'double');
fwrite(IN,(sizeX-1)*cz,'double');
fwrite(IN,0,'double');
fwrite(IN,(sizeY-1)*cz,'double');
fwrite(IN,min(min(grd)),'double');
fwrite(IN,max(max(grd)),'double');

% Write data
fwrite(IN,grd,'float');

fclose(IN);