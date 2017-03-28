% Creation of *.climate file used as Eros input
%   fN   = Output *.climate filename
%   T    = Time vector
%   Q    = Discharge vector
%   Flag = Type of discharge sequence. 
%       * Flag = 1 type Battlement
%       * Flag = 2 type linear interpolation between Qi
%==========================================================================
function f_write_climate(fN, T, Q, flag)

if (flag == 1)
    Ttmp = zeros(1,2*length(T));
    Ttmp(2:2:end)   = T;
    Ttmp(1:2:end-1) = T;
    Ttmp(1)         = [];
    Ttmp(end)       = [];
    
    Qtmp = zeros(1,2*length(Q));
    Qtmp(2:2:end)   = Q;
    Qtmp(1:2:end-1) = Q;
    Qtmp(end-1:end) = [];
    
    T = Ttmp;
    Q = Qtmp;   
end

out(:,1) = T;
out(:,2) = Q;

if (length(fN) < length('.climate') || ~strcmp(fN(end-7:end),'.climate') )
    fN = strcat(fN,'.climate');
end

hdr = 'flow';
dlmwrite(fN, hdr, 'delimiter', '',   'newline', 'pc');
dlmwrite(fN, out, 'delimiter', '\t', 'precision', 10, '-append');


end