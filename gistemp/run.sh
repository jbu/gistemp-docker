#!/bin/bash

export PATH=.:$PATH
export FC=/usr/bin/gfortran
cd /gistemp/STEP0/input_files
ln ghcnm.v3.*/*.dat adj_data
do_corr_id2
#./add_in_byrd.ksh
cd /gistemp/STEP0
sed 's/export FC=.*$//' < do_comb_step0.sh > o && mv o do_comb_step0.sh 
sed 's/tail +100/tail -n+100/' < do_comb_step0.sh > o && mv o do_comb_step0.sh
chmod +x do_comb_step0.sh
do_comb_step0.sh
mv temp_files /gistemp/STEP1/.
cd ../STEP1/EXTENSIONS/stationstring
patch -R stationstringmodule.c < stationstring.patch
python setup.py install
cd ../monthlydata
python setup.py install
cd /gistemp/STEP1
do_comb_step1.sh v3.mean_comb
mv temp_files ../STEP2/.
cd ../STEP2
do_comb_step2.sh 2013
mv temp_files ../STEP3/.
cd ../STEP3
do_comb_step3.sh

cd ../maps
gfortran -fconvert=big-endian SBBX_to_nc.f -o SBBX_to_nc.exe -lnetcdf -lnetcdff -I/usr/include
mv ../STEP3/work_files/SBBX1880.Ts.GHCN.CL.PA.1200 TS1200_DATA
mv ../STEP4_5/input_files/SBBX.ERSST.gz . ; gunzip SBBX.ERSST.gz; mv SBBX.ERSST ERSST_DATA
#SBBX_to_nc.exe 1200 3 1880 2014 12 gistemp1200_ERSST.nc
#http://data.giss.nasa.gov/cgi-bin/gistemp/nmaps.cgi?sat=4&sst=0&type=anoms&mean_gen=0112&year1=2014&year2=2014&base1=1951&base2=1980&radius=1200&pol=rob


# Ignore the next steps - don't achieve much more here.
#mv temp_files/SBBX1880.Ts.GHCN.CL.PA.1200 ../STEP4_5/input_files/
#cd ../STEP4_5
#cd input_files && gunzip SBBX.ERSST.gz && cd ..
#export GFORTRAN_CONVERT_UNIT=BIG_ENDIAN
#sed 's/^zonav /$FC zonav.f -o zonav\nzonav /' < do_comb_step5.sh > o && mv o do_comb_step5.sh && chmod +x do_comb_step5.sh
#./do_comb_step5.sh
#cat results/GLB.Ts.ho2.GHCN.CL.PA.txt

