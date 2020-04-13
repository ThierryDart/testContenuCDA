<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    CI-SIS_StructurationCommuneCDAr2.sch - ASIP/PRAS
    ......................................................................................................................................................
    Vérification de la conformité sémantique au volet Structuration Commune des Documents Médicaux du CI-SIS.
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
    Pour réaliser le schematron d'un volet de contenu du CI-SIS :
        1) Recopier le présent schématron sous le nom CI-SIS_<nom du volet>.sch, dans le répertoire courant (schematrons)
        2) conserver les include, pattern existants, à l'exception du pattern et de l'include nonXMLBody inutiles pour un volet structuré.
        3) Créer dans le répertoire include les patterns concrets supplémentaires requis par le volet (ou réutiliser ceux qui sont réutilisables)
        4) le cas échéant créer dans le répertoire abstract les paterns abstraits supplémentaires requis par le volet
        5) Inclure tous les patterns supplémentaires dans le schématron CI-SIS_<nom du volet>.sch
        6) Activer dans la phase "latotale<aaaammjj>" les patterns concrets supplémentaires.
        7) La première opération de validation de conformité d'un document au volet compilera le schematron en xslt2 : CI-SIS_<nom du volet>.xsl
    ......................................................................................................................................................    
    Historique :
        27/05/11 : FMY : Création
        31/05/11 : FMY : Compléments
        15/06/11 : FMY : Compléments
        27/06/11 : FMY : publication dans la version 1.0.1 du CI-SIS
        22/07/11 : FMY : Mise à jour des commentaires ci-dessus (retirer le pattern et l'include nonXMLBody), ajout variable OIDLOINC
                         ajout pattern observationInterpretation
        27/07/11 : FMY : Ajout des patterns de sections et d'entries de PCC et du CI-SIS, transversaux à tous types de documents       
        19/12/11 : FMY : Ajout du contrôle / jeu de valeurs confidentialityCode
        08/10/12 : FMY : CI-SIS 1.3 => retrait des include assignedAuthor, confidentialityCode et custodianOrganization. 
                         Maj des include assignedEntity (addr & telecom optionnels) et addr (contrôle structure des adresses)
                         Actualisation nom de fichiers include problemEntry, concernentry, procedureentry 
        24/01/13 : FMY : Ajout de contrôle de encompassingEncounter/code par rapport au jeu de valeurs CI-SIS_jdv_encompassingEncounterCode
        08/04/13 : FMA : Ajout du préfixe lab (pour CR de biologie et CR-ACP, et appel nouveau pattern serviceEventLabStatusCode
        05/12/13 : FMA : Désactivation du contrôle de l'adresse pour livraison au groupement DMP (qui n'a pas implémenté l'évolution addr)
        10/03/15 : JDS : Réactivation du contrôle de l'élément addr (spécifié dans la version du CI-SIS v1.2.0 de 2012 )
                         Maj des include serviceEventLabStatusCode20130408.sch      -> serviceEventLabStatusCode20150317.sch
                         Maj des include telecom20110728.sch                        -> telecom20150317.sch
        14/03/18 : NMA : Compléments
        17/02/20 : NMA : Création du schématron abstrait dansTypeCode et du schématron JDV_participationType.sch
        
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="Struct_minimale"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2" xmlns:lab="urn:oid:1.3.6.1.4.1.19376.1.3.2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_StructurationMinimale.sch">
    <title>Rapport de conformité du document aux spécifications françaises (en-tête)</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    <ns prefix="lab" uri="urn:oid:1.3.6.1.4.1.19376.1.3.2"/>

    <!-- Inclusion du IHE_XDS-SD -->

    <!-- Inclusions d'abstract patterns : -->
    <include href="../abstract/IVL_TS.sch"/>
    <include href="../abstract/dansJeuDeValeurs.sch"/>   
    <include href="../abstract/personName20110627.sch"/>
    <include href="../abstract/dansTypeCode.sch"/>

    <!-- en-tête et génériques -->
    <include href="../include/en-tete/addr.sch"/>
    <include href="../include/en-tete/assignedEntity_fr.sch"/>
    <include href="../include/en-tete/authenticator_fr.sch"/>
    <include href="../include/en-tete/author_fr.sch"/>
    <include href="../include/en-tete/componentOf_fr.sch"/>
    <include href="../include/en-tete/custodian_fr.sch"/>
    <include href="../include/en-tete/documentationOf_fr.sch"/>
    <include href="../include/en-tete/documentCode.sch"/>
    <include href="../include/en-tete/documentEffectiveTime.sch"/>
    <include href="../include/en-tete/humanSubstanceAdministrationSite.sch"/>
    <include href="../include/en-tete/informantRelatedEntity_fr.sch"/>
    <include href="../include/en-tete/informationRecipient_fr.sch"/>
    <include href="../include/en-tete/inFulfillementOf_fr.sch"/>
    <include href="../include/en-tete/legalAuthenticator_fr.sch"/>
    <include href="../include/en-tete/modeleEntete_fr.sch"/>
    <include href="../include/en-tete/participant_fr.sch"/>
    <include href="../include/en-tete/recordTarget_fr.sch"/>
    <include href="../include/en-tete/relatedDocument_fr.sch"/>
    <include href="../include/en-tete/serviceEventLabStatusCode.sch"/>
    <include href="../include/en-tete/telecom.sch"/>
    
    <include href="../include/jeuxDeValeurs/JDV_authorSpecialty.sch"/>
    <include href="../include/jeuxDeValeurs/JDV_healthcareFacilityTypeCode.sch"/>
    <include href="../include/jeuxDeValeurs/JDV_practiceSettingCode.sch"/>
    <include href="../include/jeuxDeValeurs/JDV_HealthStatusCodes.sch"/>
    <include href="../include/jeuxDeValeurs/JDV_ClinicalStatusCodes.sch"/>
    <include href="../include/jeuxDeValeurs/JDV_ProblemCodes.sch"/>
    <include href="../include/jeuxDeValeurs/JDV_participationType.sch"/>


    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Phase en vigueur            -->
    <!-- ::::::::::::::::::::::::::::::::::::: -->

    <phase id="Struct_minimale">

        <!-- obligatoire dans tout schématron -->
        <active pattern="variablesSM"/>

        <!-- en-tête et génériques -->
        <active pattern="modeleEntete_fr"/>
        <active pattern="recordTarget_fr"/>
        <active pattern="author_fr"/>
        <active pattern="informantRelatedEntity_fr"/>
        <active pattern="custodian_fr"/>
        <active pattern="informationRecipient_fr"/>
        <active pattern="legalAuthenticator_fr"/>
        <active pattern="authenticator_fr"/>
        <active pattern="participant_fr"/>
        <active pattern="inFulfillmentOf_fr"/>
        <active pattern="documentationOf_fr"/>
        <active pattern="documentEffectiveTime"/>
        <active pattern="componentOf_fr"/>
        <active pattern="assignedEntity"/>
        <active pattern="relatedDocument_fr"/>
        
        <active pattern="telecom"/>
        <active pattern="addr"/>
        <active pattern="documentCode"/>
        <active pattern="JDV_authorSpecialty"/>
        <active pattern="JDV_healthcareFacilityTypeCode"/>
        <active pattern="JDV_practiceSettingCode"/>
        <active pattern="serviceEventLabStatusCode"/>
        <active pattern="JDV_HealthStatusCodes"/>
        <active pattern="JDV_ClinicalStatusCodes"/>
        <active pattern="JDV_ProblemCodes"/>
        <active pattern="JDV_participationType"/>
        <active pattern="humanSubstanceAdministrationSite"/>

    </phase>

    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Variables globales          -->
    <!-- ::::::::::::::::::::::::::::::::::::: -->

    <pattern id="variablesSM">
        <let name="jdv_typeCode" value="'../../jeuxDeValeurs/JDV_J07-XdsTypeCode-CISIS.xml'"/>
        <let name="jdv_authorSpecialty" value="'../../jeuxDeValeurs/JDV_J01-XdsAuthorSpecialty-CISIS.xml'"/>
        <let name="jdv_healthcareFacilityTypeCode" value="'../../jeuxDeValeurs/JDV_J02-XdsHealthcareFacilityTypeCode-CISIS.xml'"/>
        <let name="jdv_practiceSettingCode" value="'../../jeuxDeValeurs/JDV_J04-XdsPracticeSettingCode-CISIS.xml'"/>
        <let name="jdv_HealthStatusCodes" value="'../../jeuxDeValeurs/JDV_HealthStatusCodes-CISIS.xml'"/>
        <let name="jdv_ClinicalStatusCodes" value="'../../jeuxDeValeurs/JDV_ClinicalStatusCodes-CISIS.xml'"/>
        <let name="jdv_ProblemCodes" value="'../../jeuxDeValeurs/JDV_ProblemCodes-CISIS.xml'"/>
        <let name="jdv_humanSubstanceAdministrationSite" value="'../../jeuxDeValeurs/JDV_HL7_HumanSubstanceAdministrationSite-CISIS.xml'"/>
        <let name="jdv_participationType" value="'../../jeuxDeValeurs/JDV_HL7_ParticipationType-CISIS.xml'"/>
    </pattern>

</schema>
