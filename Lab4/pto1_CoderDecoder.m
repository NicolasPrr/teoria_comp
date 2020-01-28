#ENCODING
d = [0 0 1] # word of k bits to encode
k = length(d);
n = 6;
m = n-k;
P = [1 0 1; 1 1 1; 1 1 0];
Ik = eye(k);
PT = P';
G = [Ik PT];
c = d*G
#DECODING
r = [0 1 0 1 1 1] # word received
Im = eye(m);
HT = [PT; Im];
s = mod(r*HT,2);
[tf, errorIndex]=ismember(s,HT,'rows');
r(errorIndex) = (r(errorIndex) == 0);
r_corrected = r

