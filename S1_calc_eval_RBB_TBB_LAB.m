%%
% *************************************************************************
% *     functions: calc and compare rhos1 using RBB, TBB and LAB          *
% *     Authors:   Peiqi Yang (p.yang@njnu.edu.cn)                        *
% *     Date:      24/Dec/2022                                            *
% *     Updated:                                                          *
% *     School of Geography, Nanjing Normal University                    *
% *************************************************************************
clear; close all; clc
Temp            =   load('Sdata_short.mat');
T               =   Temp.T2;
T.wl            =   400:999;
clearvars Temp
%% calculation 
[Rveg,rhos1]      =   soil_adjusted_TOC_refl_cal(T.wl,T.rc,T.rs);
%% evaluation: grouped by using NDVI and leaf albedo
w675    =   T.rho_l(275,:)+ T.tau_l(275,:);
w675    =   ones(size(T.rs,1),size(T.rs,2)).*w675;

NDVI    =   (T.rc(370,:)-T.rc(275,:))./(T.rc(370,:)+T.rc(275,:));
NDVI    =   ones(size(T.rs,1),size(T.rs,2)).*NDVI;


%% plotting 
% 01. vectorize 
rhos1_SCOPE    =   T.rhos1(:);
rhos1_RBB      =   rhos1.RBB(:);
rhos1_TBB      =   rhos1.TBB(:);
rhos1_LAB      =   rhos1.LAB(:);
NDVI           =   NDVI(:);
w675           =   w675(:);
% 02. sampling 
lg              =   length(w675);
w675            =   w675(1:100:lg)';
rhos1_SCOPE     =   rhos1_SCOPE(1:100:lg);
rhos1_RBB       =   rhos1_RBB(1:100:lg);
rhos1_TBB       =   rhos1_TBB(1:100:lg);
rhos1_LAB       =   rhos1_LAB(1:100:lg);   
NDVI            =   NDVI(1:100:lg);

% 03. grouping
% groups: 2 leaf albedo  x 3 methods
th1         =   0.15;
ind_lo_all  =   w675<th1;
ind_hi_all  =   w675>=th1; 

NDVI_1      =   NDVI(ind_lo_all);
NDVI_2      =   NDVI(ind_hi_all);
% 2 groups for the true values
rhos1_SCOPE_w1_ndvi_all           =   rhos1_SCOPE(ind_lo_all);  % low albedo; all NDVI
rhos1_SCOPE_w2_ndvi_all           =   rhos1_SCOPE(ind_hi_all);  % high albedo; all NDVI
% 2 groups for RBB
rhos1_RBB_w1_ndvi_all           =   rhos1_RBB(ind_lo_all);
rhos1_RBB_w2_ndvi_all           =   rhos1_RBB(ind_hi_all);
% 2 groups for TBB
rhos1_TBB_w1_ndvi_all           =   rhos1_TBB(ind_lo_all);
rhos1_TBB_w2_ndvi_all           =   rhos1_TBB(ind_hi_all);
% 2 groups for LAB
rhos1_LAB_w1_ndvi_all           =   rhos1_LAB(ind_lo_all);
rhos1_LAB_w2_ndvi_all           =   rhos1_LAB(ind_hi_all);

% 04. stats (not included)

% 05. structure
xdata_struct={rhos1_SCOPE_w2_ndvi_all,rhos1_SCOPE_w1_ndvi_all,rhos1_SCOPE_w2_ndvi_all,rhos1_SCOPE_w1_ndvi_all,rhos1_SCOPE_w2_ndvi_all,rhos1_SCOPE_w1_ndvi_all};
ydata_struct={rhos1_RBB_w2_ndvi_all,rhos1_RBB_w1_ndvi_all,rhos1_TBB_w2_ndvi_all,rhos1_TBB_w1_ndvi_all,rhos1_LAB_w2_ndvi_all,rhos1_LAB_w1_ndvi_all};
zdata_struct={NDVI_2,NDVI_1,NDVI_2,NDVI_1,NDVI_2,NDVI_1};
methodtxt   = {'a)','b)','c)','d)','e)','f)'};
clearvars -except x y xdata_struct ydata_struct zdata_struct methodtxt

% 06. plotting
figure(1)
set(gcf,'units','centimeters','position',[3,3,14,20])
for jj=1:6
subplot(3,2,jj);
scatter(xdata_struct{jj}, ydata_struct{jj}, 10, zdata_struct{jj},'filled');
box on;   hold on;
xlim([0,0.4]);ylim([0,0.4])
caxis([0 1])
text(0.35,0.36,methodtxt{jj},'color','k')
end 

% notations
subplot(3,2,1);
title('RBB, $\omega_l(675)>0.15$','color','blue','interpreter','latex')
ylabel('estimated $\rho_s^1$','interpreter','latex')
subplot(3,2,2);
title('RBB, $\omega_l(675)\le0.15$','color','blue','interpreter','latex')
subplot(3,2,3);
title('TBB, $\omega_l(675)>0.15$','color','blue','interpreter','latex')
ylabel('estimated $\rho_s^1$','interpreter','latex')
subplot(3,2,4);
title('TBB, $\omega_l(675)\le0.15$','color','blue','interpreter','latex')
subplot(3,2,5);
title('LAB, $\omega_l(675)>0.15$','color','blue','interpreter','latex')
ylabel('estimated $\rho_s^1$','interpreter','latex')
xlabel('true $\rho_s^1$','interpreter','latex')
subplot(3,2,6);
title('LAB, $\omega_l(675)\le0.15$','color','blue','interpreter','latex')
xlabel('true $\rho_s^1$','interpreter','latex')

cl          =   colorbar;
set(cl,'location','southoutside')
set(cl,'position',[0.3,0.05,0.4,0.03])
ylabel(cl,'NDVI','interpreter','latex')
