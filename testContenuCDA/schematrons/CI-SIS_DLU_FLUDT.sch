<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!-- 
    DLU_FLUDRE 
   auteur : Louis Beucherie
   version : 0.0.6 
   Ce volet décrit les données contenues dans un document de retour du service des urgences vers l'Ehpad
   ......................................................................................................................................................    
    Historique :
       06/11/17 : NMA : Création
       14/03/18 : NMA : suppression du pattern variables
       -->



<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:cda="urn:hl7-org:v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" queryBinding="xslt2" schemaVersion="CI-SIS_DLU_FLUDT.sch">
    
        <title>Rapport de conformité du document aux spécifications du volet DLU - FLUDT</title>
        <ns prefix="cda" uri="urn:hl7-org:v3"/>
        <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
        <ns prefix="jdv" uri="http://esante.gouv.fr"/>
        <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    
        <!--=<<o#%@O[ Abstract patterns ]O@%#o>>=-->
        
        <include href="abstract/dansJeuDeValeurs.sch"/>
        <include href="abstract/IVL_TS.sch"/>   
        <include href="abstract/personName20110627.sch"/>
                
        <!--Entete-->
        <include href="include/specificationsVolets/DLU/FLUDR_FLUDT/Entete/Entete_FLUDR_FLUDT.sch"/>
        
        <phase id="FLUDT">
                <!--Entete-->
                <active pattern="Entete_FLUDR_FLUDT"/>
                
        </phase>
</schema>
