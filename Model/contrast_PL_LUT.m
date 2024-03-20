function Lut = contrast_PL_LUT(gamma)

Lut = 1:256;

for index=1:length(Lut)
   Lut(index) = (index^gamma) / 255^(gamma-1);
end

Lut=uint8(Lut);
end

