<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    DLU_FLUDT 
   auteur : Louis Beucherie
   version : 0.0.6 
   Ce volet décrit les données contenues dans un document de liaison d'urgence
   ......................................................................................................................................................    
    Historique :
       12/12/2016 : LBE : Création
       14/03/2018 : NMA : MAJ du pattern variables
       -->


<schema xmlns="http://purl.oclc.org/dsdl/schematron"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_DLU_DLU.sch">
    
	<title>Rapport de conformité du document aux spécifications du volet DLU</title>
        <ns prefix="cda" uri="urn:hl7-org:v3"/>
        <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
        <ns prefix="jdv" uri="http://esante.gouv.fr"/>
        <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    

	<!--=<<o#%@O[ Abstract patterns ]O@%#o>>=-->
	
	<include href="abstract/dansJeuDeValeurs.sch"/>
	<include href="abstract/IVL_TS.sch"/>   
	<include href="abstract/personName20110627.sch"/>
	
	<include href="include/jeuxDeValeurs/DLU/JDV_CheckListDLU_DLU.sch"/>
	
	<!--Entete-->
	
	<include href="include/specificationsVolets/DLU/DLU/Entete/Entete_DLU.sch"/>
	
	<phase id="DLU">
		<active pattern="variables"/>
		<active pattern="JDV_CheckListDLU_DLU"/>

		<!--Entete-->
		<active pattern="Entete_DLU"/>
		
	</phase>
	<pattern id="variables">
		<!--variable des jeux de valeurs -->
		<let name="JDV_CheckListDLU_DLU" value = "'../jeuxDeValeurs/JDV_ChecklistDLU-CISIS.xml'"/>
		
	</pattern>
</schema>
