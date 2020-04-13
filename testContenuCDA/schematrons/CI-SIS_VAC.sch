<?xml version="1.0" encoding="UTF-8"?>

<!-- 
   ......................................................................................................................................................
   Schématron VAC - Vérification de la conformité au Volet Vaccination 
   version : 3.0 
   ......................................................................................................................................................    
    Historique :
       03/10/2017 : Création
       14/03/2018 : MAJ du pattern variables
       02/09/2019 : Modification du code du document en 11369-6 Historique de vaccinations, modification des noms des JDV
       -->

<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="vac"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_VAC.sch">
    <title>Rapport de conformité du document aux spécifications du volet Vaccination</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    
<!--    <extends href="profils/IHE_XDS-SD.sch"/>
    <extends href="profils/CI-SIS_StructurationMinimale.sch"/>
    <extends href="profils/IHE_PCC.sch"/>
    <extends href="profils/ModelesDeContenuCDA.sch"/>
    <extends href="profils/ModelesASIP.sch"/>-->


    <!--=<<o#%@O[ Abstract patterns ]O@%#o>>=-->
    
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>   
    <include href="abstract/personName20110627.sch"/>
    
    
    <!--=<<o#%@O[ JDV ]O@%#o>>=-->
    <include href="include/jeuxDeValeurs/VAC/JDV_UsageDrogues-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/VAC/JDV_ProfessionsExposees-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/VAC/JDV_vieEnCollectivite-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/VAC/JDV_RisquePourUsager-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/VAC/JDV_RisquePourEntourage-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/VAC/JDV_AllergiesVaccins-CISIS.sch"/>
    
    <!--Entete-->
    
    <include href="include/specificationsVolets/VAC/Entete/Entete_VAC.sch"/>
    
    <phase id="vac">
        <active pattern="variables"/>
        <active pattern="JDV_UsageDrogues-CISIS"/>
        <active pattern="JDV_ProfessionsExposees-CISIS"/>
        <active pattern="JDV_vieEnCollectivite-CISIS"/>
        <active pattern="JDV_RisquePourUsager-CISIS"/>
        <active pattern="JDV_RisquePourEntourage-CISIS"/>
        <active pattern="JDV_AllergiesVaccins-CISIS"/>

        <!--Entete-->
        <active pattern="Entete_VAC"/>
    </phase>

    <!--=<<o#%@O[ Variables globales ]O@%#o>>=-->

    <pattern id="variables">
        
        <!-- chemins relatifs des fichiers jeux de valeurs -->
        <let name="jdv_AllergyAndIntoleranceCodes" value="'../jeuxDeValeurs/JDV_HL7_ObservationIntoleranceType-CISIS.xml'"/>
        <let name="JDV_UsageDrogues-CISIS" value="'../jeuxDeValeurs/JDV_UsageDrogues-CISIS.xml'"/>
        <let name="JDV_ProfessionsExposees-CISIS" value="'../jeuxDeValeurs/JDV_ProfessionsExposees-CISIS.xml'"/>
        <let name="JDV_AllergiesVaccins-CISIS" value="'../jeuxDeValeurs/JDV_AllergiesVaccins-CISIS.xml'"/>
        <let name="JDV_vieEnCollectivite-CISIS" value="'../jeuxDeValeurs/JDV_vieEnCollectivite-CISIS.xml'"/>
        <let name="JDV_RisquePourUsager-CISIS" value="'../jeuxDeValeurs/JDV_RisquePourUsager-CISIS.xml'"/>
        <let name="JDV_RisquePourEntourage-CISIS" value="'../jeuxDeValeurs/JDV_RisquePourEntourage-CISIS.xml'"/>

        <rule context="cda:ClinicalDocument">
            
            <assert test="./cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.1.18.1.2']"> 
                [CI-SIS_VAC] Erreur de conformité PCC : le templateId "1.3.6.1.4.1.19376.1.5.3.1.1.18.1.2" est obligatoire.
            </assert>
            
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.10']"> 
                [CI-SIS_VAC] Erreur de conformité Volet Vaccination : le templateId "1.2.250.1.213.1.1.1.10" est obligatoire.
            </assert>
            
            <assert test="./cda:code[@code='11369-6' and @codeSystem='2.16.840.1.113883.6.1']"> 
                [CI-SIS_VAC] Erreur de conformité Volet Vaccination : l'élément code doit être @code ="11369-6" et @codeSystem = "2.16.840.1.113883.6.1". 
            </assert>
        </rule>
    </pattern>
</schema>
