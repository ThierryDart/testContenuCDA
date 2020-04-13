<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    CI-SIS_SDMMR.sch - ASIP/PRAS
   
    ......................................................................................................................................................    
    Historique :
        17/10/17 : NMA : Création
        14/03/18 : NMA : Maj du pattern variables
        
        
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_SDMMR.sch">
    
    <title>Rapport de conformité du document aux spécifications du volet SDMMR</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    
    <!--=<<o#%@O[ Abstract patterns ]O@%#o>>=-->
    
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>
    <include href="abstract/personName20110627.sch"/>
    
    <include href="include/jeuxDeValeurs/SDMMR/JDV_Age_SDMMR.sch"/>
    <include href="include/jeuxDeValeurs/SDMMR/JDV_AppreciationDiagnosticEntree_SDMMR.sch"/>
    <include href="include/jeuxDeValeurs/SDMMR/JDV_CasSporadiqueFamilial_SDMMR.sch"/>
    <include href="include/jeuxDeValeurs/SDMMR/JDV_MalformationAntenatale_SDMMR.sch"/>
    <include href="include/jeuxDeValeurs/SDMMR/JDV_ModeConfirmationDiagnostic_SDMMR.sch"/>
    <include href="include/jeuxDeValeurs/SDMMR/JDV_ObjectifActivite_SDMMR.sch"/>
    <include href="include/jeuxDeValeurs/SDMMR/JDV_PatientAdressePar_SDMMR.sch"/>
    <include href="include/jeuxDeValeurs/SDMMR/JDV_StatutActuelDiagnostic_SDMMR.sch"/>
    <include href="include/jeuxDeValeurs/SDMMR/JDV_ContexteActivite_SDMMR.sch"/>
    <include href="include/jeuxDeValeurs/SDMMR/JDV_TechniquesDiagnostic_SDMMR.sch"/>
    <include href="include/jeuxDeValeurs/SDMMR/JDV_InvestigationsRealisees_SDMMR.sch"/>
    <include href="include/jeuxDeValeurs/SDMMR/JDV_ProfessionPersonnelActivite_SDMMR.sch"/>
    
    <!--Entete-->
    
    <include href="include/specificationsVolets/SDM-MR/Entete/Entete_SDMMR.sch"/>
    
    
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Phase en vigueur            -->
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    
    <phase id="SDMMR">
        <active pattern="variables"/>
        <active pattern="JDV_Age_SDMMR"/>
        <active pattern="JDV_AppreciationDiagnosticEntree_SDMMR"/>
        <active pattern="JDV_CasSporadiqueFamilial_SDMMR"/>
        <active pattern="JDV_MalformationAntenatale_SDMMR"/>
        <active pattern="JDV_ModeConfirmationDiagnostic_SDMMR"/>
        <active pattern="JDV_ObjectifActivite_SDMMR"/>
        <active pattern="JDV_PatientAdressePar_SDMMR"/>
        <active pattern="JDV_StatutActuelDiagnostic_SDMMR"/>
        <active pattern="JDV_ContexteActivite_SDMMR"/>
        <active pattern="JDV_TechniquesDiagnostic_SDMMR"/>
        <active pattern="JDV_InvestigationsRealisees_SDMMR"/>
        <active pattern="JDV_ProfessionPersonnelActivite_SDMMR"/>

        <!--Entete-->
        <active pattern="Entete_SDMMR"/>
        
    </phase>
    <pattern id="variables">
        <let name="jdv_Age" value="'../jeuxDeValeurs/JDV_Age-CISIS.xml'"/>
        <let name="jdv_AppreciationDiagnosticEntree" value="'../jeuxDeValeurs/JDV_AppreciationDiagnosticCentre-CISIS.xml'"/>
        <let name="jdv_CasSporadiqueFamilial" value="'../jeuxDeValeurs/JDV_CasSporadiqueFamilial-CISIS.xml'"/>
        <let name="jdv_MalformationAntenatale" value="'../jeuxDeValeurs/JDV_MalformationAntenatale-CISIS.xml'"/>
        <let name="jdv_ModeConfirmationDiagnostic" value="'../jeuxDeValeurs/JDV_InvestigationsRealisees-CISIS'"/>
        <let name="jdv_ObjectifActivite" value="'../jeuxDeValeurs/JDV_ObjectifActivite-CISIS.xml'"/>
        <let name="jdv_StatutActuelDiagnostic" value="'../jeuxDeValeurs/JDV_StatutActuelDiagnostic-CISIS.xml'"/>
        <let name="jdv_PatientAdressePar" value="'../jeuxDeValeurs/JDV_PatientAdressePar-CISIS.xml'"/>
        <let name="jdv_ContexteActivite" value="'../jeuxDeValeurs/JDV_ContexteActivite-CISIS.xml'"/>
        <let name="jdv_TechniquesDiagnostic" value="'../jeuxDeValeurs/JDV_TechniquesDiagnostic-CISIS.xml'"/>
        <let name="jdv_InvestigationsRealisees" value="'../jeuxDeValeurs/JDV_InvestigationsRealisees-CISIS.xml'"/>
        <let name="jdv_ProfessionPersonnelActivite" value="'../jeuxDeValeurs/JDV_ProfessionPersonnelActivite-CISIS.xml'"/>
        
        <rule context="cda:ClinicalDocument">
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.30']"> 
                [CI-SIS_SDMMR] Le template "Conformité à la SDMMR (Set de Données Minimum Maladies Rares)" (1.2.250.1.213.1.1.1.30) doit être présent.
            </assert>
            <assert test="./cda:code[@code='34133-9' and @codeSystem='2.16.840.1.113883.6.1']"> 
                [CI_SIS_SDMMR] L'élément code doit avoir @code ="34133-9" et @codeSystem = "2.16.840.1.113883.6.1"/>. 
            </assert>
        </rule>
    </pattern>
</schema>