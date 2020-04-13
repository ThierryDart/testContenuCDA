<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    CI-SIS_POST_AVC.sch - ASIP/PRAS
   
    ......................................................................................................................................................    
    Historique :
       05/10/17 : NMA : Création
       14/03/18 : NMA : MAJ du pattern variables
                            
 -->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="SUNV"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_AVC_SUNV.sch">
    <title>Rapport de conformité du document aux spécifications du volet AVC - Sortie de l'UNV (SUNV)</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
     
    <!--=<<o#%@O[ Abstract patterns ]O@%#o>>=-->
    
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>   
    <include href="abstract/personName20110627.sch"/>
    
    
    <include href="include/jeuxDeValeurs/AVC/JDV_etiologieInfarctus_AVC.sch"/>
    <include href="include/jeuxDeValeurs/AVC/JDV_etiologieHemorragie_AVC.sch"/>
    <include href="include/jeuxDeValeurs/AVC/JDV_raisonAbsenceEtiologie_AVC.sch"/>
    
    <!--Entete-->
    <include href="include/specificationsVolets/AVC/Entete/Entete_AVC.sch"/>
    
    <phase id="SUNV">
        <active pattern="variables"/>
        <active pattern="JDV_etiologieInfarctus_AVC"/>
        <active pattern="JDV_etiologieHemorragie_AVC"/>
        <active pattern="JDV_raisonAbsenceEtiologie_AVC"/>
        <active pattern="Entete_AVC"/>
    </phase>
    
     
    <pattern id="variables">
        
        <!-- chemins relatifs des fichiers jeux de valeurs -->
        <let name="jdv_AVC_etiologieInfarctus" value="'../jeuxDeValeurs/JDV_etiologieInfarctus-CISIS.xml'"/>
        <let name="jdv_AVC_etiologieHemorragie" value="'../jeuxDeValeurs/JDV_etiologieHemorragie-CISIS.xml'"/>
        <let name="jdv_AVC_raisonAbsenceEtiologie" value="'../jeuxDeValeurs/JDV_raisonAbsenceEtiologie-CISIS.xml'"/>
        <rule context="cda:ClinicalDocument">
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.17']"> 
                [CI-SIS_AVC_SUNV] Le template parent "Sortie d'UNV (SUNV)" (1.2.250.1.213.1.1.1.17) doit être présent.
            </assert>
            
            <assert test="./cda:code[@code='34133-9' and @codeSystem='2.16.840.1.113883.6.1']"> 
                [CI-SIS_AVC_SUNV] L'élément code doit avoir @code ="34133-9" et @codeSystem = "2.16.840.1.113883.6.1"/>. 
            </assert>
        </rule>
    </pattern>
    
</schema>

