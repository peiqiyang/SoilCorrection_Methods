%%
% *************************************************************************
% *     functions: compute soil-adjusted canopy reflectance               *
% *     Authors:   Peiqi Yang (p.yang@njnu.edu.cn)                        *
% *     Date:      1/June/2023                                            *
% *     Updated:   1/June/2023                                            *
% *     School of Geography, Nanjing Normal University                    *
% *************************************************************************

function [Rveg,rhos1]      =   soil_adjusted_TOC_refl_cal(wl,Rcanopy,Rsoil)
% inputs: wl        =   wavelengths in nm, covering 400-1000nm  [1,nwl]
%         Rsoil     =   soil reflectance [nwl,nmeas]
%         Rcanopy   =   canopy reflectance [nwl,nmeas]
% outputs: Rveg    =   soil-adjusted canopy reflectance with various approaches
%         rhos1    =   contribution of direct soil reflection to TOC refl.

%% prepare for calculation
nwl             =   length(wl);                 % # of bands
if size(Rsoil,1) ~=  nwl
    Rsoil        =   Rsoil';                    % make refl as [nwl,nmeas];
end
if size(Rcanopy,1) ~=  nwl
    Rcanopy        =   Rcanopy';                % make refl as [nwl,nmeas];
end

% identify two key bands
[d675,i675]            =   min(abs(wl-675));
[d438,i438]            =   min(abs(wl-438));
% some preparation
if d675>20|| d438>50        % wider bands   
    disp('could find the bands for estimating rhos1')
    return
end

if i438<5                  % avioding large noise close to edge of CCD
    i438 = i438+5;
end

% get soil and canopy reflectance at the key bands
Rs_675              =   Rsoil(i675,:);      % soil reflectance at specific bands
Rs_438              =   Rsoil(i438,:);
Rc_675              =   Rcanopy(i675,:);     % canopy reflectance at specific bands
Rc_438              =   Rcanopy(i438,:);

%% soil adjusted TOC reflectance
% Method RBB - red reflectance; green vegetation
Pso_1a              =   (Rc_675./Rs_675);                                                           % red_canopy./red_soil; assuming leaf albedo is 0 at this band
Pso_1a(Pso_1a>1)    =   nan;                                                                        % constraints
rho_soil_1a         =   Rsoil.*Pso_1a;                                                              % direct reflection from soil to canopy signals
R_veg_1a            =   Rcanopy-rho_soil_1a;                                                        % 'pure' vegetation reflectance
R_veg_1a(R_veg_1a<0)=   nan;                                                                        % constraints

%  METHOD TBB - blue and red reflectance, similar absorption at two bands
Pso_2a              =   (Rc_675-Rc_438)./(Rs_675-Rs_438);
Pso_2a(Pso_2a>1)    =   nan;
rho_soil_2a         =   Rsoil.*Pso_2a;
R_veg_2a            =   Rcanopy-rho_soil_2a;
R_veg_2a(R_veg_2a<0)=   nan;

%  METHOD LAB - no soil reflectance is used; Rsoil = k x lambda+b
rho_soil_3a          =   Rc_675+(wl'-675)/237.*(Rc_675-Rc_438);
R_veg_3a             =   Rcanopy-rho_soil_3a;
R_veg_3a(R_veg_3a<0) =   nan;

Rveg.RBB    = R_veg_1a;
Rveg.TBB    = R_veg_2a;
Rveg.LAB    = R_veg_3a;
rhos1.RBB   = rho_soil_1a;
rhos1.TBB   = rho_soil_2a;
rhos1.LAB   = rho_soil_3a;
