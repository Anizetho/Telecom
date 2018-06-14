
% Message
Minfo = 90;         % Taille message à transmettre [en bits]
Mseq = 10;          % Taille de la séquence de synchronisation 
M = Minfo + Mseq;   % Taille des messages envoyés 

% Systeme 
K = 4;           % Nombre de modules 
N = 4;           % Nombre de canaux
R = 10;          % Débit binaire [en bits / s]
Tb = 1 / R;      % La durée d'un seul bit [en s / bit]

% Emetteur
rolloff = 0.40;  % Facteur de rolloff (varie entre 0 et 1)
beta = 4*N;      % Facteur de sur-échantillonnage
Tn = Tb/beta;    % upsample sampling rate
span = 20;       % rcos span for thinner bandwidth consumption
%pwr = 200;       % channel power in mW

% Canal 
Eb_No = 30;                                     %SNR
random_delay = randi([0 Tb/Tn],1,K)             % Délais aléatoire
%random_alphaN = (rand(1,1))                    % facteur d-affaiblissement aléatoire (>1)
alpha_N=0.97;                                   % facteur d-affaiblissement fixe (>1)  

% Recepteur
impulseL = 128;
startSeq = [1 0 1 0 1 0 1 0 ... % test the channel response
            1 1 1 1 1 1 1 1];   % set an unique sequence
