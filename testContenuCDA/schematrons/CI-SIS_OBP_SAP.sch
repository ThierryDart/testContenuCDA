<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    CI-SIS_OBP_SAP.sch - ASIP/PRAS
   
    ......................................................................................................................................................    
    Historique :
        17/10/13 : CRI : Création
        19/06/15 : JDS : Maj des include telecom20110728.sch                        -> telecom20150317.sch
                         Modification du schematron codedListOfSurgeries20120718.sch -> codedListOfSurgeries20150319.sch
        12/10/17 : NMA : Mise à niveau par rapport à la V2 du testContenuCDA
        14/03/18 : NMA : MAJ du pattern Variables
        

-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="SAP-20131017"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_OBP_SAP.sch">
    <title>Rapport de conformité du document aux spécifications du volet OBP - Synthèse Antepartum (SAP)</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    
              <!--=<<o#%@O[ Abstract patterns ]O@%#o>>=-->
    
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>   
    <include href="abstract/personName20110627.sch"/>
    
     
    <!--=<<o#%@O[  Checkup des entrées obligatoires ]O@%#o>>=-->
    
    <include href="include/specificationsVolets/OBP/S_BirthOrganizer_OBP.sch"/>
    <include href="include/specificationsVolets/OBP/S_activeProblem_OBP.sch"/>
    <include href="include/specificationsVolets/OBP/S_codedDetailedPhysicalExamination_OBP.sch"/>
    <include href="include/specificationsVolets/OBP/S_codedSocialHistory_OBP.sch"/>
    <include href="include/specificationsVolets/OBP/S_patientEducationAndConsents_OBP.sch"/>
    <include href="include/specificationsVolets/OBP/S_pregnancyHistoryOrganizer_OBP.sch"/>
    <include href="include/specificationsVolets/OBP/S_procedureEntry_OBP.sch"/>

                       <!--=<<o#%@O[ Value sets ]O@%#o>>=-->
    
    <include href="include/jeuxDeValeurs/OBP/JDV_AllergyAndIntoleranceCodes_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_IssueGrossesse_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_StaticSAPActiveProblem_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_EtatP%C3%A9rin%C3%A9e_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_IssueAccouchement_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_EtatNaissance_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_TranfertMutation_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_GroupeRhesus_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_AnomalieCroissance_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_AnomalieConstitutionnelle_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_HTAGravidique_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_DiabeteGrossesse_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_InfectUrinaire_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_InfectCervicoVaginale_OBP.sch"/>
    <include href="include/jeuxDeValeurs/OBP/JDV_TrimestreGrossesse_OBP.sch"/>

    
    <include href="include/jeuxDeValeurs/OBP/JDV_AntecedentsObstetricaux_OBP.sch"/><!--
    <include href="include/jeuxDeValeurs/OBP/JDV_ObservationEnfant_OBP.sch"/>-->
    
    <!--Entete-->
    
    <include href="include/specificationsVolets/OBP/Entete/Entete_OBP.sch"/>
    
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Phase en vigueur            -->    
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    
    <phase id="SAP-20131017">
        <active pattern="variables"/>
        <p>Vérification complète de la conformité au CI-SIS</p>

        
        <!--=<<o#%@O[ activation Checkup Entrées ]O@%#o>>=-->
        
        <active pattern="S_BirthOrganizer_OBP"/>
        <active pattern="S_activeProblem_OBP"/>
        <active pattern="S_CodedDetailedPhysicalExamination_OPB.sch"/>
        <active pattern="S_codedSocialHistory_OBP"/>
        <active pattern="S_patientEducationAndConsents_OBP"/>
        <active pattern="S_pregnancyHistoryOrganizer_OBP"/>
        <active pattern="S_procedureEntry_OBP"/>
        
        
        <!--=<<o#%@O[ activation value sets ]O@%#o>>=-->
        

        <active pattern="JDV_AllergyAndIntoleranceCodes_OBP"/>
        <active pattern="JDV_IssueGrossesse_OBP"/>
        <active pattern="JDV_StaticSAPActiveProblem_OBP"/>
        <active pattern="JDV_EtatPérinée_OBP"/>
        <active pattern="JDV_IssueAccouchement_OBP"/>
        <active pattern="JDV_EtatNaissance_OBP"/>
        <active pattern="JDV_TranfertMutation_OBP"/>
        <active pattern="JDV_GroupeRhesus_OBP"/>
        <active pattern="JDV_AnomalieCroissance_OBP"/>
        <active pattern="JDV_AnomalieConstitutionnelle_OBP"/>
        <active pattern="JDV_HTAGravidique_OBP"/>
        <active pattern="JDV_DiabeteGrossesse_OBP"/>
        <active pattern="JDV_InfectUrinaire_OBP"/>
        <active pattern="JDV_InfectCervicoVaginale_OBP"/>
        <active pattern="JDV_TrimestreGrossesse_OBP"/>
        
        <active pattern="JDV_AntecedentsObstetricaux_OBP"/><!--
        <active pattern="JDV_ObservationEnfant_OBP"/>-->
        
        <!--Entete-->
        
        <active pattern="Entete_OBP"/>
        
    </phase>

    
       <!--=<<o#%@O[ Variables globales ]O@%#o>>=-->


    <pattern id="variables">
        
        <!-- chemins relatifs des fichiers jeux de valeurs -->
        <let name="jdv_AllergyAndIntoleranceCodes" value="'../jeuxDeValeurs/JDV_HL7_ObservationIntoleranceType-CISIS.xml'"/>
        <let name="jdv_OBP_IssueGrossesse" value="'../jeuxDeValeurs/JDV_IssueGrossesse-CISIS.xml'"/>
        <let name="jdv_OBP_StaticSAPActiveProblem" value="'../jeuxDeValeurs/JDV_OBP_StaticSAPActiveProblem-CISIS.xml'"/>
        <let name="jdv_OBP_EtatPérinée" value="'../jeuxDeValeurs/JDV_EtatPerinee-CISIS.xml'"/>
        <let name="jdv_OBP_IssueAccouchement" value="'../jeuxDeValeurs/JDV_OBP_IssueAccouchement-CISIS.xml'"/>
        <let name="jdv_OBP_EtatNaissance" value="'../jeuxDeValeurs/JDV_EtatNaissance-CISIS.xml'"/>
        <let name="jdv_OBP_TranfertMutation" value="'../jeuxDeValeurs/JDV_TransfertMutation-CISIS.xml'"/>
        <let name="jdv_GroupeRhesus" value="'../jeuxDeValeurs/JDV_GroupeRhesus-CISIS.xml'"/>
        <let name="jdv_OBP_AnomalieCroissance" value="'../jeuxDeValeurs/JDV_OBP_AnomalieCroissance-CISIS.xml'"/>
        <let name="jdv_OBP_AnomalieConstitutionnelle" value="'../jeuxDeValeurs/JDV_OBP_AnomalieConstitutionnelle-CISIS.xml'"/>
        <let name="jdv_OBP_HTAGravidique" value="'../jeuxDeValeurs/JDV_OBP_HTAGravidique-CISIS.xml'"/>
        <let name="jdv_OBP_DiabeteGrossesse" value="'../jeuxDeValeurs/JDV_OBP_DiabeteGrossesse-CISIS.xml'"/>
        <let name="jdv_OBP_InfectUrinaire" value="'../jeuxDeValeurs/JDV_OBP_InfectUrinaire-CISIS.xml'"/>
        <let name="jdv_OBP_InfectCervicoVaginale" value="'../jeuxDeValeurs/JDV_OBP_InfectCervicoVaginale-CISIS.xml'"/>
        <let name="jdv_OBP_TrimestreGrossesse" value="'../jeuxDeValeurs/JDV_OBP_TrimestreGrossesse-CISIS.xml'"/>
        <let name="jdv_AntecedentsObstetricaux_OBP" value="'../jeuxDeValeurs/JDV_AntecedentsObstetricaux_OBP-CISIS.xml'"/><!--
        <let name="jdv_ObservationEnfant_OBP" value="'../jeuxDeValeurs/JDV_ObservationEnfant_OBP_CI-SIS.xml'"/>-->
        
        
        <rule context="cda:ClinicalDocument">
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.12.1']"> 
                [CI-SIS_OBP_SAP] Le template parent "Volet Synthèse antepartum" (1.2.250.1.213.1.1.1.12.1) doit être présent.
            </assert>
            
            <assert test="./cda:code[@code='34133-9' and @codeSystem='2.16.840.1.113883.6.1']"> 
                [CI-SIS_OBP_SAP] L'élément code doit avoir @code ="34133-9" et @codeSystem = "2.16.840.1.113883.6.1"/>. 
            </assert>
        </rule>
        
    </pattern>
</schema>
