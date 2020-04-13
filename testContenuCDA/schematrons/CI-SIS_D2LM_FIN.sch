<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    D2LM_FIN
   auteur : Nidal MAHRAZ
   version : 0.0.6 
   Ce volet décrit les données contenues dans une fiche d'interprétation Nationale de seconde lecture de mammographie
   ......................................................................................................................................................    
    Historique :
       04/10/2017 : NMA : Création
       14/03/2018 : NMA : MAJ du pattern variables
       -->

<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="FIN"
        xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_D2LM_FIN.sch">
        <title>Rapport de conformité du document aux spécifications du volet D2LM-FIN</title>
        <ns prefix="cda" uri="urn:hl7-org:v3"/>
        <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
        <ns prefix="jdv" uri="http://esante.gouv.fr"/>
        <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
        
        <!--=<<o#%@O[ Abstract patterns ]O@%#o>>=-->
        
        <include href="abstract/dansJeuDeValeurs.sch"/>
        <include href="abstract/IVL_TS.sch"/>   
        <include href="abstract/personName20110627.sch"/>
 
        <!--Sections spécifiques à la D2LM-->
        <include href="include/specificationsVolets/D2LM/sections/S_Identification_D2LM.sch"/>
        <include href="include/specificationsVolets/D2LM/sections/S_antecedents_D2LM.sch"/>
        <include href="include/specificationsVolets/D2LM/sections/S_bilanCancerologie_D2LM.sch"/>
        <include href="include/specificationsVolets/D2LM/sections/S_radiologie_D2LM.sch"/>
        
        <!--JDV-->
        <include href="include/jeuxDeValeurs/D2LM/JDV_AntecedentsPersonnels_D2LM.sch"/>
        <include href="include/jeuxDeValeurs/D2LM/JDV_FIN_BilanDiagnostic_D2LM.sch"/>
        <include href="include/jeuxDeValeurs/D2LM/JDV_ConduiteATenir_1_D2LM.sch"/>
        <include href="include/jeuxDeValeurs/D2LM/JDV_FIN_ConduiteATenir_2_D2LM.sch"/>
        <include href="include/jeuxDeValeurs/D2LM/JDV_ConduiteATenir_3_D2LM.sch"/>
        <include href="include/jeuxDeValeurs/D2LM/JDV_DensiteMammaire_D2LM.sch"/>
        <include href="include/jeuxDeValeurs/D2LM/JDV_ExamenClinique_D2LM.sch"/>
        <include href="include/jeuxDeValeurs/D2LM/JDV_Famille_D2LM.sch"/>
        <include href="include/jeuxDeValeurs/D2LM/JDV_FIN_MotifDiagnostic_D2LM.sch"/>
        <include href="include/jeuxDeValeurs/D2LM/JDV_MotifEchographie_D2LM.sch"/>
        <include href="include/jeuxDeValeurs/D2LM/JDV_TypeLecture_D2LM.sch"/>
        <include href="include/jeuxDeValeurs/D2LM/JDV_TypeMammographie_D2LM.sch"/>
        
        <!--Entete-->
        <include href="include/specificationsVolets/D2LM/Entete/Entete_D2LM.sch"/>
        
        <phase id="FIN">
                <active pattern="variables"/>
                
                <active pattern="S_identification_D2LM"/>
                <active pattern="S_antecedents_D2LM"/>
                <active pattern="S_bilanCancerologie_D2LM"/>
                <active pattern="S_radiologie_D2LM"/>
                
                <active pattern="JDV_AntecedentsPersonnels_D2LM"/>
                <active pattern="JDV_BilanDiagnostic_D2LM"/>
                <active pattern="JDV_ConduiteATenir_1_D2LM"/>
                <active pattern="JDV_ConduiteATenir_2_D2LM"/>
                <active pattern="JDV_ConduiteATenir_3_D2LM"/>
                <active pattern="JDV_DensiteMammaire_D2LM"/>
                <active pattern="JDV_ExamenClinique_D2LM"/>
                <active pattern="JDV_FamilleID_D2LM"/>
                <active pattern="JDV_MotifDiagnostic_D2LM"/>
                <active pattern="JDV_MotifEchographie_D2LM"/>
                <active pattern="JDV_TypeLecture_D2LM"/>
                <active pattern="JDV_TypeMammographie_D2LM"/>
                
                <!--Entete-->
                <active pattern="Entete_D2LM"/>
                
        </phase>

        <pattern id="variables">
                
                <let name="jdv_D2LM_AntecedentsPersonnels" value="'../jeuxDeValeurs/JDV_AntecedentsPersonnels-CISIS.xml'"/>
                <let name="jdv_D2LM_BilanDiagnostic" value="'../jeuxDeValeurs/JDV_BilanDiagnostic-CISIS.xml'"/>
                <let name="jdv_D2LM_ConduiteATenir_1" value="'../jeuxDeValeurs/JDV_ConduiteATenir_1-CISIS.xml'"/>
                <let name="jdv_D2LM_ConduiteATenir_2" value="'../jeuxDeValeurs/JDV_ConduiteATenir_2-CISIS.xml'"/>
                <let name="jdv_D2LM_ConduiteATenir_3" value="'../jeuxDeValeurs/JDV_ConduiteATenir_3-CISIS.xml'"/>
                <let name="jdv_D2LM_DensiteMammaire" value="'../jeuxDeValeurs/JDV_DensiteMammaire-CISIS.xml'"/>
                <let name="jdv_D2LM_ExamenClinique" value="'../jeuxDeValeurs/JDV_ExamenClinique-CISIS.xml'"/>
                <let name="jdv_D2LM_FamilleID" value="'../jeuxDeValeurs/JDV_FamilleID-CISIS.xml'"/>
                <let name="jdv_D2LM_MotifDiagnostic" value="'../jeuxDeValeurs/JDV_MotifDiagnostic-CISIS.xml'"/>
                <let name="jdv_D2LM_MotifEchographie" value="'../jeuxDeValeurs/JDV_MotifEchographie-CISIS.xml'"/>
                <let name="jdv_D2LM_TypeLecture" value="'../jeuxDeValeurs/JDV_TypeLecture-CISIS.xml'"/>
                <let name="jdv_D2LM_TypeMammographie" value="'../jeuxDeValeurs/JDV_TypeMammographie-CISIS.xml'"/>
                
                <rule context="cda:ClinicalDocument">
                    <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.13']"> 
                         [CI-SIS_D2LM_FIN] Le template "Conformité à la D2LM (Dématérialisation de la seconde Lecture de Mammographie)" (1.2.250.1.213.1.1.1.13) doit être présent.
                    </assert>
                    <assert test="./cda:code[@code='18748-4' and @codeSystem='2.16.840.1.113883.6.1']"> 
                         [CI-SIS_D2LM_FIN] L'élément code doit avoir @code ="18748-4" et @codeSystem = "2.16.840.1.113883.6.1"/>. 
                    </assert>
                </rule>
        </pattern>
</schema>
