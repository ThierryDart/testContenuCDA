<?xml version="1.0" encoding="UTF-8"?><schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:cda="urn:hl7-org:v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" queryBinding="xslt2" schemaVersion="CI-SIS_FRCP.sch">
    <title>Rapport de conformité du document aux spécifications du volet Fiche RCP</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>

    
    
    <!--Suppressed abstract pattern dansJeuDeValeurs was here-->
    <!--Suppressed abstract pattern IVL_TS was here-->
    <!--Suppressed abstract pattern personName was here-->
    
    
    <!--Start pattern based on abstract dansJeuDeValeurs--><pattern xmlns:svs="urn:ihe:iti:svs:2008" id="JDV_StatutDoc_CISIS">
    <p>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</p>
    <rule context="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.2.250.1.213.1.1.2.35']/cda:entry/cda:observation[cda:code/@code='GEN-065']/cda:value">
        <let name="att_code" value="@code"/>
        <let name="att_codeSystem" value="@codeSystem"/>
        <let name="att_displayName" value="@displayName"/>
        
        <assert test="(not(@nullFlavor) or 1)">
           [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>" ne doit pas comporter d'attribut nullFlavor.
        </assert> 
        
        <assert test="(             (@code and @codeSystem and @displayName) or             (1 and              (@nullFlavor='UNK' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )">
            [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>" doit avoir ses attributs 
            @code, @codeSystem et @displayName renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </assert>
        
        <assert test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_StatutDoc)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )">
        
            [dansJeuDeValeurs] L'élément <value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
            [<value-of select="$att_code"/>:<value-of select="$att_displayName"/>:<value-of select="$att_codeSystem"/>] 
            doit faire partie du jeu de valeurs <value-of select="$jdv_StatutDoc"/>.
        </assert>
    </rule>
</pattern>
    <!--Start pattern based on abstract dansJeuDeValeurs--><pattern xmlns:svs="urn:ihe:iti:svs:2008" id="JDV_Diagnostic-CISIS">
    <p>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</p>
    <rule context="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.3.14.1']/cda:entry/cda:act/cda:entryRelationship/cda:observation[cda:value/@code='MED-238']/cda:targetSiteCode">
        <let name="att_code" value="@code"/>
        <let name="att_codeSystem" value="@codeSystem"/>
        <let name="att_displayName" value="@displayName"/>
        
        <assert test="(not(@nullFlavor) or 1)">
           [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section[templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.3.14.1']/entry/act/entryRelationship/observation[value/@code='MED-238']/targetSiteCode"/>" ne doit pas comporter d'attribut nullFlavor.
        </assert> 
        
        <assert test="(             (@code and @codeSystem and @displayName) or             (1 and              (@nullFlavor='UNK' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )">
            [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section[templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.3.14.1']/entry/act/entryRelationship/observation[value/@code='MED-238']/targetSiteCode"/>" doit avoir ses attributs 
            @code, @codeSystem et @displayName renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </assert>
        
        <assert test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_Tumeur)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )">
        
            [dansJeuDeValeurs] L'élément <value-of select="ClinicalDocument/component/structuredBody/component/section[templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.3.14.1']/entry/act/entryRelationship/observation[value/@code='MED-238']/targetSiteCode"/>
            [<value-of select="$att_code"/>:<value-of select="$att_displayName"/>:<value-of select="$att_codeSystem"/>] 
            doit faire partie du jeu de valeurs <value-of select="$jdv_Tumeur"/>.
        </assert>
    </rule>
</pattern>
    <!--Start pattern based on abstract dansJeuDeValeurs--><pattern xmlns:svs="urn:ihe:iti:svs:2008" id="JDV_TypeTraitement-CISIS">
    <p>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</p>
    <rule context="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.13.2.11' or cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.36']/cda:entry/cda:procedure/cda:code">
        <let name="att_code" value="@code"/>
        <let name="att_codeSystem" value="@codeSystem"/>
        <let name="att_displayName" value="@displayName"/>
        
        <assert test="(not(@nullFlavor) or 1)">
           [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/entry/procedure/code"/>" ne doit pas comporter d'attribut nullFlavor.
        </assert> 
        
        <assert test="(             (@code and @codeSystem and @displayName) or             (1 and              (@nullFlavor='UNK' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )">
            [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/entry/procedure/code"/>" doit avoir ses attributs 
            @code, @codeSystem et @displayName renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </assert>
        
        <assert test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_TypeTraitement)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )">
        
            [dansJeuDeValeurs] L'élément <value-of select="ClinicalDocument/component/structuredBody/component/section/entry/procedure/code"/>
            [<value-of select="$att_code"/>:<value-of select="$att_displayName"/>:<value-of select="$att_codeSystem"/>] 
            doit faire partie du jeu de valeurs <value-of select="$jdv_TypeTraitement"/>.
        </assert>
    </rule>
</pattern>
    <!--Start pattern based on abstract dansJeuDeValeurs--><pattern xmlns:svs="urn:ihe:iti:svs:2008" id="JDV_TypeExamenComp-CISIS">
    <p>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</p>
    <rule context="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.36']/cda:entry/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.20.3.1']/cda:code">
        <let name="att_code" value="@code"/>
        <let name="att_codeSystem" value="@codeSystem"/>
        <let name="att_displayName" value="@displayName"/>
        
        <assert test="(not(@nullFlavor) or 1)">
           [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/code"/>" ne doit pas comporter d'attribut nullFlavor.
        </assert> 
        
        <assert test="(             (@code and @codeSystem and @displayName) or             (1 and              (@nullFlavor='UNK' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )">
            [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/code"/>" doit avoir ses attributs 
            @code, @codeSystem et @displayName renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </assert>
        
        <assert test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_TypeExamenComp)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )">
        
            [dansJeuDeValeurs] L'élément <value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/code"/>
            [<value-of select="$att_code"/>:<value-of select="$att_displayName"/>:<value-of select="$att_codeSystem"/>] 
            doit faire partie du jeu de valeurs <value-of select="$jdv_TypeExamenComp"/>.
        </assert>
    </rule>
</pattern>
    <!--Start pattern based on abstract dansJeuDeValeurs--><pattern xmlns:svs="urn:ihe:iti:svs:2008" id="JDV_TraitementSoins-CISIS">
    <p>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</p>
    <rule context="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.2']/cda:entry/cda:observation[cda:value/@code='ORG-132']/cda:entryRelationship/cda:observation[cda:code/@code='ORG-138']/cda:value">
        <let name="att_code" value="@code"/>
        <let name="att_codeSystem" value="@codeSystem"/>
        <let name="att_displayName" value="@displayName"/>
        
        <assert test="(not(@nullFlavor) or 1)">
           [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/entryRelationship/observation/value"/>" ne doit pas comporter d'attribut nullFlavor.
        </assert> 
        
        <assert test="(             (@code and @codeSystem and @displayName) or             (1 and              (@nullFlavor='UNK' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )">
            [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/entryRelationship/observation/value"/>" doit avoir ses attributs 
            @code, @codeSystem et @displayName renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </assert>
        
        <assert test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_TraitementSoins)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )">
        
            [dansJeuDeValeurs] L'élément <value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/entryRelationship/observation/value"/>
            [<value-of select="$att_code"/>:<value-of select="$att_displayName"/>:<value-of select="$att_codeSystem"/>] 
            doit faire partie du jeu de valeurs <value-of select="$jdv_TraitementSoins"/>.
        </assert>
    </rule>
</pattern>
    <!--Start pattern based on abstract dansJeuDeValeurs--><pattern xmlns:svs="urn:ihe:iti:svs:2008" id="JDV_ANRCPTumeur-CISIS">
    <p>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</p>
    <rule context="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.2']/cda:entry/cda:observation/cda:entryRelationship/cda:observation[cda:code/@code='ORG-118']/cda:entryRelationship/cda:observation[cda:code/@code='ORG-119']/cda:targetSiteCode">
        <let name="att_code" value="@code"/>
        <let name="att_codeSystem" value="@codeSystem"/>
        <let name="att_displayName" value="@displayName"/>
        
        <assert test="(not(@nullFlavor) or 1)">
           [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/entryRelationship/observation/entryRelationship/observation/targetSiteCode"/>" ne doit pas comporter d'attribut nullFlavor.
        </assert> 
        
        <assert test="(             (@code and @codeSystem and @displayName) or             (1 and              (@nullFlavor='UNK' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )">
            [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/entryRelationship/observation/entryRelationship/observation/targetSiteCode"/>" doit avoir ses attributs 
            @code, @codeSystem et @displayName renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </assert>
        
        <assert test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_ANRCPTumeur)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )">
        
            [dansJeuDeValeurs] L'élément <value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/entryRelationship/observation/entryRelationship/observation/targetSiteCode"/>
            [<value-of select="$att_code"/>:<value-of select="$att_displayName"/>:<value-of select="$att_codeSystem"/>] 
            doit faire partie du jeu de valeurs <value-of select="$jdv_ANRCPTumeur"/>.
        </assert>
    </rule>
</pattern>
    <!--Start pattern based on abstract dansJeuDeValeurs--><pattern xmlns:svs="urn:ihe:iti:svs:2008" id="JDV_StatutQuorum-CISIS">
    <p>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</p>
    <rule context="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.2.250.1.213.1.1.2.33']/cda:entry/cda:organizer/cda:component/cda:observation[cda:code/@code='ORG-125']/cda:value">
        <let name="att_code" value="@code"/>
        <let name="att_codeSystem" value="@codeSystem"/>
        <let name="att_displayName" value="@displayName"/>
        
        <assert test="(not(@nullFlavor) or 1)">
           [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/entry/organizer/component/observation/value"/>" ne doit pas comporter d'attribut nullFlavor.
        </assert> 
        
        <assert test="(             (@code and @codeSystem and @displayName) or             (1 and              (@nullFlavor='UNK' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )">
            [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/entry/organizer/component/observation/value"/>" doit avoir ses attributs 
            @code, @codeSystem et @displayName renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </assert>
        
        <assert test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_StatutQuorum)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )">
        
            [dansJeuDeValeurs] L'élément <value-of select="ClinicalDocument/component/structuredBody/component/section/entry/organizer/component/observation/value"/>
            [<value-of select="$att_code"/>:<value-of select="$att_displayName"/>:<value-of select="$att_codeSystem"/>] 
            doit faire partie du jeu de valeurs <value-of select="$jdv_StatutQuorum"/>.
        </assert>
    </rule>
</pattern>
    <!--Start pattern based on abstract dansJeuDeValeurs--><pattern xmlns:svs="urn:ihe:iti:svs:2008" id="JDV_StatutCasPresente-CISIS">
    <p>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</p>
    <rule context="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.2.250.1.213.1.1.2.33']/cda:entry/cda:organizer/cda:component/cda:observation[cda:code/@code='ORG-127']/cda:value">
        <let name="att_code" value="@code"/>
        <let name="att_codeSystem" value="@codeSystem"/>
        <let name="att_displayName" value="@displayName"/>
        
        <assert test="(not(@nullFlavor) or 1)">
           [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/entry/organizer/component/observation/value"/>" ne doit pas comporter d'attribut nullFlavor.
        </assert> 
        
        <assert test="(             (@code and @codeSystem and @displayName) or             (1 and              (@nullFlavor='UNK' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )">
            [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/entry/organizer/component/observation/value"/>" doit avoir ses attributs 
            @code, @codeSystem et @displayName renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </assert>
        
        <assert test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_StatutCasPresente)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )">
        
            [dansJeuDeValeurs] L'élément <value-of select="ClinicalDocument/component/structuredBody/component/section/entry/organizer/component/observation/value"/>
            [<value-of select="$att_code"/>:<value-of select="$att_displayName"/>:<value-of select="$att_codeSystem"/>] 
            doit faire partie du jeu de valeurs <value-of select="$jdv_StatutCasPresente"/>.
        </assert>
    </rule>
</pattern>
    <!--Start pattern based on abstract dansJeuDeValeurs--><pattern xmlns:svs="urn:ihe:iti:svs:2008" id="JDV_PhaseCancer-CISIS">
    <p>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</p>
    <rule context="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.2.250.1.213.1.1.2.25']/cda:entry/cda:observation[cda:code/@code='MED-243']/cda:value">
        <let name="att_code" value="@code"/>
        <let name="att_codeSystem" value="@codeSystem"/>
        <let name="att_displayName" value="@displayName"/>
        
        <assert test="(not(@nullFlavor) or 1)">
           [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>" ne doit pas comporter d'attribut nullFlavor.
        </assert> 
        
        <assert test="(             (@code and @codeSystem and @displayName) or             (1 and              (@nullFlavor='UNK' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )">
            [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>" doit avoir ses attributs 
            @code, @codeSystem et @displayName renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </assert>
        
        <assert test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_PhaseCancer)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )">
        
            [dansJeuDeValeurs] L'élément <value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
            [<value-of select="$att_code"/>:<value-of select="$att_displayName"/>:<value-of select="$att_codeSystem"/>] 
            doit faire partie du jeu de valeurs <value-of select="$jdv_PhaseCancer"/>.
        </assert>
    </rule>
</pattern>
    <!--Start pattern based on abstract dansJeuDeValeurs--><pattern xmlns:svs="urn:ihe:iti:svs:2008" id="JDV_Organe-CISIS">
    <p>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</p>
    <rule context="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.2']/cda:entry/cda:observation/cda:entryRelationship/cda:observation[cda:code/@code='ORG-118']/cda:entryRelationship/cda:observation[cda:code/@code='ORG-119']/cda:value">
        <let name="att_code" value="@code"/>
        <let name="att_codeSystem" value="@codeSystem"/>
        <let name="att_displayName" value="@displayName"/>
        
        <assert test="(not(@nullFlavor) or 1)">
           [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/entryRelationship/observation/entryRelationship/observation/value"/>" ne doit pas comporter d'attribut nullFlavor.
        </assert> 
        
        <assert test="(             (@code and @codeSystem and @displayName) or             (1 and              (@nullFlavor='UNK' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )">
            [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/entryRelationship/observation/entryRelationship/observation/value"/>" doit avoir ses attributs 
            @code, @codeSystem et @displayName renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </assert>
        
        <assert test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_Organe)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )">
        
            [dansJeuDeValeurs] L'élément <value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/entryRelationship/observation/entryRelationship/observation/value"/>
            [<value-of select="$att_code"/>:<value-of select="$att_displayName"/>:<value-of select="$att_codeSystem"/>] 
            doit faire partie du jeu de valeurs <value-of select="$jdv_Organe"/>.
        </assert>
    </rule>
</pattern>
    <!--Start pattern based on abstract dansJeuDeValeurs--><pattern xmlns:svs="urn:ihe:iti:svs:2008" id="JDV_OMSEchPerf-CISIS">
    <p>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</p>
    <rule context="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.12.2.5']/cda:entry/cda:observation[cda:code/@code='MED-239']/cda:value">
        <let name="att_code" value="@code"/>
        <let name="att_codeSystem" value="@codeSystem"/>
        <let name="att_displayName" value="@displayName"/>
        
        <assert test="(not(@nullFlavor) or 1)">
           [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/component/section/entry/observation/value"/>" ne doit pas comporter d'attribut nullFlavor.
        </assert> 
        
        <assert test="(             (@code and @codeSystem and @displayName) or             (1 and              (@nullFlavor='UNK' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )">
            [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/component/section/entry/observation/value"/>" doit avoir ses attributs 
            @code, @codeSystem et @displayName renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </assert>
        
        <assert test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_OMSEchPerf)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )">
        
            [dansJeuDeValeurs] L'élément <value-of select="ClinicalDocument/component/structuredBody/component/section/component/section/entry/observation/value"/>
            [<value-of select="$att_code"/>:<value-of select="$att_displayName"/>:<value-of select="$att_codeSystem"/>] 
            doit faire partie du jeu de valeurs <value-of select="$jdv_OMSEchPerf"/>.
        </assert>
    </rule>
</pattern>
    <!--Start pattern based on abstract dansJeuDeValeurs--><pattern xmlns:svs="urn:ihe:iti:svs:2008" id="JDV_NatureDiscussion-CISIS">
    <p>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</p>
    <rule context="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.2']/cda:entry/cda:observation[cda:code/@code='GEN-098']/cda:value">
        <let name="att_code" value="@code"/>
        <let name="att_codeSystem" value="@codeSystem"/>
        <let name="att_displayName" value="@displayName"/>
        
        <assert test="(not(@nullFlavor) or 1)">
           [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>" ne doit pas comporter d'attribut nullFlavor.
        </assert> 
        
        <assert test="(             (@code and @codeSystem and @displayName) or             (1 and              (@nullFlavor='UNK' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )">
            [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>" doit avoir ses attributs 
            @code, @codeSystem et @displayName renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </assert>
        
        <assert test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_NatureDiscussion)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )">
        
            [dansJeuDeValeurs] L'élément <value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/value"/>
            [<value-of select="$att_code"/>:<value-of select="$att_displayName"/>:<value-of select="$att_codeSystem"/>] 
            doit faire partie du jeu de valeurs <value-of select="$jdv_NatureDiscussion"/>.
        </assert>
    </rule>
</pattern>
    <!--Start pattern based on abstract dansJeuDeValeurs--><pattern xmlns:svs="urn:ihe:iti:svs:2008" id="JDV_Appareil-CISIS">
    <p>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</p>
    <rule context="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.2']/cda:entry/cda:observation/cda:entryRelationship/cda:observation[cda:code/@code='ORG-118']/cda:value">
        <let name="att_code" value="@code"/>
        <let name="att_codeSystem" value="@codeSystem"/>
        <let name="att_displayName" value="@displayName"/>
        
        <assert test="(not(@nullFlavor) or 1)">
           [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/entryRelationship/observation/value"/>" ne doit pas comporter d'attribut nullFlavor.
        </assert> 
        
        <assert test="(             (@code and @codeSystem and @displayName) or             (1 and              (@nullFlavor='UNK' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )">
            [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/entryRelationship/observation/value"/>" doit avoir ses attributs 
            @code, @codeSystem et @displayName renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </assert>
        
        <assert test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_Appareil)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )">
        
            [dansJeuDeValeurs] L'élément <value-of select="ClinicalDocument/component/structuredBody/component/section/entry/observation/entryRelationship/observation/value"/>
            [<value-of select="$att_code"/>:<value-of select="$att_displayName"/>:<value-of select="$att_codeSystem"/>] 
            doit faire partie du jeu de valeurs <value-of select="$jdv_Appareil"/>.
        </assert>
    </rule>
</pattern>
    <!--Start pattern based on abstract dansJeuDeValeurs--><pattern xmlns:svs="urn:ihe:iti:svs:2008" id="JDV_OMSInterpret-CISIS">
    <p>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</p>
    <rule context="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.12.2.5']/cda:entry/cda:observation/cda:interpretationCode">
        <let name="att_code" value="@code"/>
        <let name="att_codeSystem" value="@codeSystem"/>
        <let name="att_displayName" value="@displayName"/>
        
        <assert test="(not(@nullFlavor) or 1)">
           [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/component/section/entry/observation/interpretationCode"/>" ne doit pas comporter d'attribut nullFlavor.
        </assert> 
        
        <assert test="(             (@code and @codeSystem and @displayName) or             (1 and              (@nullFlavor='UNK' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )">
            [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/component/section/entry/observation/interpretationCode"/>" doit avoir ses attributs 
            @code, @codeSystem et @displayName renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </assert>
        
        <assert test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_OMSInterpret)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )">
        
            [dansJeuDeValeurs] L'élément <value-of select="ClinicalDocument/component/structuredBody/component/section/component/section/entry/observation/interpretationCode"/>
            [<value-of select="$att_code"/>:<value-of select="$att_displayName"/>:<value-of select="$att_codeSystem"/>] 
            doit faire partie du jeu de valeurs <value-of select="$jdv_OMSInterpret"/>.
        </assert>
    </rule>
</pattern>
    <!--Start pattern based on abstract dansJeuDeValeurs--><pattern xmlns:svs="urn:ihe:iti:svs:2008" id="JDV_PrimSecTumeur-CISIS">
    <p>Conformité d'un élément codé obligatoire par rapport à un jeu de valeurs du CI-SIS</p>
    <rule context="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.3.14.1']/cda:entry/cda:act/cda:entryRelationship/cda:observation[cda:code/@code='G-1009']/cda:value">
        <let name="att_code" value="@code"/>
        <let name="att_codeSystem" value="@codeSystem"/>
        <let name="att_displayName" value="@displayName"/>
        
        <assert test="(not(@nullFlavor) or 1)">
           [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/entry/act/entryRelationship/observation/value"/>" ne doit pas comporter d'attribut nullFlavor.
        </assert> 
        
        <assert test="(             (@code and @codeSystem and @displayName) or             (1 and              (@nullFlavor='UNK' or              @nullFlavor='NASK' or              @nullFlavor='ASKU' or              @nullFlavor='NI' or              @nullFlavor='NAV' or              @nullFlavor='MSK' or              @nullFlavor='OTH')) or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE'))             )">
            [dansJeuDeValeurs] L'élément "<value-of select="ClinicalDocument/component/structuredBody/component/section/entry/act/entryRelationship/observation/value"/>" doit avoir ses attributs 
            @code, @codeSystem et @displayName renseignés, ou si le nullFlavor est autorisé, une valeur admise pour cet attribut, ou un xsi:type différent de CD ou CE.
        </assert>
        
        <assert test="(             @nullFlavor or             (@xsi:type and not(@xsi:type = 'CD') and not(@xsi:type = 'CE')) or              (document($jdv_PrimSecTumeur)//svs:Concept[@code=$att_code and @codeSystem=$att_codeSystem])             )">
        
            [dansJeuDeValeurs] L'élément <value-of select="ClinicalDocument/component/structuredBody/component/section/entry/act/entryRelationship/observation/value"/>
            [<value-of select="$att_code"/>:<value-of select="$att_displayName"/>:<value-of select="$att_codeSystem"/>] 
            doit faire partie du jeu de valeurs <value-of select="$jdv_PrimSecTumeur"/>.
        </assert>
    </rule>
</pattern>
    
    
    
    <pattern id="Entete_FRCP">
   
        
        
    <rule context="cda:ClinicalDocument/cda:recordTarget/cda:patientRole">
        
            
         
        
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
</pattern>
    <pattern id="S_cancerDiagnosis_FRCP">


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
</pattern>
    <pattern id="S_codedReasonForReferral_FRCP">
    <rule context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.2&#34;]"> 
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId=2">
            [S_codedReasonForReferral_FRCP.sch] Erreur de conformité au volet FRCP : Coded Reason for referral doit contenir deux templateId (cardinalité [2..2])
        </assert>
         
        <assert test="../cda:section"> 
            [S_codedReasonForReferral_FRCP.sch] Erreur de conformité au volet FRCP : Ce composant ne peut être utilisé qu'en tant que section. 
        </assert> 
         
        <assert test="cda:code[@code = &#34;42349-1&#34;]"> 
            [S_codedReasonForReferral_FRCP.sch] Erreur de conformité au volet FRCP : Le code de la section doit être 42349-1 
        </assert> 
        <assert test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"> 
            [S_codedReasonForReferral_FRCP.sch] Erreur de conformité au volet FRCP : Le code de la section doit être tiré de la terminologie LOINC (2.16.840.1.113883.6.1). 
        </assert> 
        <assert test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.5&#34;]"> 
            
            [S_codedReasonForReferral_FRCP.sch] Erreur de conformité au volet FRCP : La section doit contenir au moins une entrée 
            du type Conditions Entry  (1.3.6.1.4.1.19376.1.5.3.1.4.5).            
        </assert> 
        <assert test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.13&#34;]"> 
            
            [S_codedReasonForReferral_FRCP.sch] Erreur de conformité au volet FRCP : La section doit contenir au moins une entrée
            du type Simple Observations  (1.3.6.1.4.1.19376.1.5.3.1.4.13).            
        </assert> 
    </rule> 
</pattern>
    <pattern id="E_simpleObservation_FRCP">
   
        
        
    <rule context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.2&#34;]"> 
            
         
        
        <assert test="not(./cda:entry/cda:observation/cda:value[@code='RCP_026']) or (./cda:entry/cda:observation/cda:entryRelationship/cda:observation/cda:code[@code='RCP_099'])">
            [E_simpleObservation_FRCP] Erreur de conformité au volet FRCP : L'appareil concerné (RCP_099)doit être présent. 
        </assert>
        
               
        <assert test="not(./cda:entry/cda:observation[cda:value/@code='RCP_026']/cda:entryRelationship/cda:observation/cda:code[@code='RCP_099']) or              ./cda:entry/cda:observation[cda:value/@code='RCP_026']/cda:entryRelationship[@typeCode='SUBJ']/cda:observation/cda:code[@code='RCP_099']">
            [E_simpleObservation_FRCP] Erreur de conformité au volet FRCP : La valeur de @typeCode est @typeCode='SUBJ'. 
        </assert>
        
                                     
        
        
        <assert test="not(./cda:entry/cda:observation/cda:value[@code='RCP_026'])              or (./cda:entry/cda:observation[cda:value/@code='RCP_026']/cda:entryRelationship/cda:observation/cda:entryRelationship/cda:observation/cda:code[@code='RCP_093'])">
            [E_simpleObservation_FRCP] Erreur de conformité au volet FRCP : Le type de d'organe concerné (RCP_093) doit être figuré. 
        </assert>
            
        <assert test="not(./cda:entry/cda:observation/cda:value[@code='RCP_026']) or              ./cda:entry/cda:observation/cda:entryRelationship/cda:observation/cda:entryRelationship[@typeCode='REFR']/cda:observation/cda:code[@code='RCP_093']">
            [E_simpleObservation_FRCP] Erreur de conformité au volet FRCP : La valeur de @typeCode est 'REFR'. 
        </assert>
        
        
        
        
        <assert test="not(./cda:entry/cda:observation/cda:value[@code='RCP_027']) or (./cda:entry/cda:observation/cda:entryRelationship/cda:observation/cda:code[@code='RCP_110'])">
            [E_simpleObservation_FRCP] Erreur de conformité au volet FRCP : Les soins et traitements (RCP_110) doivent être présents. 
        </assert>
        

        
    </rule>
</pattern>
    
    
    
    
    
    
    
    
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
    

    
    
    
    
    <pattern id="variables">

        
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


        
        
        
        <rule context="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.1.8&#34;]">
            
            
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
            
            
        </rule>
    </pattern>
</schema>