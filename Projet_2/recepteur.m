
%---------------------------- CODE RECEPTEUR -------------------------------

% 1) Calculer la bande passante pour chaque canal
cutoff_normalized = [carfreq-1/Tb carfreq+1/Tb]*2*Tn;
bandwidth = (1+rolloff)/(2*Tb);
cutoff2 = [-bandwidth+carfreq , bandwidth+carfreq] ;
%cutoff_normalized = cutoff2 * (2 * Tn);

% pre-allocate filters matrix
H = zeros(impulseL, N);

% 2) Définir les réponses impulsionnelles des filtres analogiques
% 2.1) pour les filtres passes-bas
[bf,af] = butter(10, cutoff_normalized(1,2));
H(:,1) = ifft(freqz(bf, af, impulseL, 'whole', 1/Tn));

% 2.2) pour les filtres passe-haut
for n = 2:N
    [bf,af] = butter(10, [cutoff_normalized(n,1) cutoff_normalized(n,2)]);
    H(:,n) = ifft(freqz(bf, af, impulseL, 'whole', 1/Tn));
end

% 3) Separation des signaux en réalisant la convolution du signal (canal) avec
% la réponse impulsionnelle de chaque filtre (= chaque canal).
s2High = conv2(Msg_Channel_sent, 1, H);
len2 = size(s2High,1);

% 4) Normalisation
power = sum(s2High.^2, 1)/len2;
ratio = (pwr*1e-3)./power;
s2High = s2High.*sqrt(ratio);

% 5) Demodulation
t = (0:Tn:(len2-1)*Tn)'*ones(1,N);
s2 = s2High.*cos(2*pi*carfreq'.*t);
s2(:,1) = s2High(:,1);
for n = 2:N
    [bf,af] = butter(5, carfreq(n)*2*Tn);
    impulse = ifft(freqz(bf, af, impulseL, 'whole', 1/Tn));
    s2(:,n) = conv(s2(:,n), impulse(1:+1:end), 'same'); % forward
    s2(:,n) = conv(s2(:,n), impulse(end:-1:1), 'same'); % backward
end

s2 = conv2(rcos, 1, s2);
[len3,~] = size(s2);
% find filters delay
[~,i] = max(H);
% compensate the start trame
s2t = zeros(len3,N);
for n = 1:N
    delay = span*beta+i(n)+shift-n;
    s2t(1:len3-delay+1,n) = s2(delay:end,n);
end
% generate the index vector
s2i = 1:beta:beta*size(message,2);
% extract the values at index
decoded = s2t(s2i,:);
% quantize the extracted values
decoded = decoded>0;

% hit markers *PEW* *PEW*
figure, hold on
stem(s2t(:,1))
stem(s2i, s2t(s2i,1), 'r*', 'MarkerSize', 8.0)
grid, hold off

% % plot visual representation of the transmission
% figure
% subplot(2,1,1)
% stem(linspace(0, len2*Tn, len2), s2High)
% title('Representation temporelle du signal recu')
% ylabel('Amplitude (v)'), xlabel('Times (s)')
% legend(strcat("Canal ", num2str((1:N)')), 'Location', 'NorthEast')
% grid
% 
% subplot(2,1,2)
% semilogy(linspace(0, 1/Tn-1, len2), abs(fft(s2High/len2)).^2)
% ylim([10^-6 10^0])
% title('Representation frequentielle du signal recu')
% ylabel('Puissance (dBm)'), xlabel('Frequency (Hz)')
% legend(strcat("Canal ", num2str((1:N)')), 'Location', 'North')
% grid
% 
% 
% 
% % compare the sent signal with the received one
figure
subplot(2,1,1)
stem(linspace(0, len1*Tn, len1), s1(:,1));
title('Signal normalise envoye par l''emetteur')
xlabel('Temps de transmission (s)')
ylabel('Amplitude du signal')
grid

subplot(2,1,2)
len3 = size(s2,1);
stem(linspace(0, len3*Tn, len3), s2(:,1), 'Color', [0.85 0.33 0.1]);
title('Signal recompose dans le receveur')
xlabel('Temps de transmission (s)')
ylabel('Amplitude du signal')
grid

% report QS
% disp("Taux d'erreurs :")
% errorRate = sum(xor(message, decoded))/size(x,1);
% disp(errorRate)