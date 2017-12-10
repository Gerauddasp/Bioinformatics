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

%% Extracting features

display('Extracting features Cytosolic...');
for i=1:size(Cytosolic,1)
    if any(Cytosolic(i,:) == 'B') || any(Cytosolic(i,:) == 'Z')
        newCyto = FastaBZ(Cytosolic(i,:));
        Cytosolic = [Cytosolic(1:i,:); newCyto; Cytosolic(i+1:end,:)];
    else
        FeaturesC1(i,1) = molweight(strcat(Cytosolic(i,:)));
%         FeaturesC2(i,1) = isoelectric(strcat(Cytosolic(i,:)));
%         AAstruct = aacount(strcat(Cytosolic(i,:)));
%         AAcell = struct2cell(AAstruct);
%         FeaturesC3(i,:) = (cell2mat(AAcell))';%/ length(strcat(Cytosolic(i,:)));
%         FeaturesC4(i,:) = double(aa2int(strcat(Cytosolic(i,1:50))));
%         FeaturesC5(i,:) = double(aa2int(strcat(Cytosolic(i,(length(strcat(Cytosolic(i,:)))-50):end))));
%         FeaturesC6(i,:) = length(strcat(Cytosolic(i,:)));
%         [MD, Info, DF] = isotopicdist(strcat(Cytosolic(i,:)));
%         FeaturesC7(i,:) = [Info.NominalMass, Info.MonoisotopicMass, Info.ObservedAverageMass, Info.CalculatedAverageMass, Info.MostAbundantMass];
%         res = AAassociation(strcat(Cytosolic(i,:)));
%         FeaturesC8(i,:) = res(:);
%         AAstruct2 = aacount(strcat(Cytosolic(i,1:20)));
%         AAcell2 = struct2cell(AAstruct2);
%         FeaturesC9(i,:) = (cell2mat(AAcell2))'/20;
%         AtomCom = atomiccomp(strcat(Cytosolic(i,:)));
%         AtomCom = struct2cell(AtomCom);
%         FeaturesC10(i,:) = (cell2mat(AtomCom))';
    end
end

FeaturesC = [FeaturesC1];


display('Extract features Extracellular...');
for i=1:size(Extracellular,1)
    if any(Extracellular(i,:) == 'B') || any(Extracellular(i,:) == 'Z')
        newExtra = FastaBZ(Extracellular(i,:));
        Extracellular = [Extracellular(1:i,:); newExtra; Extracellular(i+1:end,:)];
    else
        FeaturesE1(i,1) = molweight(strcat(Extracellular(i,:)));
%         FeaturesE2(i,1) = isoelectric(strcat(Extracellular(i,:)));
%         AAstruct = aacount(strcat(Extracellular(i,:)));
%         AAcell = struct2cell(AAstruct);
%         FeaturesE3(i,:) = (cell2mat(AAcell))';%/ length(strcat(Extracellular(i,:)));
%         FeaturesE4(i,:) = double(aa2int(strcat(Extracellular(i,1:50))));
%         FeaturesE5(i,:) = double(aa2int(strcat(Extracellular(i,(length(strcat(Extracellular(i,:)))-50):end))));
%         FeaturesE6(i,:) = length(strcat(Extracellular(i,:)));
%         [MD, Info, DF] = isotopicdist(strcat(Extracellular(i,:)));
%         FeaturesE7(i,:) = [Info.NominalMass, Info.MonoisotopicMass, Info.ObservedAverageMass, Info.CalculatedAverageMass, Info.MostAbundantMass];
%         res = AAassociation(strcat(Extracellular(i,:)));
%         FeaturesE8(i,:) = res(:);
%         AAstruct2 = aacount(strcat(Extracellular(i,1:20)));
%         AAcell2 = struct2cell(AAstruct2);
%         FeaturesE9(i,:) = (cell2mat(AAcell2))'/20;
%         AtomCom = atomiccomp(strcat(Extracellular(i,:)));
%         AtomCom = struct2cell(AtomCom);
%         FeaturesE10(i,:) = (cell2mat(AtomCom))';
    end
end

FeaturesE = [FeaturesE1];


display('Extract features Mitochondrial...');
for i=1:size(Mitochondrial,1)
    if any(Mitochondrial(i,:) == 'B') || any(Mitochondrial(i,:) == 'Z')
        newMito = FastaBZ(Mitochondrial(i,:));
        Mitochondrial = [Mitochondrial(1:i,:); newMito; Mitochondrial(i+1:end,:)];
    else
        FeaturesM1(i,1) = molweight(strcat(Mitochondrial(i,:)));
%         FeaturesM2(i,1) = isoelectric(strcat(Mitochondrial(i,:)));
%         AAstruct = aacount(strcat(Mitochondrial(i,:)));
%         AAcell = struct2cell(AAstruct);
%         FeaturesM3(i,:) = (cell2mat(AAcell))';%/ length(strcat(Mitochondrial(i,:)));
%         FeaturesM4(i,:) = double(aa2int(strcat(Mitochondrial(i,1:50))));
%         FeaturesM5(i,:) = double(aa2int(strcat(Mitochondrial(i,(length(strcat(Mitochondrial(i,:)))-50):end))));
%         FeaturesM6(i,:) = length(strcat(Mitochondrial(i,:)));
%         [MD, Info, DF] = isotopicdist(strcat(Mitochondrial(i,:)));
%         FeaturesM7(i,:) = [Info.NominalMass, Info.MonoisotopicMass, Info.ObservedAverageMass, Info.CalculatedAverageMass, Info.MostAbundantMass];
%         res = AAassociation(strcat(Mitochondrial(i,:)));
%         FeaturesM8(i,:) = res(:);
%         AAstruct2 = aacount(strcat(Mitochondrial(i,1:20)));
%         AAcell2 = struct2cell(AAstruct2);
%         FeaturesM9(i,:) = (cell2mat(AAcell2))'/20;
%         AtomCom = atomiccomp(strcat(Mitochondrial(i,:)));
%         AtomCom = struct2cell(AtomCom);
%         FeaturesM10(i,:) = (cell2mat(AtomCom))';
    end
end

FeaturesM = [FeaturesM1];


display('Extract features Nuclear...');
for i=1:size(Nuclear,1)
    if any(Nuclear(i,:) == 'B') || any(Nuclear(i,:) == 'Z')
        newNuc = FastaBZ(Nuclear(i,:));
        Nuclear = [Nuclear(1:i,:); newNuc; Nuclear(i+1:end,:)];
    else
        FeaturesN1(i,1) = molweight(strcat(Nuclear(i,:)));
%         FeaturesN2(i,1) = isoelectric(strcat(Nuclear(i,:)));
%         AAstruct = aacount(strcat(Nuclear(i,:)));
%         AAcell = struct2cell(AAstruct);
%         FeaturesN3(i,:) = (cell2mat(AAcell))';% / length(strcat(Nuclear(i,:)));
%         FeaturesN4(i,:) = double(aa2int(strcat(Nuclear(i,1:50))));
%         FeaturesN5(i,:) = double(aa2int(strcat(Nuclear(i,(length(strcat(Nuclear(i,:)))-50):end))));
%         FeaturesN6(i,:) = length(strcat(Nuclear(i,:)));
%         [MD, Info, DF] = isotopicdist(strcat(Nuclear(i,:)));
%         FeaturesN7(i,:) = [Info.NominalMass, Info.MonoisotopicMass, Info.ObservedAverageMass, Info.CalculatedAverageMass, Info.MostAbundantMass];
%         res = AAassociation(strcat(Nuclear(i,:)));
%         FeaturesN8(i,:) = res(:);
%         AAstruct2 = aacount(strcat(Nuclear(i,1:20)));
%         AAcell2 = struct2cell(AAstruct2);
%         FeaturesN9(i,:) = (cell2mat(AAcell2))'/20;
%         AtomCom = atomiccomp(strcat(Nuclear(i,:)));
%         AtomCom = struct2cell(AtomCom);
%         FeaturesN10(i,:) = (cell2mat(AtomCom))';
    end
end

FeaturesN = [FeaturesN1];

display('Concatenating...')
Set = [FeaturesC; FeaturesE; FeaturesM; FeaturesN];
Labels = [ones(size(FeaturesC,1),1); ones(size(FeaturesE,1),1)+1; ones(size(FeaturesM,1),1)+2; ones(size(FeaturesN,1),1)+3];

%% save features
display('saving...');
save('features.mat','Set','Labels');
display('done!');
toc