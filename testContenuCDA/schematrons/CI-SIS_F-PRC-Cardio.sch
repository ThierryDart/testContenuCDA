<?xml version="1.0" encoding="UTF-8"?>
<!-- 

-=-=-=-=-=-=<<ox#%@OOX//[ CI-SIS_PatientsARisquesCardio.sch - ASIP/PRAS ]\\XO@%#xo>>=-=-=-=-=-=-
    
    Vérification de la conformité sémantique au volet Patients à Risques de Cardiologie du CI-SIS.
    
    Historique :
    
    24/06/11 : CRI : Adaptation du module initial CI-SIS_StructurationCommuneCDAr2.sch pour le volet 
    "Certificats de Santé de l'Enfant" (composant CS8) du CI-SIS de l'ASIP.
    01/08/11 : CRI : Ajout des spécificités et contraintes du volet du CI-SIS 
    "Patients à Risques de Cardiologie"
    08/10/12 : FMY : CI-SIS 1.3 => retrait des include assignedAuthor, confidentialityCode et custodianOrganization. 
                     Maj des include assignedEntity (addr & telecom optionnels) et addr (contrôle structure des adresses)       
                     Prise en compte de la bonne version de l'include codedVitalSigns
                     Suppression des accents du nom du fichier UFCV_DispositifMedicalImplanteOrg20110826.sch
                     Actualisation nom de fichiers include problemEntry, concernentry, procedureentry 
    19/06/15 : JDS : Maj des include telecom20110728.sch                        -> telecom20150317.sch
    14/03/18 : NMA : MAJ du pattern Variables
-->

<schema xmlns="http://purl.oclc.org/dsdl/schematron"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_F-PRC-Cardio.sch">
    <title>Rapport de conformité du document aux spécifications du volet Fiches Patient à risque en cardiologie (F-PRC)</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>

    <!--=<<o#%@OX//[ Abstract patterns ]\\XO@%#o>>=-->
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>   
    <include href="abstract/personName20110627.sch"/>
    
    
    <!--Patterns spécifiques au volet-->
    <include href="include/specificationsVolets/UFCV/entrees/E_AllergiesAndIntolerances_UFCV.sch"/>
    <include href="include/specificationsVolets/UFCV/entrees/E_DefibrillateurOrg_UFCV.sch"/>
    <include href="include/specificationsVolets/UFCV/entrees/E_DispositifMedicalImplanteOrg_UFCV.sch"/>
    <include href="include/specificationsVolets/UFCV/entrees/E_EndoprotheseOrg_UFCV.sch"/>
    <include href="include/specificationsVolets/UFCV/entrees/E_ProtheseValvulaireOrg_UFCV.sch"/>
    <include href="include/specificationsVolets/UFCV/entrees/E_SondeDefOrg_UFCV.sch"/>
    <include href="include/specificationsVolets/UFCV/entrees/E_SondeStimOrg_UFCV.sch"/>
    <include href="include/specificationsVolets/UFCV/entrees/E_StimulateurOrg_UFCV.sch"/>
    
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Phase en vigueur            -->
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    
    <phase id="UFCV">
        
        <active pattern="E_AllergiesAndIntolerances_UFCV"/>
        <active pattern="E_DefribrillateurOrg_UFCV"/>
        <active pattern="E_DispositifMédicalImplanteOrg_UFCV"/>
        <active pattern="E_EndoprotheseOrg_UFCV"/>
        <active pattern="E_ProtheseValvulaireOrg_UFCV"/>
        <active pattern="E_SondeDefOrg_UFCV"/>
        <active pattern="E_SondeStimOrg_UFCV"/>
        <active pattern="E_StimulateurOrg_UFCV"/>
        
    </phase>

</schema>
