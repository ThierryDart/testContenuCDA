<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    CI-SIS_AVC_EUNV.sch - ASIP/PRAS
   
    ......................................................................................................................................................    
    Historique :
        29/10/13 : CRI : Création
        19/06/15 : JDS : Maj des include telecom20110728.sch                        -> telecom20150317.sch
        14/03/18 : NMA : MAJ du pattern variables
        

-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_AVC_EUNV.sch">
    <title>Rapport de conformité du document aux spécifications du volet AVC - Episode de soins en UNV (EUNV)</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    
    <!--=<<o#%@O[ Abstract patterns ]O@%#o>>=-->
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>
    <include href="abstract/personName20110627.sch"/>
    
    <!--JDV-->
    <include href="include/jeuxDeValeurs/AVC/JDV_causesAggravationNeuro_AVC.sch"/>
   
    <!--Entete-->
    <include href="include/specificationsVolets/AVC/Entete/Entete_AVC.sch"/>
    
    <phase id="EUNV">
        <active pattern="variables"/>
        <active pattern="JDV_causesAggravationNeuro_AVC"/>
        <active pattern="Entete_AVC"/>
    </phase>
    
       <!--=<<o#%@O[ Variables globales ]O@%#o>>=-->
    <pattern id="variables">

        <!-- chemins relatifs des fichiers jeux de valeurs -->
        <let name="jdv_AVC_causesAggravationNeuro" value="'../jeuxDeValeurs/JDV_ComplicationNeurologique-CISIS.xml'"/>
        
        <rule context="cda:ClinicalDocument">
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.16']"> 
                [CI-SIS_AVC_EUNV] Le template parent "Suivi en UNV UNV (EUNV)" (1.2.250.1.213.1.1.1.16) doit être présent.
            </assert>
            
            <assert test="./cda:code[@code='34133-9' and @codeSystem='2.16.840.1.113883.6.1']"> 
                [CI-SIS_AVC_EUNV] L'élément code doit avoir @code ="34133-9" et @codeSystem = "2.16.840.1.113883.6.1"/>. 
            </assert>
        </rule>
    </pattern>
</schema>
