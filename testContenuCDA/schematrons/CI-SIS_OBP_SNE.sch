<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    CI-SIS_OBP_SNE.sch - ASIP/PRAS
   
    ......................................................................................................................................................    
    Historique :
        17/10/13 : CRI : Création
        19/06/15 : JDS : Maj des include telecom20110728.sch                        -> telecom20150317.sch
        14/03/18 : NMA : MAJ du pattern Variables
        

-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="SNE-20131017"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_OBP_SNE.sch">
    <title>Rapport de conformité du document aux spécifications du volet OBP - Salle de Naissance Enfant (SNE)</title>
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
    
    
                       <!--=<<o#%@O[ Value sets ]O@%#o>>=-->

    <include href="include/jeuxDeValeurs/OBP/JDV_ModeNaissance_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_TypeInterventionVoieBasse_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_PresentationFoetale_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_QuantiteLA_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_AspectLA_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_CirconstancesDeces_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_GesteReanimationNN_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_routeOfAdministration_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_PrelevementsPeriph_OBP.sch"/>

    
    <!--Entete-->
    
    <include href="include/specificationsVolets/OBP/Entete/Entete_OBP.sch"/>
    
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Phase en vigueur            -->    
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    
    <phase id="SNE-20131017">
        <active pattern="variables"/>
        <p>Vérification complète de la conformité au CI-SIS</p>
        
        <active pattern="S_BirthOrganizer_OBP"/>
        <active pattern="S_activeProblem_OBP"/>
        <active pattern="S_CodedDetailedPhysicalExamination_OPB.sch"/>
        <active pattern="S_codedSocialHistory_OBP"/>
        <active pattern="S_patientEducationAndConsents_OBP"/>
        <active pattern="S_pregnancyHistoryOrganizer_OBP"/>
        
        <!--=<<o#%@O[ activation value sets ]O@%#o>>=-->
        
        <active pattern="JDV_ModeNaissance_OBP"/>
        <active pattern="JDV_TypeInterventionVoieBasse_OBP"/>
        <active pattern="JDV_PresentationFoetale_OBP"/>
        <active pattern="JDV_QuantiteLA_OBP"/>
        <active pattern="JDV_AspectLA_OBP"/>
        <active pattern="JDV_CirconstancesDeces_OBP"/>
        <active pattern="JDV_GesteReanimationNN_OBP"/>
        <active pattern="JDV_routeOfAdministration_OBP"/>
        <active pattern="JDV_PrelevementsPeriph_OBP"/>

        <!--Entete-->
        
        <active pattern="Entete_OBP"/>
    </phase>
    
       <!--=<<o#%@O[ Variables globales ]O@%#o>>=-->
    <pattern id="variables">
        
        <!-- chemins relatifs des fichiers jeux de valeurs -->

        <let name="jdv_routeOfAdministration" value="'../jeuxDeValeurs/JDV_HL7_RouteOfAdministration-CISIS.xml'"/>
        <let name="jdv_OBP_ModeNaissance" value="'../jeuxDeValeurs/JDV_OBP_ModeNaissance-CISIS.xml'"/>
        <let name="jdv_OBP_TypeInterventionVoieBasse" value="'../jeuxDeValeurs/JDV_OBP_TypeInterventionVoieBasse-CISIS.xml'"/>
        <let name="jdv_OBP_PresentationFoetale" value="'../jeuxDeValeurs/JDV_OBP_PresentationFoetale-CISIS.xml'"/>
        <let name="jdv_OBP_QuantiteLA" value="'../jeuxDeValeurs/JDV_OBP_QuantiteLA-CISIS.xml'"/>
        <let name="jdv_OBP_AspectLA" value="'../jeuxDeValeurs/JDV_OBP_AspectLA-CISIS.xml'"/>
        <let name="jdv_OBP_CirconstancesDeces" value="'../jeuxDeValeurs/JDV_OBP_CirconstancesDeces-CISIS.xml'"/>
        <let name="jdv_OBP_GesteReanimationNN" value="'../jeuxDeValeurs/JDV_OBP_GesteReanimationNN-CISIS.xml'"/>
        <let name="jdv_OBP_PrelevementsPeriph" value="'../jeuxDeValeurs/JDV_OBP_PrelevementsPeriph-CISIS.xml'"/>
        
        <rule context="cda:ClinicalDocument">
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.12.3']"> 
                [CI-SIS_OBP_SNE] Le template "Synthèse Salle de Naissance Enfant (SNE)" (1.2.250.1.213.1.1.1.12.2) doit être présent.
            </assert>
            
            <assert test="./cda:code[@code='15508-5' and @codeSystem='2.16.840.1.113883.6.1']"> 
                [CI-SIS_OBP_SNE] L'élément code doit avoir @code ="15508-5" et @codeSystem = "2.16.840.1.113883.6.1"/>. 
            </assert>
        </rule>
        
    </pattern>
</schema>