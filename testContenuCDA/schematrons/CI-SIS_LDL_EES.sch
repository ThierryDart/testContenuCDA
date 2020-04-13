<?xml version="1.0" encoding="UTF-8"?>


<!-- 
    CI-SIS_LDL.sch - ASIP/PML
   
    ......................................................................................................................................................    
    Historique :
        06/11/17 : NMA : Création
        14/03/18 : NMA : Suppression du pattern Variables
        
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="EES"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_LDL_EES.sch">
    <title>Rapport de conformité du document aux spécifications du volet LDL-EES</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    
    
    <!--  Abstract patterns  -->
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>   
    <include href="abstract/personName20110627.sch"/>
    
    <!--Entete-->
    <include href="include/specificationsVolets/LDL/EES/Entete/Entete_LDL_EES.sch"/>
    
    <phase id="EES">
        <active pattern="Entete_LDL_EES"/>
    </phase>
    
</schema>