<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    CI-SIS_FRCP.sch - ASIP/PTS
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
    
    14/03/18 : NMA : MAJ du pattern Variables
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_FRCP.sch">
    <title>Rapport de conformité du document aux spécifications du volet Fiche RCP</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>

    <!--=<<o#%@O[ Abstract patterns ]O@%#o>>=-->
    
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>
    <include href="abstract/personName20110627.sch"/>
    
    
    <include href="include/jeuxDeValeurs/FRCP/JDV_StatutDoc-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/FRCP/JDV_Diagnostic-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/FRCP/JDV_TypeTraitement-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/FRCP/JDV_TypeExamenComp-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/FRCP/JDV_TraitementSoins-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/FRCP/JDV_ANRCPTumeur-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/FRCP/JDV_StatutQuorum-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/FRCP/JDV_StatutCasPresente-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/FRCP/JDV_PhaseCancer-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/FRCP/JDV_Organe-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/FRCP/JDV_OMSEchPer-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/FRCP/JDV_NatureDiscussion-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/FRCP/JDV_Appareil-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/FRCP/JDV_OMSInterpret-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/FRCP/JDV_PrimSecTumeur-CISIS.sch"/>
    
    
    
    <include href="include/specificationsVolets/FRCP/Entete/Entete_FRCP.sch"/>
    <include href="include/specificationsVolets/FRCP/Sections/S_cancerDiagnosis_FRCP.sch"/>
    <include href="include/specificationsVolets/FRCP/Sections/S_codedReasonForReferral_FRCP.sch"/>
    <include href="include/specificationsVolets/FRCP/Entrees/E_simpleObservation_FRCP.sch"/>
    
    
    
    
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Phase en vigueur            -->
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    
    <phase id="FRCP">
        <active pattern="variables"/>        
        
        
        <active pattern="JDV_StatutDoc_CISIS"/>
        <active pattern="JDV_Diagnostic-CISIS"/>
        <active pattern="JDV_TypeTraitement-CISIS"/>
        <active pattern="JDV_TypeExamenComp-CISIS"/>
        <active pattern="JDV_TraitementSoins-CISIS"/>
        <active pattern="JDV_ANRCPTumeur-CISIS"/>
        <active pattern="JDV_StatutQuorum-CISIS"/>
        <active pattern="JDV_StatutCasPresente-CISIS"/>
        <active pattern="JDV_PhaseCancer-CISIS"/>
        <active pattern="JDV_Organe-CISIS"/>
        <active pattern="JDV_OMSEchPerf-CISIS"/>
        <active pattern="JDV_NatureDiscussion-CISIS"/>
        <active pattern="JDV_Appareil-CISIS"/>
        <active pattern="JDV_OMSInterpret-CISIS"/>
        <active pattern="JDV_PrimSecTumeur-CISIS"/>
        
        
        
        <active pattern="Entete_FRCP"/>
        <active pattern="S_cancerDiagnosis_FRCP"/>
        <active pattern="S_codedReasonForReferral_FRCP"/>
        <active pattern="E_simpleObservation_FRCP"/>
        
        
    </phase>
    

    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Variables globales          -->
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    
    <pattern id="variables">

        <!-- Nouveau jeu de valeurs -->
        <let name="jdv_StatutDoc" value="'../jeuxDeValeurs/JDV_StatutDoc-CISIS.xml'"/>
        <let name="jdv_Tumeur" value="'../jeuxDeValeurs/JDV_Tumeur-CISIS.xml'"/>
        <let name="jdv_TypeTraitement" value="'../jeuxDeValeurs/JDV_TypeTraitement-CISIS.xml'"/>
        <let name="jdv_TypeExamenComp" value="'../jeuxDeValeurs/JDV_TypeExamenComp-CISIS.xml'"/>
        <let name="jdv_TraitementSoins" value="'../jeuxDeValeurs/JDV_TraitementSoinsRCP-CISIS.xml'"/>
        <let name="jdv_ANRCPTumeur" value="'../jeuxDeValeurs/JDV_ANRCPTumeur-CISIS.xml'"/>
        <let name="jdv_StatutQuorum" value="'../jeuxDeValeurs/JDV_StatutQuorum-CISIS.xml'"/>
        <let name="jdv_StatutCasPresente" value="'../jeuxDeValeurs/JDV_StatutCasPresente-CISIS.xml'"/>
        <let name="jdv_PhaseCancer" value="'../jeuxDeValeurs/JDV_PhaseCancer-CISIS.xml'"/>
        <let name="jdv_Organe" value="'../jeuxDeValeurs/JDV_ANRCPOrgane-CISIS.xml'"/>
        <let name="jdv_OMSEchPerf" value="'../jeuxDeValeurs/JDV_OMSEchPerf-CISIS.xml'"/>
        <let name="jdv_NatureDiscussion" value="'../jeuxDeValeurs/JDV_NatureDiscussion-CISIS.xml'"/>
        <let name="jdv_Appareil" value="'../jeuxDeValeurs/JDV_ANRCPAppareil-CISIS.xml'"/>
        <let name="jdv_OMSInterpret" value="'../jeuxDeValeurs/JDV_OMSInterpret-CISIS.xml'"/>
        <let name="jdv_PrimSecTumeur" value="'../jeuxDeValeurs/JDV_PrimSecTumeur-CISIS.xml'"/>


        
        <!--<let name="jdv_FRCP_CategorieRCP" value="'../jeuxDeValeurs/JDV_FRCP_CatégorieRCP_CI-SIS.xml'"/>-->
        
        <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.1.8"]'>
            
            <!-- Vérifier que toutes les sections obligatoires du document sont présentes -->
            <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.2"]'>
                [CI-SIS_FRCP] : Erreur de conformité au volet : La section "Raison de la recommandation" doit être présente dans le document.
            </assert> 
            <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.7.3.1.3.14.1"]'>
                [CI-SIS_FRCP] : Erreur de conformité au volet : La section "Diagnostic du cancer" doit être présente dans le document.
            </assert>
            <assert test='.//cda:templateId[@root = "1.2.250.1.213.1.1.2.25"]'>
                [CI-SIS_FRCP] : Erreur de conformité au volet : La section "Note de progression" doit être présente dans le document.
            </assert>
            <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.4"]'>
                [CI-SIS_FRCP] : Erreur de conformité au volet : La section "Histoire de la maladie" doit être présente dans le document.
            </assert>
            <assert test='.//cda:templateId[@root = "1.2.250.1.213.1.1.2.45"]'>
                [CI-SIS_FRCP] : Erreur de conformité au volet : La section "Cadre de la proposition thérapeutique" doit être présente dans le document.
            </assert>
            <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.36"]'>
                [CI-SIS_FRCP] : Erreur de conformité au volet : La section "Plan de soins" doit être présente dans le document.
            </assert>
            <assert test='.//cda:templateId[@root = "1.2.250.1.213.1.1.2.33"]'>
                [CI-SIS_FRCP] : Erreur de conformité au volet : La section "Statut du dossier présenté en RCP" doit être présente dans le document.
            </assert> 
            <assert test='.//cda:templateId[@root = "1.2.250.1.213.1.1.2.35"]'>
                [CI-SIS_FRCP] : Erreur de conformité au volet : La section "Statut du document" doit être présente dans le document.
            </assert>
            <assert test='.//cda:templateId[@root = "1.2.250.1.213.1.1.2.34"]'>
                [CI-SIS_FRCP] : Erreur de conformité au volet : La section "Conclusion du CR-ACP" doit être présente dans le document.
            </assert>
            <!-- cette section n'est pas obligatoire pour la FRCP V2.0 
            <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.8.1.2.6"]'>
                [CI-SIS_FRCP] : Erreur de conformité au volet : La section "Information sur le prélèvement" doit être présente dans le document.
            </assert> -->
            
        </rule>
    </pattern>
</schema>
