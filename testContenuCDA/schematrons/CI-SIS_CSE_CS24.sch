<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    CI-SIS_CertificatSanteCS24.sch - ASIP/PRAS
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
    - - - - section : les sous-schématrons de patterns concrets vérifiant la conformité du contenu d'une section à un modèle de section
    - - - moteur : le moteur xslt2 de vérification de conformité sémantique d'un document d'exemple, 
                   avec ses différents composants : saxon9he.jar, script verif.bat et feuilles de transformation xslt2 intermédiaires
    - - - rapports : les rapports de vérification de conformité produits, et la feuille de style qui sert à leur visualisation
    ......................................................................................................................................................
    Pour réaliser le schematron d'un volet de contenu du CI-SIS :
        1) Recopier le présent schématron sous le nom CI-SIS_<nom du volet>.sch, dans le répertoire courant (schematrons)
        2) conserver sans changement les include, pattern existants.
        3) Créer dans le répertoire include les patterns concrets supplémentaires requis par le volet (ou réutiliser ceux qui sont réutilisables)
        4) le cas échéant créer dans le répertoire abstract les paterns abstraits supplémentaires requis par le volet
        5) Inclure tous les patterns supplémentaires dans le schématron CI-SIS_<nom du volet>.sch
        6) Activer dans la phase "latotale" les patterns concrets supplémentaires.
        7) Si nécessaire adapter la phase "minimale" au contexte du volet, ou bien la supprimer
        8) La première opération de validation de conformité d'un document au volet compilera le schematron en xslt2 : CI-SIS_<nom du volet>.xsl
    ......................................................................................................................................................    
    Historique :
        27/05/11 : FMY : Création
        31/05/11 : FMY : Externalisation du plus grand nombre de patterns, contôle de authorSpecialty, 2 phases : "latotale" et "minimale"
        15/06/11 : Organisation des sous-répertoires de composants
        24/06/11 : CRI : Adaptation du module initial CI-SIS_StructurationCommuneCDAr2.sch en CI-SIS_CertificatSante.sch pour le volet du CI-SIS de l'ASIP
                        "Certificats de Santé de l'Enfant" (CS8, CS9 et CS24).
        08/10/12 : FMY : CI-SIS 1.3 => retrait des include assignedAuthor, confidentialityCode et custodianOrganization. 
                         Maj des include assignedEntity (addr & telecom optionnels) et addr (contrôle structure des adresses)
        22/05/15 : JDS : Utilisation du schématron CSENeurologicEnt20130326.sch (dernière version)         
                         Mise à jour du schématron CSEgeneralAppEnt20120306.sch -> CSEgeneralAppEnt20150522.sch
                         Maj des include telecom20110728.sch                        -> telecom20150317.sch
       14/03/18 : NMA : MAJ du pattern variables
                         
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="CS24-20121008"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_CSE_CS24.sch">
    <title>Rapport de conformité du document aux spécifications du volet Certificat de santé de l'enfant (modèle CS24)</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>

    <!--=<<o#%@O[ Abstract patterns ]O@%#o>>=-->
    
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>   
    <include href="abstract/personName20110627.sch"/>

   
    <!--=<<o#%@O[ sections spécifiques au volet ]O@%#o>>=-->
    
    <include href="../schematrons/include/specificationsVolets/CSE/S_CS24codedPhysicalExam.sch"/>
    <include href="../schematrons/include/specificationsVolets/CSE/S_carePlan_CSE.sch"/>
    

    <!-- Modifiés -->
    <include href="include/specificationsVolets/CSE/E_abdomen_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_codedSocialHistory_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_ears_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_Genitalia_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_Heart_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_Neurologic_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_immunizations_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_generalApp_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_eatingSleeping_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_endocrine_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_eyes_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_integumentary_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_lymphatic_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_respiratory_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_teeth_CSE.sch"/>
    
    <!-- Inchangés -->
    <include href="include/specificationsVolets/CSE/E_CodedVitalSigns_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_historyOfPastIllness_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_musculo_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_PsychoMot_CSE.sch"/>
  
    
    
    <!--=<<o#%@O[ Value sets ]O@%#o>>=-->
    
    <include href="include/jeuxDeValeurs/CSE/JDV_Activite_CSE.sch"/>
    <include href="include/jeuxDeValeurs/CSE/JDV_causeAccidentDom_CSE.sch"/>
    <include href="include/jeuxDeValeurs/CSE/JDV_Profession_CSE.sch"/>
    <include href="include/jeuxDeValeurs/CSE/JDV_nivEtude_CSE.sch"/>
    
    <!--Entete-->
    
    <include href="include/specificationsVolets/CSE/Entete/Entete_CSE.sch"/>
    
  
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Phase en vigueur            -->    
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <phase id="CS24-20121008">
        <active pattern="variables"/>
        <p>Vérification complète de la conformité au CI-SIS</p>

        
        <!--=<<o#%@O[ activation sections spécifiques ]O@%#o>>=-->
        
        <active pattern="S_CS24codedPhysicalExam"/>
        <active pattern="S_carePlan_CSE"/>
              
        
        <!--=<<o#%@O[ activation entrées spécifiques ]O@%#o>>=-->
        
        <active pattern="E_abdomen_CSE"/>
        <active pattern="E_codedSocialHistory_CSE"/>
        <active pattern="E_CodedVitalSigns_CSE"/>
        <active pattern="E_ears_CSE"/>
        <active pattern="E_eatingSleeping_CSE"/>
        <active pattern="E_endocrine_CSE"/>
        <active pattern="E_eyes_CSE"/>
        <active pattern="E_generalApp_CSE"/>
        <active pattern="E_Genitalia_CSE"/>
        <active pattern="E_Heart_CSE"/>
        <active pattern="E_historyOfPastIllness_CSE"/>
        <active pattern="E_immunizations_CSE"/>
        <active pattern="E_integumentary_CSE"/>
        <active pattern="E_lymphatic_CSE"/>
        <active pattern="E_musculo_CSE"/>
        <active pattern="E_Neurologic_CSE"/>
        <active pattern="E_PsychoMot_CSE"/>
        <active pattern="E_respiratory_CSE"/>
        <active pattern="E_teeth_CSE"/>
        
        <!--=<<o#%@O[ activation value sets ]O@%#o>>=-->
        
        <active pattern="JDV_nivEtude_CSE"/>
        <active pattern="JDV_Profession_CSE"/>
        <active pattern="JDV_Activite_CSE"/>
        <active pattern="JDV_causeAccidentDom_CSE"/>

        
        <!--Entete-->
        
        <active pattern="Entete_CSE"/>
        
    </phase>
    
    <!--    Historique des phases des versions antérieures supprimé car alourdit la compilation    -->    

    <!--=<<o#%@O[ Variables globales ]O@%#o>>=-->
    
    <pattern id="variables">
        
        <!-- chemins relatifs des fichiers jeux de valeurs -->
        <let name="jdv_nivEtude" value="'../jeuxDeValeurs/JDV_niveauEtude-CISIS.xml'"/> 
        <let name="jdv_Profession" value="'../jeuxDeValeurs/JDV_Profession-CISIS.xml'"/>
        <let name="jdv_Activite" value="'../jeuxDeValeurs/JDV_Activité-CISIS.xml'"/>
        <let name="jdv_causeAccidentDom" value="'../jeuxDeValeurs/JDV_CauseAccidentDom-CISIS.xml'"/>
        
        <rule context="cda:ClinicalDocument">
            <assert test="./cda:templateId[@root='1.2.250.1.213.1.1.1.5.3']"> 
                [CI-SIS_CertificatSanteCS24] Erreur de conformité CS24 :
                L'élément ClinicalDocument/templateId doit être présent 
                avec @root="1.2.250.1.213.1.1.1.5.3".</assert>
            
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.5']"> 
                [CI-SIS_CertificatSanteCS24] Erreur: Le template parent "Certificat de Santé de l'Enfant" (1.2.250.1.213.1.1.1.5) doit être présent.
            </assert>
            
            <assert test="./cda:code[@code='CERT_DECL' and @codeSystem='1.2.250.1.213.1.1.4.12']"> 
                [CI-SIS_CertificatSanteCS24] Erreur de conformité CS24 : 
                L'élément code doit avoir @code ="CERT_DECL" et @codeSystem = "1.2.250.1.213.1.1.4.12"/>. </assert>
        </rule>
    </pattern>
</schema>
