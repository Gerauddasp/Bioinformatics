function [resMat] = AAassociation(sequence)
%Calculate all pair in a sequence
%   input: Amino Acids sequence
%   output: combinations mat first amino being the row and second the
%   columns

sequence = aa2int(strcat(sequence));
resMat = zeros(20);
for i=2:length(sequence)
    resMat(sequence(i-1),sequence(i)) = resMat(sequence(i-1),sequence(i)) + 1;
end

end

