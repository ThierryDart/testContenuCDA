<?xml version="1.0" encoding="UTF-8"?><!-- 
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
--><schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:cda="urn:hl7-org:v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" queryBinding="xslt2" schemaVersion="CI-SIS_FRCP.sch">
    <title>Rapport de conformité du document aux spécifications du volet Fiche RCP</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>

    <!--=<<o#%@O[ Abstract patterns ]O@%#o>>=-->
    
    <?DSDL_INCLUDE_START abstract/dansJeuDeValeurs.sch?><pattern xmlns:svs="urn:ihe:iti:svs:2008" id="dansJeuDeValeurs" abstract="true">
    <p>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</p>
    <rule context="$xpath_elt">
        <let name="att_code" value="@code"/>
        <let name="att_codeSystem" value="@codeSystem"/>
        <let name="att_displayName" value="@displayName"/>
        
        <assert test="(not(@nullFlavor) or $nullFlavor)">
           [dansJeuDeValeurs] L'élément "<value-of select="$vue_elt"/>" ne doit pas comporter d'attribut nullFlavor.
        </assert> 
        
        <assert test="(             (@code and @codeSystem and @displayName) or             ($nullFlavor and              (@nullFlavor='UNK' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )">
            [dansJeuDeValeurs] L'élément "<value-of select="$vue_elt"/>" doit avoir ses attributs 
            @code, @codeSystem et @displayName renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </assert>
        
        <assert test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($path_jdv)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )">
        <!--  débrayage du contrôle sur le displayName qui risque de générer un trop grand nombre d'assert-failed en raison d'une différence 
              non significative de libellé (pb de casse d'un caractère, un espace en trop, un caractère "'" mal codé ...
        <assert test="@nullFlavor or 
                     (document($path_jdv)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem and @displayName=$att_displayName])">
        -->
            [dansJeuDeValeurs] L'élément <value-of select="$vue_elt"/>
            [<value-of select="$att_code"/>:<value-of select="$att_displayName"/>:<value-of select="$att_codeSystem"/>] 
            doit faire partie du jeu de valeurs <value-of select="$path_jdv"/>.
        </assert>
    </rule>
</pattern><?DSDL_INCLUDE_END abstract/dansJeuDeValeurs.sch?>
    <?DSDL_INCLUDE_START abstract/IVL_TS.sch?><pattern id="IVL_TS" abstract="true">
    <p>
        Vérification de la conformité au CI-SIS d'un élément de type IVL_TS ou TS du standard CDAr2 :
        L'élément doit porter soit un attribut "value" soit un intervalle éventuellement semi-borné de sous-éléments "low", "high". 
        Alternativement, si l'attribut nullFlavor est autorisé, il doit porter l'une des valeurs admises par le CI-SIS. 
    </p>
    <rule context="$elt">
        <let name="L" value="string-length(@value)"/>
        <let name="mm" value="number(substring(@value,5,2))"/>
        <let name="dd" value="number(substring(@value,7,2))"/>            
        <let name="hh" value="number(substring(@value,9,2))"/>
        <let name="lzp" value="string-length(substring-after(@value,'+'))"/> 
        <let name="lzm" value="string-length(substring-after(@value,'-'))"/>
        <let name="lDH1" value="string-length(substring-before(@value,'+'))"/>
        <let name="lDH2" value="string-length(substring-before(@value,'-'))"/>
        <assert test="(             ($L = 0) or             ($L = 4) or              ($L = 6 and $mm &lt;= 12) or              ($L = 8 and $mm &lt;= 12 and $dd &lt;= 31) or              ($L &gt; 14 and $mm &lt;= 12 and $dd &lt;= 31 and $hh &lt; 24 and ($lzp = 4 or $lzm = 4) and $lDH1 &lt;= 14 and $lDH2 &lt;= 14)             )">
            [IVL_TS.sch] Erreur de conformité CI-SIS : <value-of select="$vue_elt"/>/@value = "<value-of select="@value"/>"  contient  
            une date et heure invalide, différente de aaaa ou aaaamm ou aaaammjj ou aaaammjjhh[mm[ss]][+/-]zzzz 
            en temps local du producteur.
        </assert>
        <assert test="(@* and not(*)) or (not(@*) and *)">
            [IVL_TS.sch] Erreur de conformité CI-SIS : <value-of select="$vue_elt"/> doit contenir soit un attribut soit des éléments fils.
        </assert>
        <assert test="(             (name(@*) = 'nullFlavor' and $nullFlavor and             (@* = 'UNK' or @* = 'NASK' or @* = 'ASKU' or @* = 'NAV' or @* = 'MSK')) or             (name(@*) != 'nullFlavor')              )">
            [IVL_TS.sch] Erreur de conformité CI-SIS : <value-of select="$vue_elt"/> contient un 'nullFlavor' non autorisé ou porteur d'une valeur non admise.
        </assert>  
        
        <!-- On test que la valeur high soit plus élevée que la valeur low -->
        <assert test="not(cda:low and cda:high) or cda:high/@value &gt; cda:low/@value or cda:high/@nullFlavor">
            [IVL_TS.sch] Erreur de conformité CDA : L'élément de temps 'high' doit être supérieur à l'élément de temps 'low'
        </assert>
        
    </rule> 

    <rule context="$elt/cda:low">
        <let name="L" value="string-length(@value)"/>
        <let name="mm" value="number(substring(@value,5,2))"/>
        <let name="dd" value="number(substring(@value,7,2))"/>            
        <let name="hh" value="number(substring(@value,9,2))"/>
        <let name="lzp" value="string-length(substring-after(@value,'+'))"/> 
        <let name="lzm" value="string-length(substring-after(@value,'-'))"/>
        <let name="lDH1" value="string-length(substring-before(@value,'+'))"/>
        <let name="lDH2" value="string-length(substring-before(@value,'-'))"/>
        <assert test="(             ($L = 0) or             ($L = 4) or              ($L = 6 and $mm &lt;= 12) or              ($L = 8 and $mm &lt;= 12 and $dd &lt;= 31) or              ($L &gt; 14 and $mm &lt;= 12 and $dd &lt;= 31 and $hh &lt; 24 and ($lzp = 4 or $lzm = 4) and $lDH1 &lt;= 14 and $lDH2 &lt;= 14)             )">
            [IVL_TS.sch] Erreur de conformité CI-SIS : <value-of select="$vue_elt"/>/low/@value = "<value-of select="@value"/>"  contient  
            une date et heure invalide, différente de aaaa ou aaaamm ou aaaammjj ou aaaammjjhh[mm[ss]][+/-]zzzz 
            en temps local du producteur.
        </assert>
    </rule>
    
    <rule context="$elt/cda:high">
        <let name="L" value="string-length(@value)"/>
        <let name="mm" value="number(substring(@value,5,2))"/>
        <let name="dd" value="number(substring(@value,7,2))"/>            
        <let name="hh" value="number(substring(@value,9,2))"/>
        <let name="lzp" value="string-length(substring-after(@value,'+'))"/> 
        <let name="lzm" value="string-length(substring-after(@value,'-'))"/>
        <let name="lDH1" value="string-length(substring-before(@value,'+'))"/>
        <let name="lDH2" value="string-length(substring-before(@value,'-'))"/>
        <assert test="(             ($L = 0) or             ($L = 4) or              ($L = 6 and $mm &lt;= 12) or              ($L = 8 and $mm &lt;= 12 and $dd &lt;= 31) or              ($L &gt; 14 and $mm &lt;= 12 and $dd &lt;= 31 and $hh &lt; 24 and ($lzp = 4 or $lzm = 4) and $lDH1 &lt;= 14 and $lDH2 &lt;= 14)             )">
            [IVL_TS.sch] Erreur de conformité CI-SIS : <value-of select="$vue_elt"/>/high/@value = "<value-of select="@value"/>"  contient  
            une date et heure invalide, différente de aaaa ou aaaamm ou aaaammjj ou aaaammjjhh[mm[ss]][+/-]zzzz 
            en temps local du producteur.
        </assert>
     </rule>       

</pattern><?DSDL_INCLUDE_END abstract/IVL_TS.sch?>
    <?DSDL_INCLUDE_START abstract/personName20110627.sch?><pattern id="personName" abstract="true">
    <rule context="$elt">
        <assert test="(                         (name(@*) = 'nullFlavor' and $nullFlavor and                            (@* = 'UNK' or @* = 'NASK' or @* = 'ASKU' or @* = 'NAV' or @* = 'MSK')) or                         ((./cda:family) and                        ((./cda:family[@qualifier='BR' or @qualifier='SP' or @qualifier='CL']) or not(./cda:family[@qualifier])))                     )">
            Erreur de conformité CI-SIS : L'élément <value-of select="$vue_elt"/>/family doit être présent 
            avec un attribut qualifier valorisé dans : BR (nom de famille), SP (nom d'usage) ou CL (pseudonyme)
            ou sans attribut qualifier. Valeur trouvée pour family : <value-of select="./cda:family"/>. Valeur trouvée pour family@qualifier : <value-of select="./cda:family/@qualifier"/>
        </assert>
    </rule>
</pattern><?DSDL_INCLUDE_END abstract/personName20110627.sch?>
    
    
    <?DSDL_INCLUDE_START include/jeuxDeValeurs/FRCP/JDV_StatutDoc-CISIS.sch?><pattern id="JDV_StatutDoc_CISIS" is-a="dansJeuDeValeurs">
    <p>Conformité du statut du document</p>
    <param name="path_jdv" value="$jdv_StatutDoc"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.2.250.1.213.1.1.2.35']/cda:entry/cda:observation[cda:code/@code='GEN-065']/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern><?DSDL_INCLUDE_END include/jeuxDeValeurs/FRCP/JDV_StatutDoc-CISIS.sch?>
    <?DSDL_INCLUDE_START include/jeuxDeValeurs/FRCP/JDV_Diagnostic-CISIS.sch?><pattern id="JDV_Diagnostic-CISIS" is-a="dansJeuDeValeurs">
    <p>Conformité du diagnostic</p>
    <param name="path_jdv" value="$jdv_Tumeur"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section[templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.3.14.1']/entry/act/entryRelationship/observation[value/@code='MED-238']/targetSiteCode"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.3.14.1']/cda:entry/cda:act/cda:entryRelationship/cda:observation[cda:value/@code='MED-238']/cda:targetSiteCode"/>
    <param name="nullFlavor" value="1"/>
</pattern><?DSDL_INCLUDE_END include/jeuxDeValeurs/FRCP/JDV_Diagnostic-CISIS.sch?>
    <?DSDL_INCLUDE_START include/jeuxDeValeurs/FRCP/JDV_TypeTraitement-CISIS.sch?><pattern id="JDV_TypeTraitement-CISIS" is-a="dansJeuDeValeurs">
    <p>Type du traitement</p>
    <param name="path_jdv" value="$jdv_TypeTraitement"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/procedure/code"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.13.2.11' or cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.36']/cda:entry/cda:procedure/cda:code"/>
    <param name="nullFlavor" value="1"/>
</pattern><?DSDL_INCLUDE_END include/jeuxDeValeurs/FRCP/JDV_TypeTraitement-CISIS.sch?>
    <?DSDL_INCLUDE_START include/jeuxDeValeurs/FRCP/JDV_TypeExamenComp-CISIS.sch?><pattern id="JDV_TypeExamenComp-CISIS" is-a="dansJeuDeValeurs">
    <p>Conformité des demandes d'examen complémentaires</p>
    <param name="path_jdv" value="$jdv_TypeExamenComp"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/observation/code"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.36']/cda:entry/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.20.3.1']/cda:code"/>
    <param name="nullFlavor" value="1"/>
</pattern><?DSDL_INCLUDE_END include/jeuxDeValeurs/FRCP/JDV_TypeExamenComp-CISIS.sch?>
    <?DSDL_INCLUDE_START include/jeuxDeValeurs/FRCP/JDV_TraitementSoins-CISIS.sch?><pattern id="JDV_TraitementSoins-CISIS" is-a="dansJeuDeValeurs">
    <p>Conformité Traitement soins</p>
    <param name="path_jdv" value="$jdv_TraitementSoins"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/observation/entryRelationship/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.2']/cda:entry/cda:observation[cda:value/@code='ORG-132']/cda:entryRelationship/cda:observation[cda:code/@code='ORG-138']/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern><?DSDL_INCLUDE_END include/jeuxDeValeurs/FRCP/JDV_TraitementSoins-CISIS.sch?>
    <?DSDL_INCLUDE_START include/jeuxDeValeurs/FRCP/JDV_ANRCPTumeur-CISIS.sch?><pattern id="JDV_ANRCPTumeur-CISIS" is-a="dansJeuDeValeurs">
    <p>Conformité ANRCP Tumeur</p>
    <param name="path_jdv" value="$jdv_ANRCPTumeur"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/observation/entryRelationship/observation/entryRelationship/observation/targetSiteCode"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.2']/cda:entry/cda:observation/cda:entryRelationship/cda:observation[cda:code/@code='ORG-118']/cda:entryRelationship/cda:observation[cda:code/@code='ORG-119']/cda:targetSiteCode"/>
    <param name="nullFlavor" value="1"/>
</pattern><?DSDL_INCLUDE_END include/jeuxDeValeurs/FRCP/JDV_ANRCPTumeur-CISIS.sch?>
    <?DSDL_INCLUDE_START include/jeuxDeValeurs/FRCP/JDV_StatutQuorum-CISIS.sch?><pattern id="JDV_StatutQuorum-CISIS" is-a="dansJeuDeValeurs">
    <p>Conformité du statut du quorum de la RCP</p>
    <param name="path_jdv" value="$jdv_StatutQuorum"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/organizer/component/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.2.250.1.213.1.1.2.33']/cda:entry/cda:organizer/cda:component/cda:observation[cda:code/@code='ORG-125']/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern><?DSDL_INCLUDE_END include/jeuxDeValeurs/FRCP/JDV_StatutQuorum-CISIS.sch?>
    <?DSDL_INCLUDE_START include/jeuxDeValeurs/FRCP/JDV_StatutCasPresente-CISIS.sch?><pattern id="JDV_StatutCasPresente-CISIS" is-a="dansJeuDeValeurs">
    <p>Conformité du statut du cas présenté à la RCP</p>
    <param name="path_jdv" value="$jdv_StatutCasPresente"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/organizer/component/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.2.250.1.213.1.1.2.33']/cda:entry/cda:organizer/cda:component/cda:observation[cda:code/@code='ORG-127']/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern><?DSDL_INCLUDE_END include/jeuxDeValeurs/FRCP/JDV_StatutCasPresente-CISIS.sch?>
    <?DSDL_INCLUDE_START include/jeuxDeValeurs/FRCP/JDV_PhaseCancer-CISIS.sch?><pattern id="JDV_PhaseCancer-CISIS" is-a="dansJeuDeValeurs">
    <p>Phase du cancer</p>
    <param name="path_jdv" value="$jdv_PhaseCancer"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.2.250.1.213.1.1.2.25']/cda:entry/cda:observation[cda:code/@code='MED-243']/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern><?DSDL_INCLUDE_END include/jeuxDeValeurs/FRCP/JDV_PhaseCancer-CISIS.sch?>
    <?DSDL_INCLUDE_START include/jeuxDeValeurs/FRCP/JDV_Organe-CISIS.sch?><pattern id="JDV_Organe-CISIS" is-a="dansJeuDeValeurs">
    <p>Conformité Organe</p>
    <param name="path_jdv" value="$jdv_Organe"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/observation/entryRelationship/observation/entryRelationship/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.2']/cda:entry/cda:observation/cda:entryRelationship/cda:observation[cda:code/@code='ORG-118']/cda:entryRelationship/cda:observation[cda:code/@code='ORG-119']/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern><?DSDL_INCLUDE_END include/jeuxDeValeurs/FRCP/JDV_Organe-CISIS.sch?>
    <?DSDL_INCLUDE_START include/jeuxDeValeurs/FRCP/JDV_OMSEchPer-CISIS.sch?><pattern id="JDV_OMSEchPerf-CISIS" is-a="dansJeuDeValeurs">
    <p>OMSEchPerf</p>
    <param name="path_jdv" value="$jdv_OMSEchPerf"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/component/section/entry/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.12.2.5']/cda:entry/cda:observation[cda:code/@code='MED-239']/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern><?DSDL_INCLUDE_END include/jeuxDeValeurs/FRCP/JDV_OMSEchPer-CISIS.sch?>
    <?DSDL_INCLUDE_START include/jeuxDeValeurs/FRCP/JDV_NatureDiscussion-CISIS.sch?><pattern id="JDV_NatureDiscussion-CISIS" is-a="dansJeuDeValeurs">
    <p>Conformité Nature Discussion</p>
    <param name="path_jdv" value="$jdv_NatureDiscussion"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.2']/cda:entry/cda:observation[cda:code/@code='GEN-098']/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern><?DSDL_INCLUDE_END include/jeuxDeValeurs/FRCP/JDV_NatureDiscussion-CISIS.sch?>
    <?DSDL_INCLUDE_START include/jeuxDeValeurs/FRCP/JDV_Appareil-CISIS.sch?><pattern id="JDV_Appareil-CISIS" is-a="dansJeuDeValeurs">
    <p>Conformité Appareil</p>
    <param name="path_jdv" value="$jdv_Appareil"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/observation/entryRelationship/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.2']/cda:entry/cda:observation/cda:entryRelationship/cda:observation[cda:code/@code='ORG-118']/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern><?DSDL_INCLUDE_END include/jeuxDeValeurs/FRCP/JDV_Appareil-CISIS.sch?>
    <?DSDL_INCLUDE_START include/jeuxDeValeurs/FRCP/JDV_OMSInterpret-CISIS.sch?><pattern id="JDV_OMSInterpret-CISIS" is-a="dansJeuDeValeurs">
    <p>Conformité OMS Interpretationr</p>
    <param name="path_jdv" value="$jdv_OMSInterpret"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/component/section/entry/observation/interpretationCode"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.12.2.5']/cda:entry/cda:observation/cda:interpretationCode"/>
    <param name="nullFlavor" value="1"/>
</pattern><?DSDL_INCLUDE_END include/jeuxDeValeurs/FRCP/JDV_OMSInterpret-CISIS.sch?>
    <?DSDL_INCLUDE_START include/jeuxDeValeurs/FRCP/JDV_PrimSecTumeur-CISIS.sch?><pattern id="JDV_PrimSecTumeur-CISIS" is-a="dansJeuDeValeurs">
    <p>PrimSecTumeur</p>
    <param name="path_jdv" value="$jdv_PrimSecTumeur"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/act/entryRelationship/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.3.14.1']/cda:entry/cda:act/cda:entryRelationship/cda:observation[cda:code/@code='G-1009']/cda:value"/>
    <param name="nullFlavor" value="1"/>
</pattern><?DSDL_INCLUDE_END include/jeuxDeValeurs/FRCP/JDV_PrimSecTumeur-CISIS.sch?>
    
    
    
    <?DSDL_INCLUDE_START include/specificationsVolets/FRCP/Entete/Entete_FRCP.sch?><pattern id="Entete_FRCP">
   
        
      <!--  -->  
    <rule context="cda:ClinicalDocument/cda:recordTarget/cda:patientRole">
        <!--<rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.2"]'> -->
            
         
        <!-- Teste la cohérence RCP-Organe avec l'appareil concerné -->
        <assert test="cda:patient/cda:name/cda:given and cda:patient/cda:name/cda:family">
            [Entete_FRCP] Le prénom et le(s) nom(s) du patient doivent être présents. 
        </assert>
    </rule>
    
    <rule context="cda:ClinicalDocument/cda:author">
        <assert test="cda:assignedAuthor/cda:assignedPerson/cda:name/cda:family or not(cda:assignedAuthor/cda:assignedPerson)">
            [Entete_FRCP] Le nom de famille est obligatoirement présent si l'identité du PS est présente            
        </assert>
    </rule>
    <rule context="cda:ClinicalDocument/cda:legalAuthenticator">
        <assert test="cda:assignedEntity/cda:code">
            [Entete_FRCP] Le code, qui ici représente la pécialité du PS est obligatoirement présent            
        </assert>
        <assert test="cda:assignedEntity/cda:representedOrganization">
            [Entete_FRCP] L'organisation représentée doit obligatoirement être renseignée            
        </assert>
    </rule>
    <rule context="cda:ClinicalDocument/cda:participant">
        <!-- <assert test="cda:time/cda:low or cda:time/cda:high or cda:time[@nullFlavor]">
            [Entete_FRCP] L'élément "time" doit avoir un sous-élément low ou high au moins pour indiquer la date de participation           
        </assert> -->
        <assert test="cda:associatedEntity/cda:associatedPerson/cda:name/cda:family">
            [Entete_FRCP] Le nom de famille du participant doit obligatoirement être renseigné          
        </assert>
    </rule>
    <rule context="cda:ClinicalDocument/cda:documentationOf">
        <assert test="cda:serviceEvent/cda:code">
            [Entete_FRCP] Le code de l'acte documenté est obligatoire            
        </assert>
    </rule>
    <rule context="cda:ClinicalDocument/cda:componentOf">
        <assert test="count(cda:encompassingEncounter/cda:id)=4">
            [Entete_FRCP] Il doit y avoir 4 identifiants pour identifier: le RRC, le gestionnaire RCP, la RCP et la session de la RCP            
        </assert>
        <assert test="cda:encompassingEncounter/cda:responsibleParty/cda:assignedEntity/cda:code or not(cda:encompassingEncounter/cda:responsibleParty)">
            [Entete_FRCP] La profession/Spécialité du PS est obligatoire            
        </assert>
        <assert test="cda:encompassingEncounter/cda:encounterParticipant[@typeCode='REF']/cda:assignedEntity/cda:code or not(cda:encompassingEncounter/cda:encounterParticipant[@typeCode='REF'])">
            [Entete_FRCP] La profession/Spécialité du PS est obligatoire            
        </assert>
        <assert test="cda:encompassingEncounter/cda:encounterParticipant[@typeCode='CON']/cda:assignedEntity/cda:code or not(cda:encompassingEncounter/cda:encounterParticipant[@typeCode='CON'])">
            [Entete_FRCP] La profession/Spécialité du PS est obligatoire            
        </assert>
        <assert test="cda:encompassingEncounter/cda:location/cda:healthCareFacility/cda:code">
            [Entete_FRCP] La modalité d'exercice est obligatoirement présente         
        </assert>
        <assert test="cda:encompassingEncounter/cda:location/cda:healthCareFacility/cda:location">
            [Entete_FRCP] La localisation de l'établissement de soin est obligatoirement présente         
        </assert>
        
    </rule>
</pattern><?DSDL_INCLUDE_END include/specificationsVolets/FRCP/Entete/Entete_FRCP.sch?>
    <?DSDL_INCLUDE_START include/specificationsVolets/FRCP/Sections/S_cancerDiagnosis_FRCP.sch?><pattern id="S_cancerDiagnosis_FRCP">


    <title>IHE PCC v3.0 FRCP Cancer Diagnosis Section</title>

    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.3.14.1']">
        
        <assert test="cda:entry/cda:act/cda:entryRelationship/cda:observation/cda:code[@code='G-1009']">
            [S_cancerDiagnosis_FRCP] Erreur de conformité au volet FRCP : La présence du diagnostic (G-1009) de la tumeur est obligatoire.
        </assert>
      
        <assert test="cda:entry/cda:act/cda:entryRelationship/cda:observation/cda:entryRelationship/cda:observation/cda:code[@code='21908-9'] ">
            [S_cancerDiagnosis_FRCP] Erreur de conformité au volet FRCP : La classification 'TNM' de la tumeur est obligatoire.
        </assert>
        
        <assert test="cda:entry/cda:act/cda:entryRelationship/cda:observation/cda:entryRelationship/cda:observation/cda:entryRelationship/cda:observation/cda:code[@code='21905-5'] ">
            [S_cancerDiagnosis_FRCP] Erreur de conformité au volet FRCP : La classification 'T' de la tumeur est obligatoire.
        </assert>
        
        <assert test="cda:entry/cda:act/cda:entryRelationship/cda:observation/cda:entryRelationship/cda:observation/cda:entryRelationship/cda:observation/cda:code[@code='21906-3'] ">
            [S_cancerDiagnosis_FRCP] Erreur de conformité au volet FRCP : La classification 'N' de la tumeur est obligatoire.
        </assert>
        
        <assert test="cda:entry/cda:act/cda:entryRelationship/cda:observation/cda:entryRelationship/cda:observation/cda:entryRelationship/cda:observation/cda:code[@code='21907-1'] ">
            [S_cancerDiagnosis_FRCP] Erreur de conformité au volet FRCP : La classification 'M' de la tumeur est obligatoire.
        </assert>

    </rule>
</pattern><?DSDL_INCLUDE_END include/specificationsVolets/FRCP/Sections/S_cancerDiagnosis_FRCP.sch?>
    <?DSDL_INCLUDE_START include/specificationsVolets/FRCP/Sections/S_codedReasonForReferral_FRCP.sch?><pattern id="S_codedReasonForReferral_FRCP">
    <rule context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.2&#34;]"> 
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId=2">
            [S_codedReasonForReferral_FRCP.sch] Erreur de conformité au volet FRCP : Coded Reason for referral doit contenir deux templateId (cardinalité [2..2])
        </assert>
        <!-- Verify that the template id is used on the appropriate type of object --> 
        <assert test="../cda:section"> 
            [S_codedReasonForReferral_FRCP.sch] Erreur de conformité au volet FRCP : Ce composant ne peut être utilisé qu'en tant que section. 
        </assert> 
        <!-- Vérifier le code de la section --> 
        <assert test="cda:code[@code = &#34;42349-1&#34;]"> 
            [S_codedReasonForReferral_FRCP.sch] Erreur de conformité au volet FRCP : Le code de la section doit être 42349-1 
        </assert> 
        <assert test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"> 
            [S_codedReasonForReferral_FRCP.sch] Erreur de conformité au volet FRCP : Le code de la section doit être tiré de la terminologie LOINC (2.16.840.1.113883.6.1). 
        </assert> 
        <assert test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.5&#34;]"> 
            <!-- Verify that all required data elements are present -->
            [S_codedReasonForReferral_FRCP.sch] Erreur de conformité au volet FRCP : La section doit contenir au moins une entrée 
            du type Conditions Entry  (1.3.6.1.4.1.19376.1.5.3.1.4.5).            
        </assert> 
        <assert test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.13&#34;]"> 
            <!-- Verify that all required data elements are present -->
            [S_codedReasonForReferral_FRCP.sch] Erreur de conformité au volet FRCP : La section doit contenir au moins une entrée
            du type Simple Observations  (1.3.6.1.4.1.19376.1.5.3.1.4.13).            
        </assert> 
    </rule> 
</pattern><?DSDL_INCLUDE_END include/specificationsVolets/FRCP/Sections/S_codedReasonForReferral_FRCP.sch?>
    <?DSDL_INCLUDE_START include/specificationsVolets/FRCP/Entrees/E_simpleObservation_FRCP.sch?><pattern id="E_simpleObservation_FRCP">
   
        
      <!-- Règle vérifiant la simple Observation contenue dans ne code Reason for Referal -->  
    <rule context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.2&#34;]"> 
            
         
        <!-- Teste la cohérence RCP-Organe avec l'appareil concerné -->
        <assert test="not(./cda:entry/cda:observation/cda:value[@code='RCP_026']) or (./cda:entry/cda:observation/cda:entryRelationship/cda:observation/cda:code[@code='RCP_099'])">
            [E_simpleObservation_FRCP] Erreur de conformité au volet FRCP : L'appareil concerné (RCP_099)doit être présent. 
        </assert>
        
        <!-- Teste le type d'entryRelationship de type 'SUBJ'-->       
        <assert test="not(./cda:entry/cda:observation[cda:value/@code='RCP_026']/cda:entryRelationship/cda:observation/cda:code[@code='RCP_099']) or              ./cda:entry/cda:observation[cda:value/@code='RCP_026']/cda:entryRelationship[@typeCode='SUBJ']/cda:observation/cda:code[@code='RCP_099']">
            [E_simpleObservation_FRCP] Erreur de conformité au volet FRCP : La valeur de @typeCode est @typeCode='SUBJ'. 
        </assert>
        
                             <!-- -=<<o#%@O[ Organe concerné ]O@%#o>>=-  -->        
        
        <!-- Teste la présence -->
        <assert test="not(./cda:entry/cda:observation/cda:value[@code='RCP_026'])              or (./cda:entry/cda:observation[cda:value/@code='RCP_026']/cda:entryRelationship/cda:observation/cda:entryRelationship/cda:observation/cda:code[@code='RCP_093'])">
            [E_simpleObservation_FRCP] Erreur de conformité au volet FRCP : Le type de d'organe concerné (RCP_093) doit être figuré. 
        </assert>
        <!-- Teste le type d'entryRelationship de type 'REFR'-->    
        <assert test="not(./cda:entry/cda:observation/cda:value[@code='RCP_026']) or              ./cda:entry/cda:observation/cda:entryRelationship/cda:observation/cda:entryRelationship[@typeCode='REFR']/cda:observation/cda:code[@code='RCP_093']">
            [E_simpleObservation_FRCP] Erreur de conformité au volet FRCP : La valeur de @typeCode est 'REFR'. 
        </assert>
        
        <!-- Cas 2: type RCP = RCP Transversale et de soins de support -->
        
        <!-- Teste la cohérence RCP Transversale et de soins de support avec les soins -->
        <assert test="not(./cda:entry/cda:observation/cda:value[@code='RCP_027']) or (./cda:entry/cda:observation/cda:entryRelationship/cda:observation/cda:code[@code='RCP_110'])">
            [E_simpleObservation_FRCP] Erreur de conformité au volet FRCP : Les soins et traitements (RCP_110) doivent être présents. 
        </assert>
        

        
    </rule>
</pattern><?DSDL_INCLUDE_END include/specificationsVolets/FRCP/Entrees/E_simpleObservation_FRCP.sch?>
    
    
    
    
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
        
        <rule context="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.1.8&#34;]">
            
            <!-- Vérifier que toutes les sections obligatoires du document sont présentes -->
            <assert test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.3.2&#34;]">
                [CI-SIS_FRCP] : Erreur de conformité au volet : La section "Raison de la recommandation" doit être présente dans le document.
            </assert> 
            <assert test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.7.3.1.3.14.1&#34;]">
                [CI-SIS_FRCP] : Erreur de conformité au volet : La section "Diagnostic du cancer" doit être présente dans le document.
            </assert>
            <assert test=".//cda:templateId[@root = &#34;1.2.250.1.213.1.1.2.25&#34;]">
                [CI-SIS_FRCP] : Erreur de conformité au volet : La section "Note de progression" doit être présente dans le document.
            </assert>
            <assert test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.3.4&#34;]">
                [CI-SIS_FRCP] : Erreur de conformité au volet : La section "Histoire de la maladie" doit être présente dans le document.
            </assert>
            <assert test=".//cda:templateId[@root = &#34;1.2.250.1.213.1.1.2.45&#34;]">
                [CI-SIS_FRCP] : Erreur de conformité au volet : La section "Cadre de la proposition thérapeutique" doit être présente dans le document.
            </assert>
            <assert test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.3.36&#34;]">
                [CI-SIS_FRCP] : Erreur de conformité au volet : La section "Plan de soins" doit être présente dans le document.
            </assert>
            <assert test=".//cda:templateId[@root = &#34;1.2.250.1.213.1.1.2.33&#34;]">
                [CI-SIS_FRCP] : Erreur de conformité au volet : La section "Statut du dossier présenté en RCP" doit être présente dans le document.
            </assert> 
            <assert test=".//cda:templateId[@root = &#34;1.2.250.1.213.1.1.2.35&#34;]">
                [CI-SIS_FRCP] : Erreur de conformité au volet : La section "Statut du document" doit être présente dans le document.
            </assert>
            <assert test=".//cda:templateId[@root = &#34;1.2.250.1.213.1.1.2.34&#34;]">
                [CI-SIS_FRCP] : Erreur de conformité au volet : La section "Conclusion du CR-ACP" doit être présente dans le document.
            </assert>
            <!-- cette section n'est pas obligatoire pour la FRCP V2.0 
            <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.8.1.2.6"]'>
                [CI-SIS_FRCP] : Erreur de conformité au volet : La section "Information sur le prélèvement" doit être présente dans le document.
            </assert> -->
            
        </rule>
    </pattern>
</schema>