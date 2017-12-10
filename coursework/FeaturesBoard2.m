%% Importing the datas
clear all; close all;
tic
%display('loading data...');
CytosolicStruct = fastaread('Cyto_euk.fasta.txt');
Cytosolic = str2mat(CytosolicStruct.Sequence);

ExtracellularStruct = fastaread('Extra_euk.fasta.txt');
Extracellular = str2mat(ExtracellularStruct.Sequence);

MitochondrialStruct = fastaread('Mito.fasta.txt');
Mitochondrial = str2mat(MitochondrialStruct.Sequence);

NuclearStruct = fastaread('Nuclear.fasta.txt');
Nuclear = str2mat(NuclearStruct.Sequence);

clear CytosolicStruct ExtracellularStruct MitochondrialStruct NuclearStruct
countC = 0;
countE = 0;
countM = 0;
countN = 0;

%% Which features
Features1 = true; % molweight
Features2 = true; % isoelectric
Features3 = false; % aacount
Features4 = true; % length protein
Features5 = true; % AAassociation
Features6 = true; % hydrophobicity
% first part of the protein
Features7 = false; % molweight
Features8 = true; % isolectric
Features9 = true; % aacount
Features10 = false; % AAassociation
Features11 = true; % hydrophobicity
% end part of the protein
Features12 = false; % molweight
Features13 = true; % isolectric
Features14 = true; % aacount
Features15 = false; % AAassociation
Features16 = true; % hydrophobicity
%% Extracting features
%display('Extracting features Cytosolic...');
for i=1:size(Cytosolic,1)
    if any(Cytosolic(i,:) == 'B')
            I = strfind(Cytosolic(i,:),'B');
            Cytosolic(i,I) = 'D';
            countC = countC + 1;
    end
    if any(Cytosolic(i,:) == 'Z')
            I = strfind(Cytosolic(i,:),'Z');
            Cytosolic(i,I) = 'E'; 
            countC = countC + 1;
    end
        % analysing the entire sequence
        sequence = strcat(Cytosolic(i,:));
        if Features1
            FeaturesC1(i,1) = molweight(sequence);
        end
        if Features2
            FeaturesC2(i,1) = isoelectric(sequence);
        end
        if Features3
            AAstruct = aacount(sequence);
            AAcell = struct2cell(AAstruct);
            FeaturesC3(i,:) = (cell2mat(AAcell))'/ length(sequence);
        end
        if Features4
            FeaturesC4(i,:) = length(sequence);
        end
        if Features5
            res = AAassociation(sequence);
            FeaturesC5(i,:) = res(:);
        end
        if Features6
            h = proteinpropplot(sequence);
            FeaturesC6(i,:) = mean(h.Data);
        end
        % the first part of the sequence
        if Features7
            FeaturesC7(i,1) = molweight(sequence(1:50));
        end
        if Features8
            FeaturesC8(i,1) = isoelectric(sequence(1:50));
        end
        if Features9
            AAstruct = aacount(sequence(1:50));
            AAcell = struct2cell(AAstruct);
            FeaturesC9(i,:) = (cell2mat(AAcell))'/ length(sequence(1:50));
        end
        if Features10
            res = AAassociation(sequence(1:50));
            FeaturesC10(i,:) = res(:);
        end
        if Features11
            h = proteinpropplot(sequence(1:50));
            FeaturesC11(i,:) = mean(h.Data);
        end
        % The en of the protein:
        ENDsequence = sequence(length(sequence)-50:end);
        if Features12
            FeaturesC12(i,1) = molweight(ENDsequence);
        end
        if Features13
            FeaturesC13(i,1) = isoelectric(ENDsequence);
        end
        if Features14
            AAstruct = aacount(ENDsequence);
            AAcell = struct2cell(AAstruct);
            FeaturesC14(i,:) = (cell2mat(AAcell))'/ length(ENDsequence);
        end
        if Features15
            res = AAassociation(ENDsequence);
            FeaturesC15(i,:) = res(:);
        end
        if Features16
            h = proteinpropplot(ENDsequence);
            FeaturesC16(i,:) = mean(h.Data);
        end
        
end

FeaturesC = [];
if Features1
    FeaturesC = [FeaturesC, FeaturesC1];
end
if Features2
    FeaturesC = [FeaturesC, FeaturesC2];
end
if Features3
    FeaturesC = [FeaturesC, FeaturesC3];
end
if Features4
    FeaturesC = [FeaturesC, FeaturesC4];
end
if Features5
    FeaturesC = [FeaturesC, FeaturesC5];
end
if Features6
    FeaturesC = [FeaturesC, FeaturesC6];
end
if Features7
    FeaturesC = [FeaturesC, FeaturesC7];
end
if Features8
    FeaturesC = [FeaturesC, FeaturesC8];
end
if Features9
    FeaturesC = [FeaturesC, FeaturesC9];
end
if Features10
    FeaturesC = [FeaturesC, FeaturesC10];
end
if Features11
    FeaturesC = [FeaturesC, FeaturesC11];
end
if Features12
    FeaturesC = [FeaturesC, FeaturesC12];
end
if Features13
    FeaturesC = [FeaturesC, FeaturesC13];
end
if Features14
    FeaturesC = [FeaturesC, FeaturesC14];
end
if Features15
    FeaturesC = [FeaturesC, FeaturesC15];
end
if Features16
    FeaturesC = [FeaturesC, FeaturesC16];
end

%display('Extract features Extracellular...');
for i=1:size(Extracellular,1)
    if any(Extracellular(i,:) == 'B')
            I = strfind(Extracellular(i,:),'B');
            Extracellular(i,I) = 'D';
            countE = countE + 1;
    end
    if any(Extracellular(i,:) == 'Z')
            I = strfind(Extracellular(i,:),'Z');
            Extracellular(i,I) = 'E';
            countE = countE + 1;
    end
        % analysing the entire sequence
        sequence = strcat(Extracellular(i,:));
        if Features1
            FeaturesE1(i,1) = molweight(sequence);
        end
        if Features2
            FeaturesE2(i,1) = isoelectric(sequence);
        end
        if Features3
            AAstruct = aacount(sequence);
            AAcell = struct2cell(AAstruct);
            FeaturesE3(i,:) = (cell2mat(AAcell))'/ length(sequence);
        end
        if Features4
            FeaturesE4(i,:) = length(sequence);
        end
        if Features5
            res = AAassociation(sequence);
            FeaturesE5(i,:) = res(:);
        end
        if Features6
            h = proteinpropplot(sequence);
            FeaturesE6(i,:) = mean(h.Data);
        end
        % the first part of the sequence
        if Features7
            FeaturesE7(i,1) = molweight(sequence(1:50));
        end
        if Features8
            FeaturesE8(i,1) = isoelectric(sequence(1:50));
        end
        if Features9
            AAstruct = aacount(sequence(1:50));
            AAcell = struct2cell(AAstruct);
            FeaturesE9(i,:) = (cell2mat(AAcell))'/ length(sequence(1:50));
        end
        if Features10
            res = AAassociation(sequence(1:50));
            FeaturesE10(i,:) = res(:);
        end
        if Features11
            h = proteinpropplot(sequence(1:50));
            FeaturesE11(i,:) = mean(h.Data);
        end
        % The en of the protein:
        ENDsequence = sequence(length(sequence)-50:end);
        if Features12
            FeaturesE12(i,1) = molweight(ENDsequence);
        end
        if Features13
            FeaturesE13(i,1) = isoelectric(ENDsequence);
        end
        if Features14
            AAstruct = aacount(ENDsequence);
            AAcell = struct2cell(AAstruct);
            FeaturesE14(i,:) = (cell2mat(AAcell))'/ length(ENDsequence);
        end
        if Features15
            res = AAassociation(ENDsequence);
            FeaturesE15(i,:) = res(:);
        end
        if Features16
            h = proteinpropplot(ENDsequence);
            FeaturesE16(i,:) = mean(h.Data);
        end
end

%FeaturesE = [FeaturesE1, FeaturesE2, FeaturesE3, FeaturesE4, FEaturesE5, FeaturesE6, FeaturesE7, FeaturesE8, FeaturesE9, FeaturesE10];
FeaturesE = [];
if Features1
    FeaturesE = [FeaturesE, FeaturesE1];
end
if Features2
    FeaturesE = [FeaturesE, FeaturesE2];
end
if Features3
    FeaturesE = [FeaturesE, FeaturesE3];
end
if Features4
    FeaturesE = [FeaturesE, FeaturesE4];
end
if Features5
    FeaturesE = [FeaturesE, FeaturesE5];
end
if Features6
    FeaturesE = [FeaturesE, FeaturesE6];
end
if Features7
    FeaturesE = [FeaturesE, FeaturesE7];
end
if Features8
    FeaturesE = [FeaturesE, FeaturesE8];
end
if Features9
    FeaturesE = [FeaturesE, FeaturesE9];
end
if Features10
    FeaturesE = [FeaturesE, FeaturesE10];
end
if Features11
    FeaturesE = [FeaturesE, FeaturesE11];
end
if Features12
    FeaturesE = [FeaturesE, FeaturesE12];
end
if Features13
    FeaturesE = [FeaturesE, FeaturesE13];
end
if Features14
    FeaturesE = [FeaturesE, FeaturesE14];
end
if Features15
    FeaturesE = [FeaturesE, FeaturesE15];
end
if Features16
    FeaturesE = [FeaturesE, FeaturesE16];
end
%display('Extract features Mitochondrial...');
for i=1:size(Mitochondrial,1)
    if any(Mitochondrial(i,:) == 'B')
            I = strfind(Mitochondrial(i,:),'B');
            Mitochondrial(i,I) = 'D';
            countM = countM + 1;
    end
    if any(Mitochondrial(i,:) == 'Z')
            I = strfind(Mitochondrial(i,:),'Z');
            Mitochondrial(i,I) = 'E';
            countM = countM+1;
    end
        % analysing the entire sequence
        sequence = strcat(Mitochondrial(i,:));
        if Features1
            FeaturesM1(i,1) = molweight(sequence);
        end
        if Features2
            FeaturesM2(i,1) = isoelectric(sequence);
        end
        if Features3
            AAstruct = aacount(sequence);
            AAcell = struct2cell(AAstruct);
            FeaturesM3(i,:) = (cell2mat(AAcell))'/ length(sequence);
        end
        if Features4
            FeaturesM4(i,:) = length(sequence);
        end
        if Features5
            res = AAassociation(sequence);
            FeaturesM5(i,:) = res(:);
        end
        if Features6
            h = proteinpropplot(sequence);
            FeaturesM6(i,:) = mean(h.Data);
        end
        % the first part of the sequence
        if Features7
            FeaturesM7(i,1) = molweight(sequence(1:50));
        end
        if Features8
            FeaturesM8(i,1) = isoelectric(sequence(1:50));
        end
        if Features9
            AAstruct = aacount(sequence(1:50));
            AAcell = struct2cell(AAstruct);
            FeaturesM9(i,:) = (cell2mat(AAcell))'/ length(sequence(1:50));
        end
        if Features10
            res = AAassociation(sequence(1:50));
            FeaturesM10(i,:) = res(:);
        end
        if Features11
            h = proteinpropplot(sequence(1:50));
            FeaturesM11(i,:) = mean(h.Data);
        end
        % The en of the protein:
        ENDsequence = sequence(length(sequence)-50:end);
        if Features12
            FeaturesM12(i,1) = molweight(ENDsequence);
        end
        if Features13
            FeaturesM13(i,1) = isoelectric(ENDsequence);
        end
        if Features14
            AAstruct = aacount(ENDsequence);
            AAcell = struct2cell(AAstruct);
            FeaturesM14(i,:) = (cell2mat(AAcell))'/ length(ENDsequence);
        end
        if Features15
            res = AAassociation(ENDsequence);
            FeaturesM15(i,:) = res(:);
        end
        if Features16
            h = proteinpropplot(ENDsequence);
            FeaturesM16(i,:) = mean(h.Data);
        end
end

%FeaturesM = [FeaturesM1, FeaturesM2, FeaturesM3, FeaturesM4, FeaturesM5 FeaturesM6, FeaturesM7, FeaturesM8, FeaturesM9, FeaturesM10];
FeaturesM = [];
if Features1
    FeaturesM = [FeaturesM, FeaturesM1];
end
if Features2
    FeaturesM = [FeaturesM, FeaturesM2];
end
if Features3
    FeaturesM = [FeaturesM, FeaturesM3];
end
if Features4
    FeaturesM = [FeaturesM, FeaturesM4];
end
if Features5
    FeaturesM = [FeaturesM, FeaturesM5];
end
if Features6
    FeaturesM = [FeaturesM, FeaturesM6];
end
if Features7
    FeaturesM = [FeaturesM, FeaturesM7];
end
if Features8
    FeaturesM = [FeaturesM, FeaturesM8];
end
if Features9
    FeaturesM = [FeaturesM, FeaturesM9];
end
if Features10
    FeaturesM = [FeaturesM, FeaturesM10];
end
if Features11
    FeaturesM = [FeaturesM, FeaturesM11];
end
if Features12
    FeaturesM = [FeaturesM, FeaturesM12];
end
if Features13
    FeaturesM = [FeaturesM, FeaturesM13];
end
if Features14
    FeaturesM = [FeaturesM, FeaturesM14];
end
if Features15
    FeaturesM = [FeaturesM, FeaturesM15];
end
if Features16
    FeaturesM = [FeaturesM, FeaturesM16];
end
%display('Extract features Nuclear...');
for i=1:size(Nuclear,1)
    if any(Nuclear(i,:) == 'B')
            I = strfind(Nuclear(i,:),'B');
            Nuclear(i,I) = 'D';
            countN = countN + 1;
    end
    if any(Nuclear(i,:) == 'Z')
            I = strfind(Nuclear(i,:),'Z');
            Nuclear(i,I) = 'E';
            countN = countN + 1;
    end
        % analysing the entire sequence
        sequence = strcat(Nuclear(i,:));
        if Features1
            FeaturesN1(i,1) = molweight(sequence);
        end
        if Features2
            FeaturesN2(i,1) = isoelectric(sequence);
        end
        if Features3
            AAstruct = aacount(sequence);
            AAcell = struct2cell(AAstruct);
            FeaturesN3(i,:) = (cell2mat(AAcell))'/ length(sequence);
        end
        if Features4
            FeaturesN4(i,:) = length(sequence);
        end
        if Features5
            res = AAassociation(sequence);
            FeaturesN5(i,:) = res(:);
        end
        if Features6
            h = proteinpropplot(sequence);
            FeaturesN6(i,:) = mean(h.Data);
        end
        % the first part of the sequence
        if Features7
            FeaturesN7(i,1) = molweight(sequence(1:50));
        end
        if Features8
            FeaturesN8(i,1) = isoelectric(sequence(1:50));
        end
        if Features9
            AAstruct = aacount(sequence(1:50));
            AAcell = struct2cell(AAstruct);
            FeaturesN9(i,:) = (cell2mat(AAcell))'/ length(sequence(1:50));
        end
        if Features10
            res = AAassociation(sequence(1:50));
            FeaturesN10(i,:) = res(:);
        end
        if Features11
            h = proteinpropplot(sequence(1:50));
            FeaturesN11(i,:) = mean(h.Data);
        end
        % The en of the protein:
        ENDsequence = sequence(length(sequence)-50:end);
        if Features12
            FeaturesN12(i,1) = molweight(ENDsequence);
        end
        if Features13
            FeaturesN13(i,1) = isoelectric(ENDsequence);
        end
        if Features14
            AAstruct = aacount(ENDsequence);
            AAcell = struct2cell(AAstruct);
            FeaturesN14(i,:) = (cell2mat(AAcell))'/ length(ENDsequence);
        end
        if Features15
            res = AAassociation(ENDsequence);
            FeaturesN15(i,:) = res(:);
        end
        if Features16
            h = proteinpropplot(ENDsequence);
            FeaturesN16(i,:) = mean(h.Data);
        end
end

%FeaturesN = [FeaturesN1, FeaturesN2, FeaturesN3, FeaturesN4, FEaturesN5, FeaturesN6, FeaturesN7, FeaturesN8, FeaturesN9, FeaturesN10];

FeaturesN = [];
if Features1
    FeaturesN = [FeaturesN, FeaturesN1];
end
if Features2
    FeaturesN = [FeaturesN, FeaturesN2];
end
if Features3
    FeaturesN = [FeaturesN, FeaturesN3];
end
if Features4
    FeaturesN = [FeaturesN, FeaturesN4];
end
if Features5
    FeaturesN = [FeaturesN, FeaturesN5];
end
if Features6
    FeaturesN = [FeaturesN, FeaturesN6];
end
if Features7
    FeaturesN = [FeaturesN, FeaturesN7];
end
if Features8
    FeaturesN = [FeaturesN, FeaturesN8];
end
if Features9
    FeaturesN = [FeaturesN, FeaturesN9];
end
if Features10
    FeaturesN = [FeaturesN, FeaturesN10];
end
if Features11
    FeaturesN = [FeaturesN, FeaturesN11];
end
if Features12
    FeaturesN = [FeaturesN, FeaturesN12];
end
if Features13
    FeaturesN = [FeaturesN, FeaturesN13];
end
if Features14
    FeaturesN = [FeaturesN, FeaturesN14];
end
if Features15
    FeaturesN = [FeaturesN, FeaturesN15];
end
if Features16
    FeaturesN = [FeaturesN, FeaturesN16];
end
%display('Concatenating...')
Set = [FeaturesC; FeaturesE; FeaturesM; FeaturesN];
Labels = [ones(size(FeaturesC,1),1); ones(size(FeaturesE,1),1)+1; ones(size(FeaturesM,1),1)+2; ones(size(FeaturesN,1),1)+3];

%% save features
%display('saving...');
save('features.mat','Set','Labels');
%display('done!');
%toc