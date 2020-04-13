<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    CI-SIS_OBP_SNM.sch - ASIP/PRAS
   
    ......................................................................................................................................................    
    Historique :
        17/10/13 : CRI : Création
        19/06/15 : JDS : Maj des include telecom20110728.sch                        -> telecom20150317.sch
        14/03/18 : NMA : MAJ du pattern Variables
        

-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="SNM-20131017"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_OBP_SNM.sch">
    <title>Rapport de conformité du document aux spécifications du volet OBP - Salle de Naissance Mère (SNM)</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    
              <!--=<<o#%@O[ Abstract patterns ]O@%#o>>=-->
    
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>   
    <include href="abstract/personName20110627.sch"/>
    
    

    <include href="include/specificationsVolets/OBP/S_activeProblem_OBP.sch"/>
    <include href="include/specificationsVolets/OBP/S_BirthOrganizer_OBP.sch"/>
    <include href="include/specificationsVolets/OBP/S_codedDetailedPhysicalExamination_OBP.sch"/>
    <include href="include/specificationsVolets/OBP/S_codedSocialHistory_OBP.sch"/>
    <include href="include/specificationsVolets/OBP/S_patientEducationAndConsents_OBP.sch"/>
    <include href="include/specificationsVolets/OBP/S_pregnancyHistoryOrganizer_OBP.sch"/>
    
    <include href="include/specificationsVolets/OBP/SNM/S_procedureIntervention_SNM.sch"/>
    <include href="include/specificationsVolets/OBP/SNM/E_problemEntry_SNM.sch"/>

    
    
                       <!--=<<o#%@O[ Value sets ]O@%#o>>=-->

    <include href="include/jeuxDeValeurs/OBP/JDV_AllergyAndIntoleranceCodes_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_MotifDeclenchementTravail_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_TypeAnesthesieAvantNaissance_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_TypeAnesthesieApresNaissance_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_TypeActePostPartum_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_ModeDebutTravail_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_ComplicationsAnesthesie_OBP.sch"/>

    
    <!--Entete-->
    
    <include href="include/specificationsVolets/OBP/Entete/Entete_OBP.sch"/>

    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Phase en vigueur            -->
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    
    <phase id="SNM-20131017">
        <active pattern="variables"/>
        <p>Vérification complète de la conformité au CI-SIS</p>
        
        <active pattern="E_problemEntry_SNM"/>
        <active pattern="S_procedureIntervention_SNM"/>
        
        <!--=<<o#%@O[ activation value sets ]O@%#o>>=-->

        <active pattern="JDV_MotifDeclenchementTravail_OBP"/>
        <active pattern="JDV_TypeAnesthesieAvantNaissance_OBP"/>
        <active pattern="JDV_TypeAnesthesieApresNaissance_OBP"/>
        <active pattern="JDV_TypeActePostPartum_OBP"/>
        <active pattern="JDV_ModeDebutTravail_OBP"/>
        <active pattern="JDV_ComplicationsAnesthesie_OBP"/>
        
        <!--Entete-->
        <active pattern="Entete_OBP"/>
        
    </phase>
    
    <pattern id="variables">

        <!-- chemins relatifs des fichiers jeux de valeurs -->
        <let name="jdv_OBP_MotifDeclenchementTravail" value="'../jeuxDeValeurs/JDV_OBP_MotifDeclenchementTravail-CISIS.xml'"/>
        <let name="jdv_OBP_TypeAnesthesieAvantNaissance" value="'../jeuxDeValeurs/JDV_OBP_TypeAnesthesieAvantNaissance-CISIS.xml'"/>
        <let name="jdv_OBP_TypeAnesthesieApresNaissance" value="'../jeuxDeValeurs/JDV_OBP_TypeAnesthesieApresNaissance-CISIS.xml'"/>
        <let name="jdv_OBP_TypeActePostPartum" value="'../jeuxDeValeurs/JDV_OBP_TypeActePostPartum-CISIS.xml'"/>
        <let name="jdv_OBP_ModeDebutTravail" value="'../jeuxDeValeurs/JDV_OBP_ModeDebutTravail-CISIS.xml'"/>
        <let name="jdv_OBP_ComplicationsAnesthesie" value="'../jeuxDeValeurs/JDV_OBP_ComplicationsAnesthesie-CISIS.xml'"/>
        
        <rule context="cda:ClinicalDocument">
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.12.2']"> 
                [CI-SIS_OBP_SNM] Le template "Synthèse Salle de Naissance Mère (SNM)" (1.2.250.1.213.1.1.1.12.2) doit être présent.
            </assert>
            
            <assert test="./cda:code[@code='15508-5' and @codeSystem='2.16.840.1.113883.6.1']"> 
                [CI-SIS_OBP_SNM] L'élément code doit avoir @code ="15508-5" et @codeSystem = "2.16.840.1.113883.6.1"/>. 
            </assert>
        </rule>
        
    </pattern>
</schema>
