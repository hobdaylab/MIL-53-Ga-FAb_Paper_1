#!/bin/bash

press="1 5 1e1 5e1 1e2 5e2 1e3 5e3 1e4 5e4 1e5 5e5 1e6 5e6 1e7 5e7 1e8"

###################################################################
all=all_files
place=rdf_files
ori=RadialDistributionFunctions/System_0
ori_mov=Movies/System_0

if [ ! -d $all ] ; then 
	mkdir ${all}
else
	rm -r ${all}/*dat
fi

if [ -d ${place} ] ; then
	rm -r ${place}/*dat
else
	mkdir ${place}
fi

hbn=${place}/hb_network

if [ -d ${hbn} ] ; then
        rm -r ${hbn}/*dat
else
	mkdir ${hbn}
fi

ads=${place}/ads_site

if [ -d ${ads} ] ; then
        rm -r ${ads}/*dat
else
	mkdir ${ads}
fi

prox=${place}/proximity

if [ -d ${prox} ] ; then
        rm -r ${prox}/*dat
else
	mkdir ${prox}
fi

mov=${all}/movies

if [ -d ${mov} ] ; then
        rm -r ${mov}/*pdb
else
	mkdir ${mov}
fi

a=1

for ix in $press ; do 

	work=${a}_press_${ix}
	cd ${work}
	rm *tip*
	cd -

	cd ${work}/Output/System_0

	grep "Current Host-Adsorbate energy:" output_* > ${a}_ener_ha.dat
	grep "Current Adsorbate-Adsorbate energy:" output_* > ${a}_ener_aa.dat	
	grep "Number of Adsorbates:" output_* > ${a}_nads.dat
	grep "total potential energy" output* > ${a}_pot.dat


	cp *dat ../../../${all}

    cd -
	
    cp ${work}/${ori}/RDF_Ow_Hw.dat ${hbn}/${a}_${ix}_OwHw.dat

    cp ${work}/${ori}/RDF_H_Ow.dat ${ads}/${a}_${ix}_HOw.dat
    cp ${work}/${ori}/RDF_O_Hw.dat ${ads}/${a}_${ix}_OHw.dat
    cp ${work}/${ori}/RDF_Ga_Ow.dat ${ads}/${a}_${ix}_GaOw.dat
    cp ${work}/${ori}/RDF_Ga_Hw.dat ${ads}/${a}_${ix}_GaHw.dat

    cp ${work}/${ori}/RDF_Framework_Hw.dat ${prox}/${a}_${ix}_FHw.dat
    cp ${work}/${ori}/RDF_Framework_Ow.dat ${prox}/${a}_${ix}_FOw.dat

    cp ${work}/${ori_mov}/Framework_0_initial.pdb ${prox}/framework.pdb
    cp ${work}/${ori_mov}/*_allcomponents.pdb ${prox}/${a}_${ix}_guests.pdb
    

    a=$((a+1))


done
