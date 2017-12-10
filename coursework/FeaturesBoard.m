%% Importing the datas
clear all; close all;
tic
display('loading data...');
CytosolicStruct = fastaread('Cyto_euk.fasta.txt');
Cytosolic = str2mat(CytosolicStruct.Sequence);

ExtracellularStruct = fastaread('Extra_euk.fasta.txt');
Extracellular = str2mat(ExtracellularStruct.Sequence);

MitochondrialStruct = fastaread('Mito.fasta.txt');
Mitochondrial = str2mat(MitochondrialStruct.Sequence);

NuclearStruct = fastaread('Nuclear.fasta.txt');
Nuclear = str2mat(NuclearStruct.Sequence);

clear CytosolicStruct ExtracellularStruct MitochondrialStruct NuclearStruct


%% Which features
Features1 = false; % molweight
Features2 = false; % isoelectric
Features3 = false; % aacount
Features4 = false; % first 50 Amino Acids
Features5 = false; % last 50 Amino Acids
Features6 = false; % length protein
Features7 = false; % isotopicdist
Features8 = false; % AAassociation
Features9 = false; % signal-p
Features10 = false; % Atomic Composition
Features11 = true;

%% Extracting features
display('Extracting features Cytosolic...');
for i=1:size(Cytosolic,1)
    if any(Cytosolic(i,:) == 'B')
            I = strfind(Cytosolic(i,:),'B');
            Cytosolic(i,I) = 'D';
    end
    if any(Cytosolic(i,:) == 'Z')
            I = strfind(Cytosolic(i,:),'Z');
            Cytosolic(i,I) = 'E'; 
    end
        if Features1
            FeaturesC1(i,1) = molweight(strcat(Cytosolic(i,:)));
        end
        if Features2
            FeaturesC2(i,1) = isoelectric(strcat(Cytosolic(i,:)));
        end
        if Features3
            AAstruct = aacount(strcat(Cytosolic(i,:)));
            AAcell = struct2cell(AAstruct);
            FeaturesC3(i,:) = (cell2mat(AAcell))';%/ length(strcat(Cytosolic(i,:)));
        end
        if Features4
            FeaturesC4(i,:) = double(aa2int(strcat(Cytosolic(i,1:50))));
        end
        if Features5
            FeaturesC5(i,:) = double(aa2int(strcat(Cytosolic(i,(length(strcat(Cytosolic(i,:)))-50):end))));
        end
        if Features6
            FeaturesC6(i,:) = length(strcat(Cytosolic(i,:)));
        end
        if Features7
            [MD, Info, DF] = isotopicdist(strcat(Cytosolic(i,:)));
            FeaturesC7(i,:) = [Info.NominalMass, Info.MonoisotopicMass, Info.ObservedAverageMass, Info.CalculatedAverageMass, Info.MostAbundantMass];
        end
        if Features8
            res = AAassociation(strcat(Cytosolic(i,:)));
            FeaturesC8(i,:) = res(:);
        end
        if Features9
            AAstruct2 = aacount(strcat(Cytosolic(i,1:20)));
            AAcell2 = struct2cell(AAstruct2);
            FeaturesC9(i,:) = (cell2mat(AAcell2))'/20;
        end
        if Features10
            AtomCom = atomiccomp(strcat(Cytosolic(i,:)));
            AtomCom = struct2cell(AtomCom);
            FeaturesC10(i,:) = (cell2mat(AtomCom))';
        end
        if Features11
            h = proteinpropplot(strcat(Cytosolic(i,:)));
            FeaturesC11(i,:) = mean(h.Data);
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


display('Extract features Extracellular...');
for i=1:size(Extracellular,1)
    if any(Extracellular(i,:) == 'B')
            I = strfind(Extracellular(i,:),'B');
            Extracellular(i,I) = 'D';
    end
    if any(Extracellular(i,:) == 'Z')
            I = strfind(Extracellular(i,:),'Z');
            Extracellular(i,I) = 'E';
    end
        if Features1
            FeaturesE1(i,1) = molweight(strcat(Extracellular(i,:)));
        end
        if Features2
            FeaturesE2(i,1) = isoelectric(strcat(Extracellular(i,:)));
        end
        if Features3
            AAstruct = aacount(strcat(Extracellular(i,:)));
            AAcell = struct2cell(AAstruct);
            FeaturesE3(i,:) = (cell2mat(AAcell))';%/ length(strcat(Extracellular(i,:)));
        end
        if Features4
            FeaturesE4(i,:) = double(aa2int(strcat(Extracellular(i,1:50))));
        end
        if Features5
            FeaturesE5(i,:) = double(aa2int(strcat(Extracellular(i,(length(strcat(Extracellular(i,:)))-50):end))));
        end
        if Features6
            FeaturesE6(i,:) = length(strcat(Extracellular(i,:)));
        end
        if Features7
            [MD, Info, DF] = isotopicdist(strcat(Extracellular(i,:)));
            FeaturesE7(i,:) = [Info.NominalMass, Info.MonoisotopicMass, Info.ObservedAverageMass, Info.CalculatedAverageMass, Info.MostAbundantMass];
        end
        if Features8
            res = AAassociation(strcat(Extracellular(i,:)));
            FeaturesE8(i,:) = res(:);
        end
        if Features9
            AAstruct2 = aacount(strcat(Extracellular(i,1:20)));
            AAcell2 = struct2cell(AAstruct2);
            FeaturesE9(i,:) = (cell2mat(AAcell2))'/20;
        end
        if Features10
            AtomCom = atomiccomp(strcat(Extracellular(i,:)));
            AtomCom = struct2cell(AtomCom);
            FeaturesE10(i,:) = (cell2mat(AtomCom))';
        end
        if Features11
            h = proteinpropplot(strcat(Extracellular(i,:)));
            FeaturesE11(i,:) = mean(h.Data);
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


display('Extract features Mitochondrial...');
for i=1:size(Mitochondrial,1)
    if any(Mitochondrial(i,:) == 'B')
            I = strfind(Mitochondrial(i,:),'B');
            Mitochondrial(i,I) = 'D';
    end
    if any(Mitochondrial(i,:) == 'Z')
            I = strfind(Mitochondrial(i,:),'Z');
            Mitochondrial(i,I) = 'E';
    end
        if Features1
            FeaturesM1(i,1) = molweight(strcat(Mitochondrial(i,:)));
        end
        if Features2
            FeaturesM2(i,1) = isoelectric(strcat(Mitochondrial(i,:)));
        end
        if Features3
            AAstruct = aacount(strcat(Mitochondrial(i,:)));
            AAcell = struct2cell(AAstruct);
            FeaturesM3(i,:) = (cell2mat(AAcell))';%/ length(strcat(Mitochondrial(i,:)));
        end
        if Features4
            FeaturesM4(i,:) = double(aa2int(strcat(Mitochondrial(i,1:50))));
        end
        if Features5
            FeaturesM5(i,:) = double(aa2int(strcat(Mitochondrial(i,(length(strcat(Mitochondrial(i,:)))-50):end))));
        end
        if Features6
            FeaturesM6(i,:) = length(strcat(Mitochondrial(i,:)));
        end
        if Features7
            [MD, Info, DF] = isotopicdist(strcat(Mitochondrial(i,:)));
            FeaturesM7(i,:) = [Info.NominalMass, Info.MonoisotopicMass, Info.ObservedAverageMass, Info.CalculatedAverageMass, Info.MostAbundantMass];
        end
        if Features8
            res = AAassociation(strcat(Mitochondrial(i,:)));
            FeaturesM8(i,:) = res(:);
        end
        if Features9
            AAstruct2 = aacount(strcat(Mitochondrial(i,1:20)));
            AAcell2 = struct2cell(AAstruct2);
            FeaturesM9(i,:) = (cell2mat(AAcell2))'/20;
        end
        if Features10
            AtomCom = atomiccomp(strcat(Mitochondrial(i,:)));
            AtomCom = struct2cell(AtomCom);
            FeaturesM10(i,:) = (cell2mat(AtomCom))';
        end
        if Features11
            h = proteinpropplot(strcat(Mitochondrial(i,:)));
            FeaturesM11(i,:) = mean(h.Data);
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

display('Extract features Nuclear...');
for i=1:size(Nuclear,1)
    if any(Nuclear(i,:) == 'B')
            I = strfind(Nuclear(i,:),'B');
            Nuclear(i,I) = 'D';
    end
    if any(Nuclear(i,:) == 'Z')
            I = strfind(Nuclear(i,:),'Z');
            Nuclear(i,I) = 'E';
    end
        if Features1
            FeaturesN1(i,1) = molweight(strcat(Nuclear(i,:)));
        end
        if Features2
            FeaturesN2(i,1) = isoelectric(strcat(Nuclear(i,:)));
        end
        if Features3
            AAstruct = aacount(strcat(Nuclear(i,:)));
            AAcell = struct2cell(AAstruct);
            FeaturesN3(i,:) = (cell2mat(AAcell))';% / length(strcat(Nuclear(i,:)));
        end
        if Features4
            FeaturesN4(i,:) = double(aa2int(strcat(Nuclear(i,1:50))));
        end
        if Features5
            FeaturesN5(i,:) = double(aa2int(strcat(Nuclear(i,(length(strcat(Nuclear(i,:)))-50):end))));
        end
        if Features6
            FeaturesN6(i,:) = length(strcat(Nuclear(i,:)));
        end
        if Features7
            [MD, Info, DF] = isotopicdist(strcat(Nuclear(i,:)));
            FeaturesN7(i,:) = [Info.NominalMass, Info.MonoisotopicMass, Info.ObservedAverageMass, Info.CalculatedAverageMass, Info.MostAbundantMass];
        end
        if Features8
            res = AAassociation(strcat(Nuclear(i,:)));
            FeaturesN8(i,:) = res(:);
        end
        if Features9
            AAstruct2 = aacount(strcat(Nuclear(i,1:20)));
            AAcell2 = struct2cell(AAstruct2);
            FeaturesN9(i,:) = (cell2mat(AAcell2))'/20;
        end
        if Features10
            AtomCom = atomiccomp(strcat(Nuclear(i,:)));
            AtomCom = struct2cell(AtomCom);
            FeaturesN10(i,:) = (cell2mat(AtomCom))';
        end
        if Features11
            h = proteinpropplot(strcat(Nuclear(i,:)));
            FeaturesN11(i,:) = mean(h.Data);
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
display('Concatenating...')
Set = [FeaturesC; FeaturesE; FeaturesM; FeaturesN];
Labels = [ones(size(FeaturesC,1),1); ones(size(FeaturesE,1),1)+1; ones(size(FeaturesM,1),1)+2; ones(size(FeaturesN,1),1)+3];

%% save features
display('saving...');
save('features.mat','Set','Labels');
display('done!');
toc