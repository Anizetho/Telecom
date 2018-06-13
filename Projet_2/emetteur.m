
%---------------------------- CODE EMETTEUR -------------------------------


%--------------------------- (1) MESSAGE ----------------------------------

% 1.1) G�n�rer le message � transmettre : 
% randi g�n�re une matrice de K lignes et M colonnes contenant des nombres al�atoires 
% entre 0 et 1 distribu�s uniform�ment. Les K lignes repr�sente les canaux.
% Vu qu'un module ne poss�de N caunaux, il peut �mettre sur N canaux.
% Les M colonnes r�pr�sentent la taille M des messages envoy�s par les modules. 
message = randi([0 1], K, Minfo); 

% 1.2) G�n�rer la s�quence de synchronisation : 
% Ms repr�sentent la taille des bits de synchronisation.
leading = ones(K, Mseq);
message = [leading message];

% Graphe du message original (avec s�quence)
figure('Name', 'Message original avec s�quence', 'NumberTitle', 'off', 'rend','painters','pos',[10 200 1200 200]);
hold on;
stem(1:Mseq, message(1, 1:Mseq), ':r');
stem((Mseq+1):M, message(1, (Mseq+1):end), ':b');
axis([0 inf -1.5 1.5]);
hold off;


%----------------------------- (2)CODAGE ----------------------------------

% 2.1) Coder le message
message(message==0) = -1;

% Graphe du message original cod�
figure('Name', 'Message encod�', 'NumberTitle', 'off', 'rend','painters','pos',[10 200 1200 200]);
hold on;
stem(1:Mseq, message(1, 1:Mseq), ':r');
stem((Mseq+1):M, message(1, (Mseq+1):end), ':b');
axis([0 inf -1.5 1.5]);
hold off;


% -------------------------- (3) MODULATION -------------------------------

% shape to impulse
rcos = rcosdesign(rolloff, span, beta);
a = codesymbol(message);
a = upsample(a, beta);
s1 = conv2(rcos, 1, a);
len1 = size(s1, 1);

% les fr�quences des diff�rentes porteuses
carfreq = (0:N-1)'*2/Tb;

% modulate by carriers
t = (0:Tn:(len1-1)*Tn)'*ones(1,N);
%s1High = s1.*cos(2*pi*carfreq'.*t);


% plot impulsions
% figure('Name', 'Repr�sentation', 'NumberTitle', 'off', 'rend','painters','pos',[10 200 1200 200]);
% hold on;
% iX = linspace(0, span/1e2, 1e2*span+1);
% iY = rcosdesign(rolloff, span, 1e2);
% plot(iX, iY' * ones(1, N) .* ...
%      cos(carfreq*linspace(0, 2*pi, span*1e2+1))')
% ylim([-max(iY)*1.1 +max(iY)*1.1])
% title("Representation temporelle des impulsions utilisees")
% ylabel("Coefficient d'amplitude"), xlabel("Temps (s)")
% legend(strcat("Canal ", num2str((1:N)')))
% grid
% clear iX iY

% plot visual representation of the transmission
% subplot(2,1,1)
% stem(linspace(0, len1*Tn, len1), s1High)
% title('Representation temporelle du signal envoye')
% ylabel('Amplitude (v)'), xlabel('Times (s)')
% legend(strcat("Canal ", num2str((1:N)')), 'Location', 'NorthEast')
% grid
% 
% subplot(2,1,2)
% semilogy(linspace(0, 1/Tn-1, len1), abs(fft(s1High/len1)).^2)
% ylim([10^-6 10^0])
% title('Representation frequentielle du signal envoye')
% ylabel('Puissance (dBm)'), xlabel('Frequency (Hz)')
% legend(strcat("Canal ", num2str((1:N)')), 'Location', 'North')
% grid

