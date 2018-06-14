
figure('Name','Réponse fréquentielles des filtres','NumberTitle', 'off', 'rend','painters','pos',[10 200 800 300]);
hold on;

ImpLength = 512;

% Low pass filter
[butter_b, butter_a] = butter(4, cutoff(2, 1));
[hf, ff] = freqz(butter_b, butter_a, ImpLength, 'whole', 1/Tn);

plot( ff(1:ceil(end/2)), 20*log10( abs(hf(1:ceil(end/2)))) );

% Band pass filters
for i = 2:N
    [butter_b, butter_a] = butter(4, [cutoff(1, i), cutoff(2, i)]);
    [hf, ff] = freqz(butter_b, butter_a, ImpLength, 'whole', 1/Tn);
    plot( ff(1:ceil(end/2)), 20*log10( abs(hf(1:ceil(end/2)))) );
end

xlim([0 8000]);
xlabel('Fréquence (Hz)');
ylabel('Amplitude (dB)');
ylim([-20, 3])
grid;




% figure('Name','Réponse fréquentielles des filtres (ordre 10 instable)','NumberTitle', 'off', 'rend','painters','pos',[10 200 800 300]);
% hold on;
% 
% ImpLength = 1024;
% 
% % Low pass filter
% [butter_b, butter_a] = butter(10, cutoff(2, 1));
% [hf, ff] = freqz(butter_b, butter_a, ImpLength, 'whole', 1/Tn);
% 
% plot( ff(1:ceil(end/2)), 20*log10( abs(hf(1:ceil(end/2)))) );
% 
% % Band pass filters
% for i = 2:N
%     [butter_b, butter_a] = butter(10, [cutoff(1, i), cutoff(2, i)]);
%     [hf, ff] = freqz(butter_b, butter_a, ImpLength, 'whole', 1/Tn);
%     plot( ff(1:ceil(end/2)), 20*log10( abs(hf(1:ceil(end/2)))) );
% end
% 
% xlim([0 8000]);
% xlabel('Fréquence (Hz)');
% ylabel('Amplitude (dB)');
% ylim([-20, 3])
% grid;
%     
