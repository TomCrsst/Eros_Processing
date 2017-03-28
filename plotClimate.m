function [] = plotClimate(fN)


%fN  = 'Q_seq_c_80_Nyr_20_k_1_a';

if (~strcmp(fN(end-7:end),'.climate') )
    fN = strcat(fN,'.climate');
end

d  = importdata(fN);
Qm = mean(d.data(:,2));

figure
plot(d.data(:,1),d.data(:,2))
hold on
plot([min(d.data(:,1)) max(d.data(:,1))],[Qm Qm])



% plotClimate('Q_seq_c_80_Nyr_20_k_1_a')