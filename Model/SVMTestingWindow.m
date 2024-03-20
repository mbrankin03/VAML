function [prediction maxi]= SVMTesting(image,model)

if strcmp(model.type,'binary')
   
    [pred,score] = predict(model.modelFITSVM, image);
    
        prediction = score;
   
    
else
    
   [pred,NegLoss,Pb] = predict(model.classifier,image);
    
    maxi=max(Pb);

     prediction = round(pred)-1;
    
end
    
end