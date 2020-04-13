<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    CI-SIS_OBP_SNE.sch - ASIP/PRAS
   
    ......................................................................................................................................................    
    Historique :
        17/10/13 : CRI : Création
        19/06/15 : JDS : Maj des include telecom20110728.sch                        -> telecom20150317.sch
        14/03/18 : NMA : MAJ du pattern Variables
        

-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="SCE-20131017"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_OBP_SCE.sch">
    <title>Rapport de conformité du document aux spécifications du volet OBP - Suites de Couches Enfant (SCE)</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    
              <!--=<<o#%@O[ Abstract patterns ]O@%#o>>=-->
    
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>   
    <include href="abstract/personName20110627.sch"/>
    
    <include href="include/specificationsVolets/OBP/S_BirthOrganizer_OBP.sch"/>
    <include href="include/specificationsVolets/OBP/S_activeProblem_OBP.sch"/>
    <include href="include/specificationsVolets/OBP/S_codedDetailedPhysicalExamination_OBP.sch"/>
    <include href="include/specificationsVolets/OBP/S_codedSocialHistory_OBP.sch"/>
    <include href="include/specificationsVolets/OBP/S_patientEducationAndConsents_OBP.sch"/>
    <include href="include/specificationsVolets/OBP/S_pregnancyHistoryOrganizer_OBP.sch"/>
    <include href="include/specificationsVolets/OBP/S_procedureEntry_OBP.sch"/>
    
                       <!--=<<o#%@O[ Value sets ]O@%#o>>=-->
    
    <include href="include/jeuxDeValeurs/OBP/JDV_LesionTraumatiqueObstetricale_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_routeOfAdministration_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_TypePortageAgentInfectieux_OBP.sch"/>
    <include href="include/jeuxDeValeurs/CSE/JDV_CertDiag_CSE.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_TypeInfectionNN_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_ModeSortie_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_TypeAllaitementNN_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_StaticSCEprocedures_OBP.sch"/>

    <!--Entete-->
    
    <include href="include/specificationsVolets/OBP/Entete/Entete_OBP.sch"/>
    
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Phase en vigueur            -->    
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    
    <phase id="SCE-20131017">
        <active pattern="variables"/>
        <p>Vérification complète de la conformité au CI-SIS</p>

        <active pattern="S_BirthOrganizer_OBP"/>
        <active pattern="S_activeProblem_OBP"/>
        <active pattern="S_CodedDetailedPhysicalExamination_OPB.sch"/>
        <active pattern="S_codedSocialHistory_OBP"/>
        <active pattern="S_patientEducationAndConsents_OBP"/>
        <active pattern="S_pregnancyHistoryOrganizer_OBP"/>
        <active pattern="S_procedureEntry_OBP"/>
      
        <!--=<<o#%@O[ activation value sets ]O@%#o>>=-->
        <active pattern="JDV_LesionTraumatiqueObstetricale_OBP"/>
        <active pattern="JDV_routeOfAdministration_OBP"/>
        <active pattern="JDV_TypePortageAgentInfectieux_OBP"/>
        <active pattern="JDV_CertDiag_CSE"/>
        <active pattern="JDV_TypeInfectionNN_OBP"/>
        <active pattern="JDV_ModeSortie_OBP"/>
        <active pattern="JDV_TypeAllaitementNN_OBP"/>
        <active pattern="JDV_StaticSCEprocedures_OBP"/>
        
        <!--Entete-->
        <active pattern="Entete_OBP"/>
        
    </phase>
    
       <!--=<<o#%@O[ Variables globales ]O@%#o>>=-->

    <pattern id="variables">
        <let name="jdv_OBP_LesionTraumatiqueObstetricale" value="'../jeuxDeValeurs/JDV_OBP_LesionTraumatiqueObstetricale-CISIS.xml'"/>
        <let name="jdv_routeOfAdministration" value="'../jeuxDeValeurs/JDV_HL7_RouteOfAdministration-CISIS.xml'"/>
        <let name="jdv_OBP_TypePortageAgentInfectieux" value="'../jeuxDeValeurs/JDV_OBP_TypePortageAgentInfectieux-CISIS.xml'"/>
        <let name="jdv_CSE_CertDiag" value="'../jeuxDeValeurs/JDV_CertitudeDiagnostic-CISIS.xml'"/>
        <let name="jdv_OBP_TypeInfectionNN" value="'../jeuxDeValeurs/JDV_OBP_TypeInfectionNN-CISIS.xml'"/>
        <let name="jdv_OBP_ModeSortie" value="'../jeuxDeValeurs/JDV_OBP_ModeSortie-CISIS.xml'"/>
        <let name="jdv_OBP_TypeAllaitementNN" value="'../jeuxDeValeurs/JDV_OBP_TypeAllaitementNN-CISIS.xml'"/>
        <let name="jdv_OBP_StaticSCEprocedures" value="'../jeuxDeValeurs/JDV_OBP_StaticSCEprocedures-CISIS.xml'"/>
        
        <rule context="cda:ClinicalDocument">
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.12.5']"> 
                [CI-SIS_OBP_SCE] Le template "Synthèse Suites de Couches Enfant (SNE)" (1.2.250.1.213.1.1.1.12.5) doit être présent.
            </assert>
            
            <assert test="./cda:code[@code='15508-5' and @codeSystem='2.16.840.1.113883.6.1']"> 
                [CI-SIS_OBP_SCE] L'élément code doit avoir @code ="15508-5" et @codeSystem = "2.16.840.1.113883.6.1"/>. 
            </assert>
        </rule>
    </pattern>
</schema>
