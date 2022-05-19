% We will design a power transmission for an industrial saw that will be 
% used to cut tubing or vehicle exhaust pipes to length prior to the 
% forming processes. The saw will receive 10 HP from the shaft of an 
% electric motor rotating at 3000 rpm. The drive shaft for the saw should 
% rotate at approximately 500 rpm. Design the reducer with two pairs of 
% gears due to limited space to the central distances of the gears

%% Inputs
% Step 1
Ko = 1.5; % Overload Factor
hp = 10; % Horsepower
np = 1000; % Pinion Speed.
MinRPM = 500; % Desired RPM, Min
MaxRPM = 500; % Desired RPM, Max
nG1 = mean(MinRPM, MaxRPM); % average speed of the output shaft
Pdes = hp*Ko; % Design power transmitted 
Pd = 12; % Diametral Pitch
disp(['The Overload is (Ko) ',num2str(Ko),' Ko'])
disp(['The horsepower is (P) ',num2str(hp),' hp'])
disp(['Design power transmitted (Pdes): ',num2str(Pdes),' hp'])
disp(['The pinion speed is (np) ',num2str(np),' RPM'])
disp(['The Minimiun speed is ',num2str(MinRPM),' RPM'])
disp(['The Maximum speed is ',num2str(MaxRPM),' RPM'])
disp(['The average speed is (nG)',num2str(MinRPM),' RPM'])
% Step 2
Np= 42; % Choose the Number of Teeth
disp(['The number of Teeth for Pinion (Np): ',num2str(Np)])
% Step 3
VR1 = np/nG1; % Velocity Ratio
disp(['The nominal velocity ratio (VR): ',num2str(VR1),])
% Step 4
NG = Np*VR1; % The number of teeth for Driven
NG1 = round(NG); % Round to the nearest whole number
disp(['The number of teeth for Driven (NG): ',num2str(NG1)])
% Step 5
VR2 = NG1/Np; % Actual Velocity Ratio
disp(['The Actual Velocity Ratio (VR): ',num2str(VR2)])
% Step 6
nG2 = np*(Np/NG1); % Actual Output Speed
disp(['The Actual Output Speed ',num2str(nG2), ' RPM'])
if nG2 >= MinRPM , nG2 <= MinRPM;
    disp(['***Meets the Requirements***'])
else;
    disp(['Try Again'])
    
end
% Step 7
DP = Np/Pd; % Pitch Diameter (Pinion)
disp(['The Pitch Diameter for Pinion (DP): ',num2str(DP),' in'])
DG = NG1/Pd; % Pitch Diameter (Gear)
disp(['The Pitch Diameter for Gear (DG): ',num2str(DG),' in'])
C = (Np+NG1)/(2*Pd); % Center Distance
disp(['The Center Distance (C): ',num2str(C),' in'])
vt1 = pi*DP*np/12; % Pitch line speed
vt2 = round(vt1);
disp(['Pitch Line Speed (vt): ',num2str(vt2),' ft/min'])
Wt1 = 33000*hp/vt2;
Wt2 = round(Wt1);
disp(['Transmitted Load (Wt): ',num2str(Wt2),' lb'])

% Step 8
% *** Enter the face Width
F = 1;  % in
disp(['Face Width (F): ',num2str(F),' in'])
RFDP = F/DP;
disp(['The Ratio F/DP (RFDP): ',num2str(RFDP)])
% Step 9
% *** Enter the Elastic Coefficient
Cp = 2100; % type of material for gears. Table 9-10
disp(['Elastic Coefficient: ',num2str(Cp)])

% Step 10
% *** enter the quality number
Av = 8; % Quality Number, Table 9-3
B = 0.25*(Av-5.0)^(.667);
disp(['Value for B: ',num2str(B)])
C = 50+56*(1-B);
disp(['Value for C: ',num2str(C)])
Kv = (abs(C/(C+(sqrt(vt2)))))^(-B); % Dynamic Factor, Figure 9-20
disp(['Dynamic Factor (Kv): ',num2str(Kv)])
% Step 11
% *** Tooth Form
JP = 0.43; % Figure 9-15
disp(['Bending Geometry Factor Pinion: ',num2str(JP)])
JG =  0.45; % Figure 9-15
disp(['Bending Geometry Factor Gear: ',num2str(JG)])
I = 0.104;  % Figure 9-21
disp(['Pitting Geometry Factor: ',num2str(I)])

% Step 12
% Cpf
if F<= 1
    Cpf = F/(10*DP)-0.025;
    disp(['Pinion Proportion Factor (Cpf): ',num2str(Cpf)])

elseif 1<=F<15
    Cpf = F/(10*DP)-0.0375+0.0125*F;
    disp(['Pinion Proportion Factor (Cpf): ',num2str(Cpf)])
end
% Cma
Cma= 0.127+0.0158*F-1.093*10^-4*F^2;
disp(['Mesh Alignment Factor (Cma): ',num2str(Cma)])
% Km
Km = 1+Cpf+Cma; % load distribution factor
disp(['Load Distribution Factor (Km): ',num2str(Km)])

% Step 13
Ks = 1; % Use Table 9-8

% Step 14
tR = .272;
ht = .18;
mB = tR/ht;
disp(['The Backup Ratio (mB): ',num2str(mB)])
if mB<1.2
    KB = 1.6*log(2.242/mB);
    disp(['Rim Thickness Factor: ',num2str(KB)])
else
    KB = 1;
    disp(['Rim Thickness Factor: ',num2str(KB)])
end

% Step 15
SF = 1;
disp(['Service Factor: ',num2str(SF)])

% Step 16
KR = 1.25; % Table 9-11
disp(['The Reliability Factor: ',num2str(KR)])
% Step 17
NCP = 60*20000*np % For Pinion Speed
disp(['The Pinion number of load cycles: ',num2str(NCP), ' cycles'])
NCG = 60*20000*nG1 % For Driven Speed
disp(['The Gear number of load cycles: ',num2str(NCG), ' cycles'])

% YNP
YNP = 1.3558*NCP^-0.0178;
disp(['The Bending Strength Stress Cycle (YNP): ',num2str(YNP)])
YNG =1.3558*NCG^-0.0178;
disp(['The Bending Strength Stress Cycle (YNG): ',num2str(YNG)])
% ZN
ZNP = 1.4488*NCP^-0.023;
disp(['The Pitting Stress Cycle (ZNP): ',num2str(ZNP)])
ZNG = 1.4488*NCG^-0.023;
disp(['The Pitting Stress Cycle (ZNG): ',num2str(ZNG)])

% Step 18
StP = ((Wt2*Pd)/(F*JP))*Ko*Ks*Km*KB*Kv;
disp(['The bending stress in the Pinion (Stp): ',num2str(StP),' psi'])
StG = StP*(JP/JG);
disp(['The bending stress in the Pinion (StG): ',num2str(StG),' psi'])

% Step 19
% Adjust the bending
SatP = StP*((KR*SF)/YNP);
disp(['The adjusted Bending Stress (SatP): ',num2str(SatP),' psi'])
SatG = StG*((KR*SF)/YNG);
disp(['The adjusted Bending Stress (SatG): ',num2str(SatG),' psi'])

% Step 20
% Expected Contact stress
Sc = Cp*sqrt((Wt2*Ko*Ks*Km*Kv)/(F*DP*I));
disp(['Expected Contact Stress (Sc): ',num2str(Sc),' psi'])

% Step 21
SacP = Sc*(KR*SF/ZNP);
disp(['Expected Contact Stress for Pinion (Sacp): ',num2str(SacP),' psi'])
SacG = Sc*(KR*SF/ZNG);
disp(['Expected Contact Stress for Gear (SacG): ',num2str(SacG),' psi'])
% Step 22
HBP = ((SacP/1000)-29.10)/0.322;
disp(['The required HB for pinion is (HBP): ',num2str(HBP)])
HBG = ((SacG/1000)-29.10)/0.322;
disp(['The required HB for Gear is (HBP): ',num2str(HBG)])


