
codesymbol = @(x)x.*2-1;


% Message
Minfo = 90;         % Taille message � transmettre [en bits]
Mseq = 10;          % Taille de la s�quence de synchronisation 
M = Minfo + Mseq;   % Taille des messages envoy�s 

% Syst�me 
K = 4;           % Nombre de modules 
N = 2;           % Nombre de canaux
R = 10;          % D�bit binaire [en bits / s]
Tb = 1 / R;      % La dur�e d'un seul bit [en s / bit]

% �metteur
rolloff = 0.40;  % Facteur de rolloff (varie entre 0 et 1)
beta = 4*N;      % Facteur de sur-�chantillonnage
Tn = Tb/beta;    % upsample sampling rate
span = 20;       % rcos span for thinner bandwidth consumption
%pwr = 200;       % channel power in mW


