<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    D2LM_FIDD
   auteur : Nidal MAHRAZ
   version : 0.0.6 
   Ce volet décrit les données contenues dans une fiche d'interprétation de diagnostic différé de seconde lecture de mammographie
   ......................................................................................................................................................    
    Historique :
       04/10/2017 : NMA : Création
       -->

<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="FIDD"
        xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_D2LM_FIDD.sch">

        <title>Rapport de conformité du document aux spécifications du volet D2LM-FIDD</title>
        <ns prefix="cda" uri="urn:hl7-org:v3"/>
        <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
        <ns prefix="jdv" uri="http://esante.gouv.fr"/>
        <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>

        <!--=<<o#%@O[ Abstract patterns ]O@%#o>>=-->
        <include href="abstract/dansJeuDeValeurs.sch"/>
        <include href="abstract/IVL_TS.sch"/>   
        <include href="abstract/personName20110627.sch"/>
        

        <!--=<<o#%@O[ JDV ]O@%#o>>=-->
        <include href="include/jeuxDeValeurs/D2LM/JDV_BilanDiagnostic_D2LM.sch"/>
        <include href="include/jeuxDeValeurs/D2LM/JDV_MotifDiagnostic_D2LM.sch"/>
        <include href="include/jeuxDeValeurs/D2LM/JDV_ConduiteATenir_2_D2LM.sch"/>
        
        <!--Entete-->
        
        <include href="include/specificationsVolets/D2LM/Entete/Entete_D2LM.sch"/>
        
        <phase id="FIDD">
                <active pattern="variables"/>
                <active pattern="JDV_BilanDiagnostic_D2LM"/>
                <active pattern="JDV_ConduiteATenir_2_D2LM"/>
                <active pattern="JDV_MotifDiagnostic_D2LM"/>
                
                <!--Entete-->
                <active pattern="Entete_D2LM"/>
                
        </phase>
        
        <pattern id="variables">

                <let name="jdv_D2LM_BilanDiagnostic" value="'../jeuxDeValeurs/JDV_BilanDiagnostic-CISIS.xml'"/>
                <let name="jdv_D2LM_ConduiteATenir_2" value="'../jeuxDeValeurs/JDV_ConduiteATenir_2-CISIS.xml'"/>
                <let name="jdv_D2LM_MotifDiagnostic" value="'../jeuxDeValeurs/JDV_MotifDiagnostic-CISIS.xml'"/>
                
                <rule context="cda:ClinicalDocument">
                    <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.13']"> 
                         [CI-SIS_D2LM_FIDD] Le template "Conformité à la D2LM (Dématérialisation de la seconde Lecture de Mammographie)" (1.2.250.1.213.1.1.1.13) doit être présent.
                    </assert>
                    <assert test="./cda:code[@code='18748-4' and @codeSystem='2.16.840.1.113883.6.1']"> 
                         [CI-SIS_D2LM_FIDD] L'élément code doit avoir @code ="18748-4" et @codeSystem = "2.16.840.1.113883.6.1"/>. 
                    </assert>
                </rule>
        </pattern>
</schema>
