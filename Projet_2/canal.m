%----------------------------- CANAL -----------------------------------

%Transposition de la matrice pour avoir k colonnes et M colonnes
Msg_Channel = s1High.';

%Ajout du d�lais dans chaque canal
for i = 1:N
    Msg_Channel_delayed(i,:) = [zeros(1,random_delay(i)) Msg_Channel(i,:) zeros(1,Tb/Tn - random_delay(i))];
end 

%Ajout de l'attenuation au signal decale
Msg_Channel_dimmed =  Msg_Channel_delayed .* alpha_N;
Msg_Channel_sent= sum(Msg_Channel_dimmed,1);

% % Ajout du bruit blanc gaussien au signal attenuation-decale
% Msg_Channel_Noised = awgn(Msg_Channel_dimmed,Eb_No);
% 
% %Sommation des quatres canaux 
% Msg_Channel_sent= sum(Msg_Channel_Noised,1);

% %Exemple canal 1 
% Msg_Channel_1 = Msg_Channel(1,:);
% Msg_Channel_1_dimmed = Msg_Channel_dimmed(1,:);
% Msg_Channel_1_Noised = Msg_Channel_Noised(1,:);
% 
% %Repr�sentation temporelle du signal sur le canal 1
% figure('Name', 'repr�sentation temporelle du signal sur le canal 1');
% plot(linspace(0, len1*Tn, size(Msg_Channel_1.',1)),Msg_Channel_1.');
% ylabel('Amplitude (v)'), xlabel('Times (s)')
% legend('Canal 1');
% grid
% title('Repr�sentation temporelle du signal sur le canal 1')
% 
% %Repr�sentation temporelle du signal sur le canal 1 (retard et attenuation)
% figure('Name', 'repr�sentation temporelle du signal retard�  et att�nu�');
% plot(linspace(0, len1*Tn, size(Msg_Channel_1_dimmed.',1)),Msg_Channel_1_dimmed.');
% ylabel('Amplitude (v)'), xlabel('Times (s)')
% legend('Canal 1');
% grid
% title('Repr�sentation temporelle du signal retard� de 14 bits et att�nu� avec un alphaN de 0.97  ')
% 
% %repr�sentation temporelle du signal de la figure 14 avec ajout du bruit haussier
% figure('Name', 'Repr�sentation temporelle du signal de la figure 14 avec ajout du bruit haussier');
% plot(linspace(0, len1*Tn, size(Msg_Channel_1_Noised.',1)),Msg_Channel_1_Noised.');
% ylabel('Amplitude (v)'), xlabel('Times (s)')
% legend('Canal 1');
% grid
% title('Repr�sentation temporelle du signal de la figure 14 avec ajout du bruit haussier (Eb/No = 30)')
% 
% 
% %Repr�sentation temporelle et fr�quentielle de la somme des differents canaux
% figure('Name', 'Repr�sentation temporelle et fr�quentielle de la somme des differents canaux');
% 
% subplot(2,1,1)
% plot(linspace(0, len1*Tn, size(Msg_Channel_sent.',1)),Msg_Channel_sent.');
% ylabel('Amplitude (v)'), xlabel('Times (s)')
% legend('Addition des canaux');
% grid
% title('Repr�sentation temporelle de la somme des differents canaux')
% 
% subplot(2,1,2)
% semilogy(linspace(0, 1/Tn-1, size(Msg_Channel_sent.',1)), abs(fft(Msg_Channel_sent.'/size(Msg_Channel_sent.',1))).^2)
% ylim([10^-6 10^0])
% ylabel('Puissance (dBm)'), xlabel('Frequency (Hz)')
% legend('Addition des canaux', 'Location', 'North')
% grid
% title('Repr�sentation temporelle de la somme des differents canaux')
% 
