<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   TLM-CR
   Auteur : ASIP Santé
   version : 0.1 
   ......................................................................................................................................................    
   Historique :
   19/12/2019 : Création
   ......................................................................................................................................................       
-->

<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="TLM-CR"
        xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_TLM-CR.sch">
        <title>Rapport de conformité du document aux spécifications du volet TLM</title>
        <ns prefix="cda" uri="urn:hl7-org:v3"/>
        <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
        <ns prefix="jdv" uri="http://esante.gouv.fr"/>
        <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
        
        <!--=<<o#%@O[ Abstract patterns ]O@%#o>>=-->
        
        <include href="abstract/dansJeuDeValeurs.sch"/>
        <include href="abstract/IVL_TS.sch"/>   
        <include href="abstract/personName20110627.sch"/>
 
        <!--Sections spécifiques au TLM-CR -->
        <!-- Néant -->
        
        <!--Entrées spécifiques au TLM-CR -->
        <!-- Néant -->
        
        <!--JDV spécifiques au TLM-CR -->
        <!-- Néant -->
        
        <!--Entete spécifiques au TLM-CR -->
        <include href="include/specificationsVolets/TLM/Entete_TLM-CR.sch"/>
        
        <!--Corps spécifiques au TLM-CR -->
        <!-- Corps non structuré -->
        
        <phase id="TLM-CR">
                <active pattern="variables"/>
                <!--Entete-->
                <active pattern="Entete_TLM-CR"/>
        </phase>

        <pattern id="variables">
                <rule context="cda:ClinicalDocument">
                    <assert test="cda:templateId[@root='1.3.6.1.4.1.19376.1.2.20']"> 
                        [CI-SIS_TLM-CR] Le templateID du Volet TLM-CR non structuré doit être celui commun à tous les documents non structurés (1.3.6.1.4.1.19376.1.2.20).
                    </assert>                    
                </rule>
        </pattern>
</schema>
