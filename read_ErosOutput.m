function [eros_Output,HDR] = read_ErosOutput(fN,Ndata)

% Routine to open Eros outputs.
% Based on the read_mixed_csv routine written by gideongfeller
% Dev: T. Croissant
% Last Dev: 09/2016
%==========================================================================
%clear; clc;
%fN        = 'test.txt';
%Ndata     = 10000;

delimiter = '\t';
fid       = fopen(fN,'r');                                                 % Open the file
if(fid < 0); error('File not found...'); end;

Output    = cell(Ndata,1);                                                 % Preallocate a cell array
lineIndex = 1;                                                             % Index of cell to place the next line in
nextLine  = fgetl(fid);                                                    % Read the first line from the file

%--------------------------------------------------------------------------
% Loop to get the Eros output in the variable Output and get the number of
% lines

while ~isequal(nextLine,-1)                                                % Loop while not at the end of the file
    Output{lineIndex} = nextLine;                                          % Add the line to the cell array
    lineIndex = lineIndex+1;                                               % Increment the line index
    nextLine  = fgetl(fid);                                                % Read the next line from the file
end
fclose(fid);                                                               % Close the file

HDR    = textscan(Output{1},'%s','Delimiter',delimiter);
Output = Output(2:lineIndex-1);                                            % Remove empty cells, if needed

%--------------------------------------------------------------------------
% Apply the delimiter

for iLine = 1:lineIndex-2                                                  % Loop over lines
    lineData = textscan(Output{iLine},'%s',...                             % Read strings
        'Delimiter',delimiter);
    lineData = lineData{1};                                                % Remove cell encapsulation
    if strcmp(Output{iLine}(end),delimiter)                                % Account for when the line
        lineData{end+1} = '';                                              % ends with a delimiter
    end
    Output(iLine,1:numel(lineData)) = lineData;                            % Overwrite line data
    %mmm(iLine,1:numel(lineData)) = str2double(lineData); 
end


eros_Output = str2double(Output(1:lineIndex-2,1:26));


end