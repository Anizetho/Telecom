%----------------------------- CANAL -----------------------------------

%Transposition de la matrice pour avoir k colonnes et M colonnes
Msg_Channel = s1High.';

%Ajout du délais dans chaque canal
for i = 1:K
    Msg_Channel_delayed(i,:) = [zeros(1,random_delay(i)) Msg_Channel(i,:) zeros(1,Tb/Tn - random_delay(i))];
end 

%Ajout de l'atténuation au signal décallé
Msg_Channel_dimmed =  Msg_Channel_delayed .* alpha_N;

% Ajout du bruit blanc gaussien au signal atténué-décallé
Msg_Channel_Noised = awgn(Msg_Channel_dimmed,Eb_No);

%Sommation des quatres canaux 
Msg_Channel_sent= sum(Msg_Channel_Noised,1);

%%%%%Exemple canal 1 
Msg_Channel_1 = Msg_Channel(1,:);
Msg_Channel_1_dimmed = Msg_Channel_dimmed(1,:);
Msg_Channel_1_Noised = Msg_Channel_Noised(1,:);

% plot visual representation of the transmission with delay (one canal)
figure('Name', 'Représentation_canal_1');
subplot(3,1,1)
plot(linspace(0, len1*Tn, size(Msg_Channel_1.',1)),Msg_Channel_1.');
ylabel('Amplitude (v)'), xlabel('Times (s)')
legend('Canal 1');
grid
title('Signal sur chaque canal 1 ')

subplot(3,1,2)
plot(linspace(0, len1*Tn, size(Msg_Channel_1_dimmed.',1)),Msg_Channel_1_dimmed.');
ylabel('Amplitude (v)'), xlabel('Times (s)')
legend('Canal 1');
grid
title('Signal décalé de 14s et attenué sur chaque canal 1 avec un alphaN = 0.97  ')

subplot(3,1,3)
plot(linspace(0, len1*Tn, size(Msg_Channel_1_Noised.',1)),Msg_Channel_1_Noised.');
ylabel('Amplitude (v)'), xlabel('Times (s)')
legend('Canal 1');
grid
title('Ajout du bruit blanc Gaussien AWGN n(t) sur chaque canal 1 [Eb/No = 30]')

figure('Name', 'Somme des différents canaux');

subplot(2,1,1)
plot(linspace(0, len1*Tn, size(Msg_Channel_sent.',1)),Msg_Channel_sent.');
ylabel('Amplitude (v)'), xlabel('Times (s)')
legend('Addition des canaux');
grid
title('Somme des différents canaux dans le domaine temporel')

subplot(2,1,2)
semilogy(linspace(0, 1/Tn-1, size(Msg_Channel_sent.',1)), abs(fft(Msg_Channel_sent.'/size(Msg_Channel_sent.',1))).^2)
ylim([10^-6 10^0])
title('Somme des différents canaux dans le domaine fréquentiel')
ylabel('Puissance (dBm)'), xlabel('Frequency (Hz)')
legend('Addition des canaux', 'Location', 'North')
grid



