
% Message
Minfo = 90;         % Taille message a  transmettre [en bits]
Mseq = 10;          % Taille de la sequence de synchronisation 
M = Minfo + Mseq;   % Taille des messages envoyes 

% Systeme 
% K = N = 2;     % Nombre de modules 
N = 1;           % Nombre de canaux
R = 1000;         % debit binaire [en bits / s]
Tb = 1 / R;      % La duree d'un seul bit [en s / bit]

% Emetteur
rolloff = 0.40;  % Facteur de rolloff (varie entre 0 et 1)
beta = 4*N;      % Facteur de surechantillonnage
Tn = Tb/beta;    % Cadence Tn de la séquence d?échantillons en sortie du FIR
span = 10;       % rcos span for thinner bandwidth consumption
pwr = 200;       % channel power in mW

% Canal 
shift = 4;
Eb_No = 30;                                     % SNR
random_delay = randi([0 Tb/Tn],1,N);             % delais aleatoire
%random_alphaN = (rand(1,1))                    % facteur d-affaiblissement aléatoire (>1)
alpha_N=0.97;                                   % facteur d-affaiblissement fixe (>1)  

% Recepteur
impulseL = 128;
startSeq = [1 1 1 1 1 1 1 1 1 1];   % set an unique sequence
