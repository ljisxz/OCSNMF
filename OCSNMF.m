  function   [V, objective]=OCSNMF(X,Options)
 
 
 
      options = [];
      options.Metric = 'cosine';
      options.NeighborMode = 'KNN';
      options.k =Options.k;
      options.WeightMode ='Binary'; 
      W= constructW( X,options);

      N=size(W,1);
      Y=zeros(N, Options.KClass);
      %m=length(Options.XSmpgnd);
      for i=1:Options.gndSmpNum
          Y(i,Options.Smpgnd(i))=1;
      end

      V = rand(N, Options.KClass);
      objective=[];
     % tic
      for iters = 1:  Options.maxIter
          V(1: Options.gndSmpNum,:)= Y(1: Options.gndSmpNum,:);
          V=V.*(W*V)./(V*V'*V+eps);
          objective(iters)=sum(sum((W - V*V').^2));
      end
      %toc

 end
