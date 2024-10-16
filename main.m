clear all 
clc
 load('COIL20_Obj.mat');	
 nClass = length(unique(gnd));
 dataset='COIL20_Obj';      
 fea=double(fea);
 
 %Sort samples by labels
 [labels,index]=sort(gnd,'ascend');
 gnd=labels;
 fea=fea(index,:);
 fea=double(fea);
 
 %Euclidean length normalization
 fea = NormalizeFea(fea); 

 LabelsRatio=0.1;
 K=nClass; %full-size dataset as input data  
 meanAC=[];
 meanMI=[];
 stdAC=[];
 stdMI=[];
 % The value of parameter p in the experiments
 % PIE  UMIST COIL20  COIL100  Optdigists MNIST
 %  3    3      2        2         5        5
  p=2;
  TempAC=[];
  TempMI=[];
  for h=1:10
     %Select the data points of K classes as the input of the algorithm
     [X,Smpgnd,count]=CreatSampleDatasets(fea,K,gnd,nClass,LabelsRatio);
     % X:selected data points belong to K Classes
     % Smpgnd: the lables of selected data points
     %  count: the number of selected data points
     Options.maxIter=20;
     Options.k =p;% p: Nearest neighbor parameter
     Options.gndSmpNum=count;
     Options.Smpgnd=Smpgnd;
     Options.KClass=K;
     Options.nClass=nClass;
     [V,~]=OCSNMF(X,Options);
     [~, label] = max(V');
     newL=bestMap(Smpgnd,label);
     AC=Accuracy(newL,Smpgnd);
     MIhat = MutualInfo(Smpgnd,label);  
     TempAC(h)=AC;% accuracy.acc;
     TempMI(h)=MIhat;% accuracy.nmi;
 end
    meanAC=mean(TempAC);
    meanMI=mean(TempMI);
    stdAC=std(TempAC);
    stdMI=std(TempMI);

 
 
    
 