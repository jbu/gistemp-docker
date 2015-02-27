FROM debian:wheezy

RUN apt-get update && apt-get install -y gfortran patch python-dev ksh wget make libnetcdf-dev && apt-get clean
ADD http://data.giss.nasa.gov/gistemp/sources_v3/GISTEMPv3_sources.tar.gz /

WORKDIR /
RUN tar fxz GISTEMPv3_sources.tar.gz && rm GISTEMPv3_sources.tar.gz && mv GISTEMP_sources gistemp && chown -R root:root gistemp
ADD run.sh /gistemp/gistemp.sh
ADD stationstringsetup.py /gistemp/STEP1/EXTENSIONS/stationstring/setup.py
ADD stationstring.patch /gistemp/STEP1/EXTENSIONS/stationstring/
ADD monthlydatasetup.py /gistemp/STEP1/EXTENSIONS/monthlydata/setup.py
ADD http://data.giss.nasa.gov/pub/gistemp/SBBX.ERSST.gz /gistemp/STEP4_5/input_files/
ADD http://data.giss.nasa.gov/gistemp/sources_v3/t_hohenpeissenberg_200306.txt /gistemp/STEP0/input_files/
WORKDIR /gistemp/STEP0/input_files
RUN wget -q ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/v3/ghcnm.tavg.latest.qca.tar.gz && tar fxz ghcnm.tavg.latest.qca.tar.gz
RUN wget -q ftp://amrc.ssec.wisc.edu/pub/aws/reconstruction/byrd_temp_recon_1957-2011.txt
WORKDIR /gistemp
RUN chmod +x gistemp.sh ; mkdir maps
ADD http://data.giss.nasa.gov/pub/gistemp/mkTsMap.f /gistemp/maps/mkTsMap.f
ADD http://data.giss.nasa.gov/pub/gistemp/SBBX_to_nc.f /gistemp/maps/SBBX_to_nc.f

