<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    CI-SIS_CRRTN.sch - ASIP/PELIM
    ......................................................................................................................................................
    Vérification de la conformité sémantique au volet Compte-rendu de rétinographie du CI-SIS.
    ......................................................................................................................................................
    Utilisation des répertoires sous testContenuCDA :
    - testContenuCDA : les documents CDA d'exemples conformes au CI-SIS, ainsi que la feuille de style par défaut cda_asip.xsl pour la visualisation
    - - documentsAnnexes : Des documents annexes liés aux exemples et des documents de référence
    - - infrastructure/cda : Le schéma XML CDA.xsd
    - - jeuxDeValeurs : les jeux de valeurs du CI-SIS dans le format SVS.xsd
    - - processable/coreschemas : Les sous-schémas XML de CDA.xsd (de l'édition normative HL7 v3 de 2005, correspondant à CDAr2)
    - - schematrons : les schématrons des volets du CI-SIS sous la forme source (<CI-SIS_<nom>.sch) et sous la forme compilée en xslt2 (<CI-SIS_<nom>.xsl)
    - - - abstract : les sous-schématrons de patterns abstraits (un fichier par abstract pattern)
    - - - include : les sous-schématrons de patterns concrets (un fichier par pattern)
    - - - - sections : les sous-schématrons de patterns pour la vérification de conformité des sections du corps CDA
    - - - - - entries : les sous-schématrons de patterns pour la vérification de conformité des entries du corps CDA
    - - - moteur : le moteur xslt2 de vérification de conformité sémantique d'un document d'exemple, 
                   avec ses différents composants : saxon9he.jar, script verif.bat et feuilles de transformation xslt2 intermédiaires
    - - - rapports : les rapports de vérification de conformité produits, et la feuille de style qui sert à leur visualisation
    ......................................................................................................................................................
    Historique :
        19/01/15 : CRI : Création
        23/04/15 : JDS :    Ajout du pattern RTN_ModeleEnTete ( schematron RTN_ModeleEnTete20150403.sch)
                            Maj des include serviceEventLabStatusCode20130408.sch      -> serviceEventLabStatusCode20150317.sch
                            Maj des include telecom20110728.sch                        -> telecom20150317.sch
       14/03/18 : NMA : MAJ du pattern variables
       16/01/20 : NMA : Suppression du test sur le typeCode et functionCode de l'ophtalmologue 
                            
        
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="CRTTN"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_CRTTN.sch">
    <title>Rapport de conformité du document aux spécifications du volet CRRTN</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    
    <!--=<<o#%@O[ Abstract patterns ]O@%#o>>=-->
    
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>   
    <include href="abstract/personName20110627.sch"/>
  
    <!--=<<o#%@O[ Entete ]O@%#o>>=-->
    
    <include href="include/specificationsVolets/CRTTN/entete/Entete_CRTTN.sch"/>
    
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Phase en vigueur            -->
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    
    <phase id="CRTTN">
        <active pattern="variables"/>

        <active pattern="Entete_CRTTN"/>
    </phase>
    
    <!--=<<o#%@O[ Variables globales ]O@%#o>>=-->


    <pattern id="variables">
        
        <!-- chemins relatifs des fichiers jeux de valeurs -->

        <let name="jdv_confidentialityCode" value="'../jeuxDeValeurs/JDV_HL7_Confidentiality-CISIS.xml'"/>  
        <let name="jdv_encompassingEncounterCode" value="'../jeuxDeValeurs/JDV_encompassingEncounterCode-CISIS.xml'"/>
        
        
        <rule context="cda:ClinicalDocument">
            
            <!-- Volet CRRTN : "Le médecin prescripteur est un élément obligatoire" -->
            <assert test="./cda:participant[@typeCode='REFB'] and ./cda:participant/cda:functionCode[@code='PCP']"> 
                [CI-SIS_CRTTN] Erreur de conformité RTN : 
                L'élément participant Médecin prescripteur est un élément obligatoire du volet CRRTN 
                (attribut typeCode fixé à 'REFB' et L'attribut code de l'element participant/functionCode est fixé à 'PCP')</assert>
            
            <assert test="./cda:participant[@typeCode='REFB']/cda:associatedEntity/cda:telecom"> 
                [CI-SIS_CRTTN] Erreur de conformité RTN : 
                L'élément associatedEntity/telecom du participant Médecin prescripteur est un élément obligatoire du volet CRRTN 
            </assert>
            
            <assert test="./cda:participant[@typeCode='REFB']/cda:associatedEntity/cda:addr"> 
                [CI-SIS_CRTTN] Erreur de conformité RTN : 
                L'élément associatedEntity/addr du participant Médecin prescripteur est un élément obligatoire du volet CRRTN 
            </assert>
            
            <!-- Volet CRRTN : "L'ophtalmologiste est un élément obligatoire" -->
            <!--<assert test="./cda:participant[@typeCode='REFT'] and ./cda:participant/cda:functionCode[@code='OPHTA']"> 
                [CI-SIS_CRTTN] Erreur de conformité RTN : 
                L'élément participant Ophtalmologiste est un élément obligatoire du volet CRRTN 
                (attribut typeCode fixé à 'REFT' et L'attribut code de l'element participant/functionCode est fixé à 'OPHTA')</assert>-->
            
            <!-- Volet CRRTN : "Les éléments <telecom> et <addr> sont obligatoires pour l'élément legalAuthenticator" -->
            <assert test="./cda:legalAuthenticator/cda:assignedEntity/cda:addr">
                [CI-SIS_CRTTN] Erreur de conformité RTN : L'élément "addr" doit être présent sous legalAuthenticator/assignedEntity 
                dans le cadre du volet CRRTN 
            </assert>
            
            <assert test="./cda:legalAuthenticator/cda:assignedEntity/cda:telecom">
                [CI-SIS_CRTTN] Erreur de conformité RTN : L'élément "telecom" doit être présent sous legalAuthenticator/assignedEntity
                dans le cadre du volet CRRTN
            </assert>
        </rule>
        
    </pattern>
</schema>