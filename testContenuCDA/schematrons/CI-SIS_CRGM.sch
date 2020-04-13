<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   CR-GM
   auteur : NNA
   version : 0.0.1 
   Ce volet décrit les données contenues dans un Compte Rendu de Génétique Moléculaire
   ......................................................................................................................................................    
    Historique :
       08/01/2019 : NNA : Création
      
       -->

<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="CRGM"
        xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_CRGM.sch">
        <title>Rapport de conformité du document aux spécifications du volet CR-GM </title>
        <ns prefix="cda" uri="urn:hl7-org:v3"/>
        <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
        <ns prefix="jdv" uri="http://esante.gouv.fr"/>
        <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
        
        <!--=<<o#%@O[ Abstract patterns ]O@%#o>>=-->
        
        <include href="abstract/dansJeuDeValeurs.sch"/>
        <include href="abstract/IVL_TS.sch"/>   
        <include href="abstract/personName20110627.sch"/>
 
        <!--Sections spécifiques au CR-GM-->
        <include href="include/specificationsVolets/CRGM/sections/S_additionalSpecified_CRGM.sch"/>
        <include href="include/specificationsVolets/CRGM/sections/S_clinicalInformation_CRGM.sch"/>
        <include href="include/specificationsVolets/CRGM/sections/S_diagnosticConclusion_CRGM.sch"/>
        <include href="include/specificationsVolets/CRGM/sections/S_intraoperativeObservation_CRGM.sch"/>
        <include href="include/specificationsVolets/CRGM/sections/S_macroscopicObservation_CRGM.sch"/>
        <include href="include/specificationsVolets/CRGM/sections/S_microscopicObservation_CRGM.sch"/>
        <include href="include/specificationsVolets/CRGM/sections/S_procedureSteps_CRGM.sch"/>
        
        <!--Entrées spécifiques au CR-GM-->
        <include href="include/specificationsVolets/CRGM/entrees/E_problemOrganizer_CRGM.sch"/>
        <include href="include/specificationsVolets/CRGM/entrees/E_specimenProcedureSteps_CRGM.sch"/>
        
        <!--JDV spécifiques au CR-GM-->
        <include href="include/jeuxDeValeurs/CRGM/JDV_TypePrelevOrigine_CRGM.sch"/>
        <include href="include/jeuxDeValeurs/CRGM/JDV_TypeHistoEtatTumora_CRGM.sch"/>
        <include href="include/jeuxDeValeurs/CRGM/JDV_Conditionnement_CRGM.sch"/>
        <include href="include/jeuxDeValeurs/CRGM/JDV_NatureMaterielEtudie_CRGM.sch"/>
        <include href="include/jeuxDeValeurs/CRGM/JDV_Gene_CRGM.sch"/>
        <include href="include/jeuxDeValeurs/CRGM/JDV_ImpactMutation_CRGM.sch"/>
        <include href="include/jeuxDeValeurs/CRGM/JDV_ClasseTherapie_CRGM.sch"/>
        <include href="include/jeuxDeValeurs/CRGM/JDV_RaisonNonRealisation_CRGM.sch"/>
        <include href="include/jeuxDeValeurs/CRGM/JDV_QualificationFraction_CRGM.sch"/>
        <include href="include/jeuxDeValeurs/CRGM/JDV_NatureFraction_CRGM.sch"/>
        <include href="include/jeuxDeValeurs/CRGM/JDV_MethodePreparationEchantillon_CRGM.sch"/>
        <include href="include/jeuxDeValeurs/CRGM/JDV_TypeResultat_CRGM.sch"/>
        <include href="include/jeuxDeValeurs/CRGM/JDV_TypeConclusion_CRGM.sch"/>
        
        <!--Entete spécifiques au CR-GM-->
        <include href="include/specificationsVolets/CRGM/Entete/Entete_CRGM.sch"/>
        
        <!--Corps spécifiques au CR-GM-->
        <include href="include/specificationsVolets/CRGM/Corps/Corps_CRGM.sch"/>
        
        <phase id="CRGM">
                <active pattern="variables"/>
                
                <active pattern="S_additionalSpecified_CRGM"/>
                <active pattern="S_clinicalInformation_CRGM"/>
                <active pattern="S_diagnosticConclusion_CRGM"/>
                <active pattern="S_intraoperativeObservation_CRGM"/>
                <active pattern="S_macroscopicObservation_CRGM"/>
                <active pattern="S_microscopicObservation_CRGM"/>
                <active pattern="S_procedureSteps_CRGM"/>
                
                <active pattern="E_problemOrganizer_CRGM"/>
                <active pattern="E_specimenProcedureSteps_CRGM"/>
                                
                <active pattern="JDV_TypePrelevOrigine_CRGM"/>
                <active pattern="JDV_TypeHistoEtatTumora_CRGM"/>
                <active pattern="JDV_Conditionnement_CRGM"/>
                <active pattern="JDV_NatureMaterielEtudie_CRGM"/>
                <active pattern="JDV_Gene_CRGM"/>
                <active pattern="JDV_ImpactMutation_CRGM"/>
                <active pattern="JDV_ClasseTherapie_CRGM"/>
                <active pattern="JDV_RaisonNonRealisation_CRGM"/>
                <active pattern="JDV_QualificationFraction_CRGM"/>
                <active pattern="JDV_NatureFraction_CRGM"/>
                <active pattern="JDV_MethodePreparationEchantillon_CRGM"/>
                <active pattern="JDV_TypeResultat_CRGM"/>
                <active pattern="JDV_TypeConclusion_CRGM"/>
               
                
                <!--Entete-->
                <active pattern="Entete_CRGM"/>
                
                <!--Corps-->
                <active pattern="Corps_CRGM"/>
                
        </phase>

        <pattern id="variables">
                
                <let name="jdv_CRGM_TypePrelevOrigine" value="'../jeuxDeValeurs/JDV_TypePrelevOrigine-CISIS.xml'"/>
                <let name="jdv_CRGM_TypeHistoEtatTumora" value="'../jeuxDeValeurs/JDV_TypeHisto_EtatTumora-CISIS.xml'"/>
                <let name="jdv_CRGM_Conditionnement" value="'../jeuxDeValeurs/JDV_Conditionnement-CISIS.xml'"/>
                <let name="jdv_CRGM_NatureMaterielEtudie" value="'../jeuxDeValeurs/JDV_NatureMaterielEtudie-CISIS.xml'"/>
                <let name="jdv_CRGM_Gene" value="'../jeuxDeValeurs/JDV_Gene-CISIS.xml'"/>
                <let name="jdv_CRGM_ImpactMutation" value="'../jeuxDeValeurs/JDV_ImpactMutation-CISIS.xml'"/>
                <let name="jdv_CRGM_ClasseTherapie" value="'../jeuxDeValeurs/JDV_ClasseTherapie-CISIS.xml'"/>
                <let name="jdv_CRGM_RaisonNonRealisation" value="'../jeuxDeValeurs/JDV_RaisonNonRealisation-CISIS.xml'"/>
                <let name="jdv_CRGM_QualificationFraction" value="'../jeuxDeValeurs/JDV_QualificationFraction-CISIS.xml'"/>
                <let name="jdv_CRGM_NatureFraction" value="'../jeuxDeValeurs/JDV_NatureFraction-CISIS.xml'"/>
                <let name="jdv_CRGM_MethodePreparationEchantillon" value="'../jeuxDeValeurs/JDV_MethodePreparationEchantillon-CISIS.xml'"/>
                <let name="jdv_CRGM_TypeResultat" value="'../jeuxDeValeurs/JDV_TypeResultat-CISIS.xml'"/>
                <let name="jdv_CRGM_TypeConclusion" value="'../jeuxDeValeurs/JDV_TypeConclusion-CISIS.xml'"/>
                                
                <rule context="cda:ClinicalDocument">
                        <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.32']"> 
                         [CI-SIS_CRGM] Le templateID du Volet "Compte Rendu de génétique moléculaire" (1.2.250.1.213.1.1.1.32) doit être présent.
                    </assert>
                        <assert test="./cda:code[@code='51969-4' and @codeSystem='2.16.840.1.113883.6.1']"> 
                         [CI-SIS_CRGM] L'élément code doit avoir @code ="51969-4" et @codeSystem = "2.16.840.1.113883.6.1"/>. 
                    </assert>
                </rule>
        </pattern>
</schema>
