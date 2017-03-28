function rep = info_run(dirPath_root)

% Access Eros ouput files for different folder architectures
%
% Input arguments
%
%     dirPath_root   General work directory <string>
%
% Output arguments
%
%     rep     structure storing all variables
%     fN      filename. <string>
%     dP_fN   complete path + filename without extension. <string>
%     Nf      Number of files of one eros extension (*.hum, *.alt, ...) <int>
%
% dev: T. Croissant; croissant.thomas@yahoo.fr
% Last update: 02/2017

% <test> Add '\' at the end of the root path
if (~strcmp(dirPath_root(end),'\'))
    dirPath_root = strcat(dirPath_root,'\');
end

% ADD TEST TO CHECK DIR EXISTENCE

directory   = dir(dirPath_root);                                           % directory properties

    % Case of a single directory
if (directory(3).isdir == 0)
    
    rep.fN    = directory(3).name(1:strfind(directory(3).name,'.0.alt'));  % Get filename
    rep.dP_fN = strcat(dirPath_root,rep.fN);
    
    % Get the number of different file extensions
    n = 3;
    while directory(n).name(length(rep.fN)+1) == '0'
        rep.extf{n-2,1} = directory(n).name(length(rep.fN)+3:end);
        n = n+1;
    end
    
    % Number of files
    rep.Nf  = floor( (length(directory) - 4 - (n - 3))/(n - 3));
    
    [rep.time,rep.dt] = fread_timeVec(rep.dP_fN,rep.Nf);
    
    % Case of a several directories
else
    
    for i = 1:length(directory)-2

        sub_dir      = dir(strcat(dirPath_root,directory(i+2).name));
        
        rep.fN{i}    = sub_dir(3).name(1:strfind(sub_dir(3).name,'.0.alt')); % Get filename
        rep.dP_fN{i} = strcat(dirPath_root,directory(i+2).name,'\',rep.fN{i});
        
        n = 3;
        while sub_dir(n).name(length(rep.fN{i})+1) == '0'
            rep.extf{n-2,i} = sub_dir(n).name(length(rep.fN{i})+3:end);
            n = n+1;
        end
        
        rep.Nf(i) = floor( (length(sub_dir) - 4 - (n - 3))/(n - 3));
        
        [rep.time{i},rep.dt(i)] = fread_timeVec(rep.dP_fN{i},rep.Nf(i));
        
    end
    
end




