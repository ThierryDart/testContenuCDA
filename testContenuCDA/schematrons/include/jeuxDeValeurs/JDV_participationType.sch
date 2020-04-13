<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    JDV_participationType.sch :

        Historique :
        17/02/2020 : NMA : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_participationType" is-a="dansTypeCode">
    <p>Conformité du type de participation au CI-SIS</p>
    <param name="path_jdv" value="$jdv_participationType"/>
    <param name="vue_elt" value="'ClinicalDocument/participant'"/>
    <param name="xpath_elt" value="cda:ClinicalDocument/cda:participant"/>
    <param name="nullFlavor" value="0"/>
</pattern>   
