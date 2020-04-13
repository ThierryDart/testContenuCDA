<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    CI-SIS_POST_AVC.sch - ASIP/PRAS
   
    ......................................................................................................................................................    
    Historique :
       05/10/17 : NMA : Création
       14/03/18 : NMA : MAJ du pattern variables
       
                            
 -->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="Post_AVC"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_AVC_PostAVC.sch">
    <title>Rapport de conformité du document aux spécifications du volet Evaluation Pluri Professionnelle Post AVC </title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
     
    <!--=<<o#%@O[ Abstract patterns ]O@%#o>>=-->
    
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>   
    <include href="abstract/personName20110627.sch"/>
    
    
    <!--=<<o#%@O[ JDV ]O@%#o>>=-->
    <include href="include/jeuxDeValeurs/AVC/JDV_Appareillage_AVC.sch"/>
    <include href="include/jeuxDeValeurs/AVC/JDV_Activite_AVC.sch"/>
    <include href="include/jeuxDeValeurs/AVC/JDV_GIR_AVC.sch"/>
    <include href="include/jeuxDeValeurs/AVC/JDV_TraitementPreventif_AVC.sch"/>
    <include href="include/jeuxDeValeurs/AVC/JDV_TraitementSuivi_AVC.sch"/>
    <include href="include/jeuxDeValeurs/AVC/JDV_Juridique_AVC.sch"/>
    
    <!--Entete-->
    <include href="include/specificationsVolets/AVC/Entete/Entete_AVC.sch"/>
    
    
    <phase id="Post_AVC">
        <active pattern="variables"/>
        <active pattern="JDV_Appareillage_AVC"/>
        <active pattern="JDV_Activite_AVC"/>
        <active pattern="JDV_GIR_AVC"/>
        <active pattern="JDV_Juridique_AVC"/>
        <active pattern="JDV_TraitementSuivi_AVC"/>
        <active pattern="JDV_TraitementPreventif_AVC"/>
        <active pattern="Entete_AVC"/>
        
    </phase>
     
    <pattern id="variables">
        
        <let name="jdv_AVC_Appareillage" value="'../jeuxDeValeurs/JDV_Taille-CISIS.xml'"/>
        <let name="jdv_AVC_Activite" value="'../jeuxDeValeurs/JDV_Activité-CISIS.xml'"/> 
        <let name="jdv_AVC_GIR" value="'../jeuxDeValeurs/JDV_GIR-CISIS.xml'"/> 
        <let name="jdv_AVC_Juridique" value="'../jeuxDeValeurs/JDV_Juridique-CISIS.xml'"/> 
        <let name="jdv_AVC_TraitementPreventif" value="'../jeuxDeValeurs/JDV_TraitementPreventif-CISIS.xml'"/> 
        <let name="jdv_AVC_TraitementSuivi" value="'../jeuxDeValeurs/JDV_TraitementSuivi-CISIS.xml'"/> 
        <rule context="cda:ClinicalDocument">
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.25']"> 
                [CI-SIS_AVC_PostAVC] Le template parent "Evaluation Pluri Professionnelle Post AVC (PostAVC)" (1.2.250.1.213.1.1.1.25) doit être présent.
            </assert>
            
            <assert test="./cda:code[@code='11488-4' and @codeSystem='2.16.840.1.113883.6.1']"> 
                [CI-SIS_AVC_PostAVC] L'élément code doit avoir @code ="11488-4" et @codeSystem = "2.16.840.1.113883.6.1"/>. 
            </assert>
        </rule>
   </pattern>      
     
    
</schema>

