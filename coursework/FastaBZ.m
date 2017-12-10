function [newAminos] = FastaBZ(sequence)
%Deal with FASTA datas
%   input: amino acids sequence containing B or Z sequence
%   output: a new amino acids matrix with all possibilities of
%   aspartate/asparagine or glutamate/glutamine.

newAminosB = [];
newAminosZ = [];
if any(sequence == 'B')
    I = strfind(sequence,'B');
    poss = zeros(2^length(I),length(I));
    col = str2num(dec2bin(1:2^length(I)-1));
    poss(2:end ,col) = 1;
    newAminosB = repmat(sequence,2^length(I),1);
    for i=1:size(poss,1)
        newAminosB(i,all(poss(i,:))) = 'D';
        newAminosB(i,not(poss(i,:))) = 'N';
    end
elseif any(sequence == 'Z')
    I = strfind(sequence,'Z');
    poss = zeros(2^length(I),length(I));
    col = str2double(dec2bin(1:2^length(I)-1));
    poss(2:end ,col) = 1;
    newAminosZ = repmat(sequence,2^length(I),1);
    for i=1:2:size(poss,1)
        newAminosZ(i,all(poss(i,:))) = 'E';
        newAminosZ(i,not(poss(i,:))) = 'Q';
    end
else
    fprint('No B or Z found');
end

newAminos = [newAminosB ; newAminosZ];

end

