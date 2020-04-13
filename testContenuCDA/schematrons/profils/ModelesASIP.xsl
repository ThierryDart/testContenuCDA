<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:cda="urn:hl7-org:v3"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:jdv="http://esante.gouv.fr"
                xmlns:svs="urn:ihe:iti:svs:2008"
                xmlns:lab="urn:oid:1.3.6.1.4.1.19376.1.3.2"
                version="2.0"><!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. -->
<xsl:param name="archiveDirParameter"/>
   <xsl:param name="archiveNameParameter"/>
   <xsl:param name="fileNameParameter"/>
   <xsl:param name="fileDirParameter"/>
   <xsl:variable name="document-uri">
      <xsl:value-of select="document-uri(/)"/>
   </xsl:variable>

   <!--PHASES-->


<!--PROLOG-->
<xsl:output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" method="xml"
               omit-xml-declaration="no"
               standalone="yes"
               indent="yes"/>

   <!--XSD TYPES FOR XSLT2-->


<!--KEYS AND FUNCTIONS-->


<!--DEFAULT RULES-->


<!--MODE: SCHEMATRON-SELECT-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<xsl:template match="*" mode="schematron-select-full-path">
      <xsl:apply-templates select="." mode="schematron-get-full-path-2"/>
   </xsl:template>

   <!--MODE: SCHEMATRON-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<xsl:template match="*" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">
            <xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>*:</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>[namespace-uri()='</xsl:text>
            <xsl:value-of select="namespace-uri()"/>
            <xsl:text>']</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="preceding"
                    select="count(preceding-sibling::*[local-name()=local-name(current())                                   and namespace-uri() = namespace-uri(current())])"/>
      <xsl:text>[</xsl:text>
      <xsl:value-of select="1+ $preceding"/>
      <xsl:text>]</xsl:text>
   </xsl:template>
   <xsl:template match="@*" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">@<xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>@*[local-name()='</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>' and namespace-uri()='</xsl:text>
            <xsl:value-of select="namespace-uri()"/>
            <xsl:text>']</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!--MODE: SCHEMATRON-FULL-PATH-2-->
<!--This mode can be used to generate prefixed XPath for humans-->
<xsl:template match="node() | @*" mode="schematron-get-full-path-2">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="preceding-sibling::*[name(.)=name(current())]">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>
   <!--MODE: SCHEMATRON-FULL-PATH-3-->
<!--This mode can be used to generate prefixed XPath for humans 
	(Top-level element has index)-->
<xsl:template match="node() | @*" mode="schematron-get-full-path-3">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="parent::*">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>

   <!--MODE: GENERATE-ID-FROM-PATH -->
<xsl:template match="/" mode="generate-id-from-path"/>
   <xsl:template match="text()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')"/>
   </xsl:template>
   <xsl:template match="comment()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')"/>
   </xsl:template>
   <xsl:template match="processing-instruction()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.@', name())"/>
   </xsl:template>
   <xsl:template match="*" mode="generate-id-from-path" priority="-0.5">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')"/>
   </xsl:template>

   <!--MODE: GENERATE-ID-2 -->
<xsl:template match="/" mode="generate-id-2">U</xsl:template>
   <xsl:template match="*" mode="generate-id-2" priority="2">
      <xsl:text>U</xsl:text>
      <xsl:number level="multiple" count="*"/>
   </xsl:template>
   <xsl:template match="node()" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>n</xsl:text>
      <xsl:number count="node()"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="string-length(local-name(.))"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="translate(name(),':','.')"/>
   </xsl:template>
   <!--Strip characters--><xsl:template match="text()" priority="-1"/>

   <!--SCHEMA SETUP-->
<xsl:template match="/">
      <xsl:processing-instruction xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="xml-stylesheet">type="text/xsl" href="rapportSchematronToHtml4.xsl"</xsl:processing-instruction>
      <xsl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl"/>
      <svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                              title="Rapport de conformité du document aux spécifications françaises (corps – sections, entrées, jeux de valeurs ASIP)"
                              schemaVersion="ModelesASIP.sch">
         <xsl:attribute name="phase">modelesASIP</xsl:attribute>
         <xsl:attribute name="document">
            <xsl:value-of select="document-uri(/)"/>
         </xsl:attribute>
         <xsl:attribute name="dateHeure">
            <xsl:value-of select="format-dateTime(current-dateTime(), '[D]/[M]/[Y] à [H]:[m]:[s] (temps UTC[Z])')"/>
         </xsl:attribute>
         <xsl:text/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_allergiesIntolerances_ANS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M6"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_BilanCancérologie_ANS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M7"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_bilanPre-therapeutique_ASIP</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M8"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_cadrePropositionTherapeutique_ANS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M9"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_citationDocuments</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M10"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_comment</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M11"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_conclusionCR-ACP_ASIP</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M12"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_conclusionCRO_ASIP</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M13"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_diagnosticSortie_ANS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M14"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_dischargeDiagnosis</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M15"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_dispositifs_medicaux_ASIP</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M16"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_dispositionsMedicoSociales_ASIP</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M17"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_documentsAjoutes_ANS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M18"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_documentsReferences_ANS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M19"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_dossier_ANS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M20"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_elementsCliniquesRapportes_ASIP</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M21"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_facteursDeRisqueCode_ASIP</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M22"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_facteursDeRisque_ANS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M23"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_historiqueExamensBiologiques_ASIP</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M24"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_informationAssure_ASIP</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M25"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_Interpretation_ANS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M26"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_laborAndDelivery_ASIP</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M27"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_MotifHospitalisation_ANS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M28"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_noteProgression_ANS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M29"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_pathologieAntecedentsAllergiesFacteursDeRiques_ASIP</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M30"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_pathologieAntecedentsAllergies_ASIP</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M31"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_protheseEtObjetPersonnel_ASIP</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M32"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_resultatExamBio_ANS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M33"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_resultatLaboBioSeconde_ANS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M34"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_scoreEvaluationClinique_ANS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M35"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_scoreGlasgow_ASIP</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M36"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_scoreNIHSS_ASIP</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M37"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_scoreRankin_ASIP</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M38"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_statutCasPresenteQuorum_ASIP</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M39"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_statutDoc</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M40"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_statutDossPresenteRCP_ANS</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M41"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_traitementLongCours_ASIP</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M42"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_traitementsMR</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M43"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">S_TraitementsSortie</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M44"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_dispositifMedical-2_ASIP</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M45"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_dispositifMedicalComplement_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M46"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_dispositifMedicalImplante_fr</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M47"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_observationNIHSSComponent_ASIP</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M48"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_observationScoreNIHSS_ASIP</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M49"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_organizerDocumentAttache_ASIP</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M50"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_organizerRCP_ASIP</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M51"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">E_organizerTraitementInitialAVC_ASIP</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M52"/>
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Rapport de conformité du document aux spécifications françaises (corps – sections, entrées, jeux de valeurs ASIP)</svrl:text>

   <!--PATTERN S_allergiesIntolerances_ANSSection Allergies et intolérances ANS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Section Allergies et intolérances ANS</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.2.8&#34;]" priority="1000"
                 mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.2.8&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_allergiesIntolerances_ANS] Erreur de conformité PCC : Allergies et intolérances doit contenir au moins un templateId
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_allergiesIntolerances_ANS]: Allergies et intolérances ne peut être utilisé que dans une section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;48765-2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_allergiesIntolerances_ANS]: Le code de la section Allergies and Intolerance doit être 48765-2
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_allergiesIntolerances_ANS]: L'élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M6"/>
   <xsl:template match="@*|node()" priority="-2" mode="M6">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

   <!--PATTERN S_BilanCancérologie_ANSCI-SIS - Section Bilan Cancérologie-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS - Section Bilan Cancérologie</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.2.59&#34;]" priority="1000"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.2.59&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_BilanCancérologie_ANS.sch] erreur de conformité CI-SIS (ANS) :  'Bilan Cancérologie' ne peut être utilisé que comme section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_BilanCancérologie_ANS.sch] erreur de conformité CI-SIS (ANS) : L'élément doit contenir un id unique (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_BilanCancérologie_ANS.sch] erreur de conformité CI-SIS (ANS) : Un élément texte doit être présent dans la section éléments cliniques rapportés
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;72135-7&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_BilanCancérologie_ANS.sch] erreur de conformité CI-SIS (ANS) : Le code de la section 'Bilan Cancérologie' doit être '72135-7' 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_BilanCancérologie_ANS.sch] erreur de conformité CI-SIS (ANS) : L'attribut 'codeSystem' de la section a pour valeur '2.16.840.1.113883.6.1' (LOINC). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="//cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.36'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_BilanCancérologie_ANS.sch] erreur de conformité CI-SIS (ANS) : Une sous-section de type Plan de soin codé est obligatoire (1.3.6.1.4.1.19376.1.5.3.1.3.36)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="//cda:templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.1.13.7'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_BilanCancérologie_ANS.sch] erreur de conformité CI-SIS (ANS) : Une sous-section de type Résultats d’évènements codé est obligatoire (1.3.6.1.4.1.19376.1.7.3.1.1.13.7)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="//cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.28'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_BilanCancérologie_ANS.sch] erreur de conformité CI-SIS (ANS) : Une sous-section de type Résultats d’examens codé est obligatoire (1.3.6.1.4.1.19376.1.5.3.1.3.28)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M7"/>
   <xsl:template match="@*|node()" priority="-2" mode="M7">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

   <!--PATTERN S_bilanPre-therapeutique_ASIPASIP Santé Section bilan pré-thérapeutique-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ASIP Santé Section bilan pré-thérapeutique</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.42&#34;]" priority="1000"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.42&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_bilanPre-therapeutique_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un templateId (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_bilanPre-therapeutique_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_bilanPre-therapeutique_ASIP.sch]  Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_bilanPre-therapeutique_ASIP.sch]  Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un élément text
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;AVC-182&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_bilanPre-therapeutique_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section Abdomen doit être AVC-182 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:entry) or cda:entry/cda:organizer/cda:templateId/@root='1.2.250.1.213.1.1.3.16'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_scoreGlasgow_ASIP.sch]  Erreur de Conformité CI-SIS (Section ASIP Santé) : Les entrées optionnelles autorisées sont : 
            Organizer Traitement initial AVC (1.2.250.1.213.1.1.3.16)
            
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M8"/>
   <xsl:template match="@*|node()" priority="-2" mode="M8">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

   <!--PATTERN S_cadrePropositionTherapeutique_ANSSection cadre Proposition Therapeutique ANS -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Section cadre Proposition Therapeutique ANS </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.45&#34;]" priority="1000"
                 mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.45&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_cadrePropositionTherapeutique_ANS.sch] Erreur de Conformité CI-SIS : La section doit contenir un templateId
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_cadrePropositionTherapeutique_ANS.sch]  Erreur de Conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_cadrePropositionTherapeutique_ANS.sch]  Erreur de Conformité CI-SIS : La section doit contenir un id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_cadrePropositionTherapeutique_ANS.sch]  Erreur de Conformité CI-SIS : La section doit contenir un élément text
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;35510-7&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_cadrePropositionTherapeutique_ANS.sch]  Erreur de Conformité CI-SIS : Le code de cette section doit être 35510-7
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_cadrePropositionTherapeutique_ANS.sch]  Erreur de Conformité CI-SIS : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="//cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_cadrePropositionTherapeutique_ANS.sch]  Erreur de Conformité CI-SIS : L'entrée Simple observation est obligatoire (1.3.6.1.4.1.19376.1.5.3.1.4.13)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M9"/>
   <xsl:template match="@*|node()" priority="-2" mode="M9">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </xsl:template>

   <!--PATTERN S_citationDocumentsCI-SIS Citation de documents Section-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Citation de documents Section</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.2.55&#34;]" priority="1000"
                 mode="M10">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.2.55&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_citationDocuments_ASIP.sch] Erreur de Conformité CI-SIS (ASIP Santé): La section Références externes ne peut être utilisée que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:templateId)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_citationDocuments_ASIP.sch] Erreur de Conformité CI-SIS (ASIP Santé) : La section Références externes ne doit contenir qu'un seul templateId.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_citationDocuments_ASIP.sch] Erreur de Conformité CI-SIS (ASIP Santé) : La section Références externes doit contenir un et un seul élément id.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_citationDocuments_ASIP.sch] Erreur de Conformité CI-SIS (ASIP Santé) : La section Références externes doit contenir un élément text.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;55107-7&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_citationDocuments_ASIP.sch] Erreur de Conformité CI-SIS (ASIP Santé) : Le code de la section Références externes doit être '55107-7'.              
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_citationDocuments_ASIP.sch] Erreur de Conformité CI-SIS (ASIP Santé) : L'élément 'codeSystem' de la section Références externes doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.4&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            
            [S_citationDocuments_ASIP.sch] Erreur de Conformité CI-SIS (ASIP Santé) : La section Références externes doit contenir des entrée de type "Références externes" (1.3.6.1.4.1.19376.1.5.3.1.4.4).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M10"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M10"/>
   <xsl:template match="@*|node()" priority="-2" mode="M10">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M10"/>
   </xsl:template>

   <!--PATTERN S_comment-->


	<!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.2.47&#34;]" priority="1000"
                 mode="M11">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.2.47&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_Comment] Erreur de Conformité CI-SIS : Ce composant ne peut être utilisé qu'en tant que section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:templateId)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_Comment] Erreur de Conformité CI-SIS : Un Seul templateId doit être présent pour cette section
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;48767-8&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_Comment] Erreur de Conformité CI-SIS : Le code de la section doit être 48767-8 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_Comment] Erreur de Conformité CI-SIS : Le code de la section doit être tiré de la terminologie LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.13&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            
            [S_Comment] Erreur de Conformité CI-SIS : La section doit contenir des entrées 
            du type Simple Observation Entry  (1.3.6.1.4.1.19376.1.5.3.1.4.13).
            
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M11"/>
   <xsl:template match="@*|node()" priority="-2" mode="M11">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/>
   </xsl:template>

   <!--PATTERN S_conclusionCR-ACP_ASIPASIP Santé Section CR-ACP -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ASIP Santé Section CR-ACP </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.34&#34;]" priority="1000"
                 mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.34&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_conclusionCR-ACP_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un templateId (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_conclusionCR-ACP_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_conclusionCR-ACP_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un élément text
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_conclusionCR-ACP_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;30954-2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_conclusionCR-ACP_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section Abdomen doit être 30954-2 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_statutCasPresenteQuorum_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:component/cda:section) or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.13.2.11' or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.8.1.2.5'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_statutCasPresenteQuorum_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Les sous sections optionelles autorisées sont : 
            Procédures et interventions (1.3.6.1.4.1.19376.1.5.3.1.1.13.2.11)
            conclusion CR-ACP (1.3.6.1.4.1.19376.1.8.1.2.5)            
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M12"/>
   <xsl:template match="@*|node()" priority="-2" mode="M12">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>

   <!--PATTERN S_conclusionCRO_ASIPASIP Santé Section conclusion CRO -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ASIP Santé Section conclusion CRO </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.26&#34;]" priority="1000"
                 mode="M13">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.26&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_conclusionCRO_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un templateId (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_conclusionCRO_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_conclusionCRO_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_conclusionCRO_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un élément text
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;10218-6&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_conclusionCRO_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section Conclusion du CRO doit être 10218-6 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_laborAndDelivery_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M13"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M13"/>
   <xsl:template match="@*|node()" priority="-2" mode="M13">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M13"/>
   </xsl:template>

   <!--PATTERN S_diagnosticSortie_ANSANS Section diagnostic de sortie-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ANS Section diagnostic de sortie</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.5&#34;]" priority="1000"
                 mode="M14">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.5&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId &gt;0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_diagnosticSortie_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : La section doit contenir un templateId au moins (cardinalité [1..*])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_diagnosticSortie_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)&lt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_diagnosticSortie_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : La section doit contenir au maximum un seul id (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;11535-2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_diagnosticSortie_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : Le code de la section 'Dossier' doit être '11535-2'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M14"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M14"/>
   <xsl:template match="@*|node()" priority="-2" mode="M14">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M14"/>
   </xsl:template>

   <!--PATTERN S_dischargeDiagnosis-->


	<!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.7&#34;]" priority="1000"
                 mode="M15">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.3.7&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_dischargeDiagnosis] Erreur de Conformité PCC: Ce composant ne peut être utilisé qu'en tant que section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:templateId)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_dischargeDiagnosis] Erreur de Conformité PCC: Un seul templateId doit être présent pour cette section
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;11535-2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_dischargeDiagnosis] Erreur de Conformité PCC: Le code de la section doit être 11535-2
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_dischargeDiagnosis] Erreur de Conformité PCC: Le code de la section doit être tiré de la terminologie LOINC (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.5.2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            
            [S_dischargeDiagnosis] Erreur de Conformité PCC: La section doit contenir des entrées 
            du type Problem Concern Entry   (1.3.6.1.4.1.19376.1.5.3.1.4.5.2).
            
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M15"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M15"/>
   <xsl:template match="@*|node()" priority="-2" mode="M15">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M15"/>
   </xsl:template>

   <!--PATTERN S_dispositifs_medicaux_ASIPASIP Santé Section dispositifs médicaux-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ASIP Santé Section dispositifs médicaux</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.2.250.1.213.1.1.2.1']" priority="1002"
                 mode="M16">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.2.250.1.213.1.1.2.1']"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_dispositifs_medicaux_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un seul templateId (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_dispositifs_medicaux_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_dispositifs_medicaux_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_dispositifs_medicaux_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un élément text
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;46264-8&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_dispositifs_medicaux_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section Dispositifs médicaux doit être 46264-8 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_dispositifs_medicaux_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' correspond à la nomenclature LOINC (2.16.840.1.113883.6.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:entry) or cda:entry/cda:organizer/cda:templateId/@root='1.2.250.1.213.1.1.3.2' or cda:entry/cda:supply/cda:templateId/@root='1.2.250.1.213.1.1.3.20'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_dispositifs_medicaux_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section Dispositifs médicaux doit contenir des entrées 'Dipositif médical' :
            - de type 'organizer' (1.2.250.1.213.1.1.3.2) (ancienne version utilisée uniquement pour les volets PRC et LDL) ;
            - de type 'supply' (1.2.250.1.213.1.1.3.20) (nouvelle version). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.2.250.1.213.1.1.2.1']/cda:entry/cda:organizer/cda:templateId"
                 priority="1001"
                 mode="M16">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.2.250.1.213.1.1.2.1']/cda:entry/cda:organizer/cda:templateId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(../../../cda:entry/cda:supply)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_dispositifs_medicaux_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section Dispositifs médicaux doit contenir des entrées 'Dipositif médical' de type organizer (1.2.250.1.213.1.1.3.2) ou de type supply (1.2.250.1.213.1.1.3.20) mais pas les deux
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--REPORT -->
<xsl:if test="not(@root='1.2.250.1.213.1.1.3.2')">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="not(@root='1.2.250.1.213.1.1.3.2')">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
            [S_dispositifs_medicaux_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section Dispositifs médicaux doit contenir des entrées 'Dipositif médical' de type 'organizer' (1.2.250.1.213.1.1.3.2) (ancienne version utilisée uniquement pour les volets PRC et LDL) ;
        </svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root='1.2.250.1.213.1.1.2.1']/cda:entry/cda:supply/cda:templateId"
                 priority="1000"
                 mode="M16">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='1.2.250.1.213.1.1.2.1']/cda:entry/cda:supply/cda:templateId"/>

		    <!--REPORT -->
<xsl:if test="not(@root='1.2.250.1.213.1.1.3.20' or @root='2.16.840.1.113883.10.20.1.34')">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="not(@root='1.2.250.1.213.1.1.3.20' or @root='2.16.840.1.113883.10.20.1.34')">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
            [S_dispositifs_medicaux_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section Dispositifs médicaux doit contenir des entrées 'Dipositif médical' de type 'supply' (1.2.250.1.213.1.1.3.20 et 2.16.840.1.113883.10.20.1.35) (nouvelle version). 
        </svrl:text>
         </svrl:successful-report>
      </xsl:if>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:templateId/@root='1.2.250.1.213.1.1.3.20'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_dispositifs_medicaux_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'entrée 'Dipositif médical' de type 'supply' doit avoir le templateId root="1.2.250.1.213.1.1.3.20"
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M16"/>
   <xsl:template match="@*|node()" priority="-2" mode="M16">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/>
   </xsl:template>

   <!--PATTERN S_dispositionsMedicoSociales_ASIPASIP Santé  Section score Glasgow -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ASIP Santé  Section score Glasgow </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.44&#34;]" priority="1000"
                 mode="M17">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.44&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_dispositionsMedicoSociales_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un templateId (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_dispositionsMedicoSociales_ASIP.sch]  Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_dispositionsMedicoSociales_ASIP.sch]  Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_dispositionsMedicoSociales_ASIP.sch]  Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un élément text
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;34841-7&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_dispositionsMedicoSociales_ASIP.sch]  Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section Abdomen doit être 35088-4 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_dispositionsMedicoSociales_ASIP.sch]  Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:entry) or cda:entry/cda:observation/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_scoreGlasgow_ASIP.sch]  Erreur de Conformité CI-SIS (Section ASIP Santé) : Les entrées optionnelles autorisées sont : 
            simple observation (1.3.6.1.4.1.19376.1.5.3.1.4.13)     
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M17"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M17"/>
   <xsl:template match="@*|node()" priority="-2" mode="M17">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M17"/>
   </xsl:template>

   <!--PATTERN S_documentsAjoutes_ANSANS Section Documents ajoutés-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ANS Section Documents ajoutés</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.37&#34;]" priority="1000"
                 mode="M18">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.37&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_documentsAjoutes_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : La section doit contenir un templateId (cardinalité [1..*])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_documentsAjoutes_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)&lt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_documentsAjoutes_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : La section doit contenir au maximum un seul id (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_documentsAjoutes_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : La section doit contenir un élément text
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;55107-7&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_documentsAjoutes_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : Le code de cette section doit être '55107-7'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_documentsAjoutes_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : Le code de la section doit être un code LOINC  
            system (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="//cda:templateId[@root = &#34;1.2.250.1.213.1.1.3.18&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_documentsAjoutes_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : L'entrée Document attaché (1.2.250.1.213.1.1.3.18) est obligatoirement présente dans cette section
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M18"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M18"/>
   <xsl:template match="@*|node()" priority="-2" mode="M18">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M18"/>
   </xsl:template>

   <!--PATTERN S_documentsReferences_ANSANS Section Documents référencés-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ANS Section Documents référencés</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.55&#34;]" priority="1000"
                 mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.55&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_documentsReferences_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : La section doit contenir un templateId (cardinalité [1..*])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_documentsReferences_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)&lt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_documentsReferences_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : La section doit contenir au maximum un seul id (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;55107-7&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_documentsReferences_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : Le code de cette section doit être '55107-7'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_documentsReferences_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : Le code de la section doit être un code LOINC  
            system (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="//cda:templateId[@root = &#34;1.3.6.1.4.1.19376.1.5.3.1.4.4&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_documentsReferences_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : L'entrée Références externes (1.3.6.1.4.1.19376.1.5.3.1.4.4) est obligatoirement présente dans cette section
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M19"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M19"/>
   <xsl:template match="@*|node()" priority="-2" mode="M19">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M19"/>
   </xsl:template>

   <!--PATTERN S_dossier_ANSANS Section Dossier-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ANS Section Dossier</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.66&#34;]" priority="1000"
                 mode="M20">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.66&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_dossier_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : La section doit contenir un templateId (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_dossier_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)&lt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_dossier_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : La section doit contenir au maximum un seul id (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;GEN-168&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_dossier_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : Le code de la section 'Dossier' doit être 'GEN-168'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M20"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M20"/>
   <xsl:template match="@*|node()" priority="-2" mode="M20">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M20"/>
   </xsl:template>

   <!--PATTERN S_elementsCliniquesRapportes_ASIPCI-SIS - Section Eléments Cliniques Rapportés-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS - Section Eléments Cliniques Rapportés</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.2.46&#34;]" priority="1000"
                 mode="M21">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.2.46&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_elementsCliniquesRapportes_ASIP.sch] erreur de conformité CI-SIS (ASIP Santé) :  'Eléments Cliniques Rapportés' ne peut être utilisé que comme section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_elementsCliniquesRapportes_ASIP.sch] erreur de conformité CI-SIS (ASIP Santé) : L'élément doit contenir un id unique (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_elementsCliniquesRapportes_ASIP.sch] erreur de conformité CI-SIS (ASIP Santé) : Un élément texte doit être présent dans la section éléments cliniques rapportés
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;55107-7&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_elementsCliniquesRapportes_ASIP.sch] erreur de conformité CI-SIS (ASIP Santé) : Le code de la section 'Eléments Cliniques Rapportés' doit être '55107-7' 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_elementsCliniquesRapportes_ASIP.sch] erreur de conformité CI-SIS (ASIP Santé) : L'attribut 'codeSystem' de la section a pour valeur '2.16.840.1.113883.6.1' (LOINC). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.2.250.1.213.1.1.3.18&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_elementsCliniquesRapportes_ASIP.sch] erreur de conformité CI-SIS (ASIP Santé) : Cette section doit contenir un organizer 'Document Attaché'. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(.//cda:templateId[@root = &#34;1.2.250.1.213.1.1.3.18&#34;])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
           
            [S_elementsCliniquesRapportes_ASIP.sch] erreur de conformité CI-SIS (ASIP Santé) : L'organizer 'Document Attaché' de cette section doit être identifié comme 'Information Clinique'. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M21"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M21"/>
   <xsl:template match="@*|node()" priority="-2" mode="M21">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M21"/>
   </xsl:template>

   <!--PATTERN S_facteursDeRisqueCode_ASIPASIP Santé Section Facteurs de risque codé-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ASIP Santé Section Facteurs de risque codé</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.31&#34;]" priority="1000"
                 mode="M22">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.31&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_facteursDeRisqueCode_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir au moins un templateId
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_facteursDeRisqueCode_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_facteursDeRisqueCode_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;57207-3&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_facteursDeRisqueCode_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section 'Facteurs de risque' doit être '57207-3' </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_facteursDeRisqueCode_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:component/cda:section) or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.16.1' or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.5.3.1' or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.15'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_facteursDeRisqueCode_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Les sous-sections optionnelles possibles sont :  
            Habitus, mode de vie (Coded Social History - 1.3.6.1.4.1.19376.1.5.3.1.3.16.1)
            Facteurs de risque professionnels (Hazardous Working Conditions - 1.3.6.1.4.1.19376.1.5.3.1.1.5.3.1)
            Antécédents familiaux (Coded Family Medical History - 1.3.6.1.4.1.19376.1.5.3.1.3.15)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(not(cda:component/cda:section) and cda:text) or (count(cda:component/cda:section)=3 and not(cda:text)) or (count(cda:component/cda:section)&lt;3 and cda:component/cda:section)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_facteursDeRisqueCode_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : 
            Si aucune des 3 sous-sections optionnelles n’est présente : l’élément text est requis . Dans ce cas le contenu de la section est intégralement non structuré.
            Si les 3 sous-sections optionnelles sont présentes : l’élément text est interdit. En effet, chacune est porteuse de son propre texte en plus de ses données structurées. Ce cas correspond à la structuration maximale de cette section.
            Dans les autres cas, l’élément text peut être présent et il porte le texte correspondant à une ou plusieurs sous-sections optionnelles absentes.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M22"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M22"/>
   <xsl:template match="@*|node()" priority="-2" mode="M22">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M22"/>
   </xsl:template>

   <!--PATTERN S_facteursDeRisque_ANSANS Section Facteurs de risque -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ANS Section Facteurs de risque </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.7&#34;]" priority="1000"
                 mode="M23">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.7&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId&gt;0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_facteursDeRisque_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : La section doit contenir un templateId (cardinalité [1..*])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_facteursDeRisque_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_facteursDeRisque_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : La section doit contenir un id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;57207-3&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_facteursDeRisque_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : Le code de la section 'Facteurs de risque' doit être '57207-3'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_facteursDeRisque_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M23"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M23"/>
   <xsl:template match="@*|node()" priority="-2" mode="M23">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M23"/>
   </xsl:template>

   <!--PATTERN S_historiqueExamensBiologiques_ASIPASIP Santé Section Historique des examens biologiues -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ASIP Santé Section Historique des examens biologiues </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.28&#34;]" priority="1000"
                 mode="M24">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.28&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_historiqueExamensBiologiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un templateId (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_historiqueExamensBiologiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_historiqueExamensBiologiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_historiqueExamensBiologiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un élément text
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;26436-6&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_historiqueExamensBiologiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section Abdomen doit être 57074-7 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_historiqueExamensBiologiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:component/cda:section) or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.1.13.7'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_historiqueExamensBiologiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Labor and Delivery peut contenir une sous section PCC coded Event outcomes (templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.1.13.7')
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M24"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M24"/>
   <xsl:template match="@*|node()" priority="-2" mode="M24">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M24"/>
   </xsl:template>

   <!--PATTERN S_informationAssure_ASIPASIP Santé  Section information assuré -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ASIP Santé  Section information assuré </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.38&#34;]" priority="1000"
                 mode="M25">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.38&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_InformationAssure_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un templateId (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_InformationAssure_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_InformationAssure_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_InformationAssure_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un élément text
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;35525-4&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_InformationAssure_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section Abdomen doit être 35525-4 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:entry) or cda:entry/cda:organizer/cda:templateId/@root='1.2.250.1.213.1.1.3.18'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_InformationAssure_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Les entrées optionnelles autorisées sont : 
            Organizer document attaché (1.2.250.1.213.1.1.3.18)     
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M25"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M25"/>
   <xsl:template match="@*|node()" priority="-2" mode="M25">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M25"/>
   </xsl:template>

   <!--PATTERN S_Interpretation_ANSCI-SIS - Section Interpretation-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS - Section Interpretation</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.2.58&#34;]" priority="1000"
                 mode="M26">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.2.58&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_Interpretation_ANS.sch] erreur de conformité CI-SIS (ANS) :  'Interpretation' ne peut être utilisé que comme section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_Interpretation_ANS.sch] erreur de conformité CI-SIS (ANS) : L'élément doit contenir un id unique (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_Interpretation_ANS.sch] erreur de conformité CI-SIS (ANS) : Un élément texte doit être présent dans la section éléments cliniques rapportés
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;22030-1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_Interpretation_ANS.sch] erreur de conformité CI-SIS (ANS) : Le code de la section 'Interpretation' doit être '22030-1' 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_Interpretation_ANS.sch] erreur de conformité CI-SIS (ANS) : L'attribut 'codeSystem' de la section a pour valeur '2.16.840.1.113883.6.1' (LOINC). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="//cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.36'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_Interpretation_ANS.sch] erreur de conformité CI-SIS (ANS) : Une sous-section de type Plan de soin codé est obligatoire (1.3.6.1.4.1.19376.1.5.3.1.3.36)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="//cda:templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.1.13.7'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_Interpretation_ANS.sch] erreur de conformité CI-SIS (ANS) : Une sous-section de type Résultats d’évènements codé est obligatoire (1.3.6.1.4.1.19376.1.7.3.1.1.13.7)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="//cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.28'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_Interpretation_ANS.sch] erreur de conformité CI-SIS (ANS) : Une sous-section de type Résultats d’examens codé est obligatoire (1.3.6.1.4.1.19376.1.5.3.1.3.28)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="//cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.6'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_Interpretation_ANS.sch] erreur de conformité CI-SIS (ANS) : Une sous-section de type Problèmes actifs codé est obligatoire (1.3.6.1.4.1.19376.1.5.3.1.3.6)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="//cda:templateId/@root='1.2.250.1.213.1.1.2.37'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_Interpretation_ANS.sch] erreur de conformité CI-SIS (ANS) : Une sous-section de type Documents ajoutés est obligatoire (1.2.250.1.213.1.1.2.37)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M26"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M26"/>
   <xsl:template match="@*|node()" priority="-2" mode="M26">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M26"/>
   </xsl:template>

   <!--PATTERN S_laborAndDelivery_ASIPASIP Santé Section Labor and delivery -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ASIP Santé Section Labor and delivery </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.13&#34;]" priority="1000"
                 mode="M27">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.13&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_laborAndDelivery_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir au moins un templateId (cardinalité [1..*])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_laborAndDelivery_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_laborAndDelivery_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_laborAndDelivery_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un élément text
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;57074-7&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_laborAndDelivery_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section Abdomen doit être 57074-7
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_laborAndDelivery_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M27"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M27"/>
   <xsl:template match="@*|node()" priority="-2" mode="M27">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M27"/>
   </xsl:template>

   <!--PATTERN S_MotifHospitalisation_ANSSection Motif d'hospitalisation ANS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Section Motif d'hospitalisation ANS</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.6&#34;]" priority="1000"
                 mode="M28">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.6&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_MotifHospitalisation_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : La section doit contenir un templateId (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_MotifHospitalisation_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_MotifHospitalisation_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : La section doit contenir un id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;46241-6&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_MotifHospitalisation_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : Le code de la section Abdomen doit être 46241-6 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_historiqueExamensBiologiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ANS) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M28"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M28"/>
   <xsl:template match="@*|node()" priority="-2" mode="M28">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M28"/>
   </xsl:template>

   <!--PATTERN S_noteProgression_ANSSection note de progression ANS -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Section note de progression ANS </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.25&#34;]" priority="1000"
                 mode="M29">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.25&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_noteProgression_ANS.sch] Erreur de Conformité CI-SIS : La section doit contenir un templateId (cardinalité [1..*])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_noteProgression_ANS.sch]  Erreur de Conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_noteProgression_ANS.sch]  Erreur de Conformité CI-SIS : La section doit contenir un id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_noteProgression_ANS.sch]  Erreur de Conformité CI-SIS : La section doit contenir un élément text
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;18733-6&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_noteProgression_ANS.sch]  Erreur de Conformité CI-SIS : Le code de la section Abdomen doit être 18733-6
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_noteProgression_ANS.sch]  Erreur de Conformité CI-SIS : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="//cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_noteProgression_ANS.sch]  Erreur de Conformité CI-SIS : L'entrée Simple observation est obligatoire (1.3.6.1.4.1.19376.1.5.3.1.4.13)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M29"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M29"/>
   <xsl:template match="@*|node()" priority="-2" mode="M29">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M29"/>
   </xsl:template>

   <!--PATTERN S_pathologieAntecedentsAllergiesFacteursDeRiques_ASIPASIP Santé Section pathologie, antécédents, allergies et facteurs de risques  -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ASIP Santé Section pathologie, antécédents, allergies et facteurs de risques  </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.29&#34;]" priority="1000"
                 mode="M30">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.29&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_pathologieAntecedentsAllergiesFacteursDeRiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un templateId (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_pathologieAntecedentsAllergiesFacteursDeRiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_pathologieAntecedentsAllergiesFacteursDeRiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_pathologieAntecedentsAllergiesFacteursDeRiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un élément text
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;46612-8&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_pathologieAntecedentsAllergiesFacteursDeRiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section 'Pathologie, antécédents, allergies et facteurs de risques' doit être '46612-8' </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_pathologieAntecedentsAllergiesFacteursDeRiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:component/cda:section/cda:templateId/@root='1.2.250.1.213.1.1.2.30' and cda:component/cda:section/cda:templateId/@root='1.2.250.1.213.1.1.2.31'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_pathologieAntecedentsAllergiesFacteursDeRiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section 'Pathologie, antécédents, allergies et facteurs de risques' contient obligatoirement les sous sections 'Pathologie en cours, antécédents et allergies'
            (1.2.250.1.213.1.1.2.30) et 'Facteurs de risque' (1.2.250.1.213.1.1.2.31)           
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M30"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M30"/>
   <xsl:template match="@*|node()" priority="-2" mode="M30">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M30"/>
   </xsl:template>

   <!--PATTERN S_pathologieAntecedentsAllergies_ASIPASIP Santé Section Pathologie, antécédents, allergies  -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ASIP Santé Section Pathologie, antécédents, allergies  </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.30&#34;]" priority="1000"
                 mode="M31">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.30&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_pathologieAntecedentsAllergies_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un templateId (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_pathologieAntecedentsAllergies_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_pathologieAntecedentsAllergies_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;34117-2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_pathologieAntecedentsAllergies_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section Pathologie, antécédents, allergies doit être '34117-2' </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_pathologieAntecedentsAllergies_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:component/cda:section) or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.6' or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.8'             or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.12' or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.13'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_pathologieAntecedentsAllergies_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Les sous-sections optionnelles possibles sont :  
            Problèmes actifs (Active problems - 1.3.6.1.4.1.19376.1.5.3.1.3.6)
            Antécédents médicaux (History of past illness - 1.3.6.1.4.1.19376.1.5.3.1.3.8)
            Antécédents chirurgicaux (Coded List of Surgeries - 1.3.6.1.4.1.19376.1.5.3.1.3.12)
            Allergies et intolérances (Allergies and intolerances - 1.3.6.1.4.1.19376.1.5.3.1.3.13)            
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(not(cda:component/cda:section) and cda:text) or (count(cda:component/cda:section)=4 and not(cda:text)) or (count(cda:component/cda:section)&lt;4 and cda:component/cda:section)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_pathologieAntecedentsAllergies_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : 
            Si aucune des 4 sous-sections optionnelles n’est présente : l’élément text est requis . Dans ce cas le contenu de la section est intégralement non structuré.
            Si les 4 sous-sections optionnelles sont présentes : l’élément text est interdit. En effet, chacune est porteuse de son propre texte en plus de ses données structurées. Ce cas correspond à la structuration maximale de cette section.
            Dans les autres cas, l’élément text peut être présent et il porte le texte correspondant à une ou plusieurs sous-sections optionnelles absentes.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M31"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M31"/>
   <xsl:template match="@*|node()" priority="-2" mode="M31">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M31"/>
   </xsl:template>

   <!--PATTERN S_protheseEtObjetPersonnel_ASIPASIP Santé  Section information assuré -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ASIP Santé  Section information assuré </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.53&#34;]" priority="1000"
                 mode="M32">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.53&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_ProtheseEtObjetPersonnel_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un templateId (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_ProtheseEtObjetPersonnel_ASIP] Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_ProtheseEtObjetPersonnel_ASIP] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_ProtheseEtObjetPersonnel_ASIP] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un élément text
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;46264-8&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_ProtheseEtObjetPersonnel_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section Abdomen doit être 46264-8 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_ProtheseEtObjetPersonnel_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:entry) or cda:entry/cda:observation/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_ProtheseEtObjetPersonnel_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Les entrées optionnelles autorisées sont : 
            simple observation (1.3.6.1.4.1.19376.1.5.3.1.4.13)     
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M32"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M32"/>
   <xsl:template match="@*|node()" priority="-2" mode="M32">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M32"/>
   </xsl:template>

   <!--PATTERN S_resultatExamBio_ANSSection Résultats d'examens Biologiques ANS -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Section Résultats d'examens Biologiques ANS </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.10&#34;]" priority="1000"
                 mode="M33">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.10&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_resultatExamBio_ANS.sch] Erreur de Conformité CI-SIS : La section doit contenir un templateId (cardinalité [1..*])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_resultatExamBio_ANS.sch]  Erreur de Conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_resultatExamBio_ANS.sch]  Erreur de Conformité CI-SIS : La section doit contenir un id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_resultatExamBio_ANS.sch]  Erreur de Conformité CI-SIS : La section doit contenir un élément text
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M33"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M33"/>
   <xsl:template match="@*|node()" priority="-2" mode="M33">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M33"/>
   </xsl:template>

   <!--PATTERN S_resultatLaboBioSeconde_ANSSection Résultats de laboratoire de biologie de seconde intention ANS -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Section Résultats de laboratoire de biologie de seconde intention ANS </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.60&#34;]" priority="1000"
                 mode="M34">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.60&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_resultatLaboBioSeconde_ANS.sch] Erreur de Conformité CI-SIS : La section doit contenir un templateId (cardinalité [1..*])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_resultatLaboBioSeconde_ANS.sch]  Erreur de Conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)&gt;0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_resultatLaboBioSeconde_ANS.sch]  Erreur de Conformité CI-SIS : La section doit contenir un id au moins(cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_resultatLaboBioSeconde_ANS.sch]  Erreur de Conformité CI-SIS : La section doit contenir un élément text
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M34"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M34"/>
   <xsl:template match="@*|node()" priority="-2" mode="M34">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M34"/>
   </xsl:template>

   <!--PATTERN S_scoreEvaluationClinique_ANSSection score Evaluation Clinique ANS -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Section score Evaluation Clinique ANS </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.41&#34;]" priority="1000"
                 mode="M35">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.41&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_scoreEvaluationClinique_ANS.sch] Erreur de Conformité CI-SIS : La section doit contenir un templateId
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_scoreEvaluationClinique_ANS.sch]  Erreur de Conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_scoreEvaluationClinique_ANS.sch]  Erreur de Conformité CI-SIS : La section doit contenir un id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_scoreEvaluationClinique_ANS.sch]  Erreur de Conformité CI-SIS : La section doit contenir un élément text
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;47420-5&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_scoreEvaluationClinique_ANS.sch]  Erreur de Conformité CI-SIS : Le code de la section Abdomen doit être 47420-5
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_scoreEvaluationClinique_ANS.sch]  Erreur de Conformité CI-SIS : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="//cda:templateId/@root='1.2.250.1.213.1.1.2.40' and //cda:templateId/@root='1.2.250.1.213.1.1.2.40' and //cda:templateId/@root='1.2.250.1.213.1.1.2.36'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_scoreEvaluationClinique_ANS.sch]  Erreur de Conformité CI-SIS : Les entrées optionnelles autorisées sont : 
            score de rankin (1.2.250.1.213.1.1.2.39)
            score de glasgow (1.2.250.1.213.1.1.2.40)
            score NIHSS (1.2.250.1.213.1.1.2.36)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M35"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M35"/>
   <xsl:template match="@*|node()" priority="-2" mode="M35">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M35"/>
   </xsl:template>

   <!--PATTERN S_scoreGlasgow_ASIPASIP Santé  Section score Glasgow -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ASIP Santé  Section score Glasgow </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.40&#34;]" priority="1000"
                 mode="M36">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.40&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_scoreGlasgow_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un templateId (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_scoreGlasgow_ASIP.sch]  Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_scoreGlasgow_ASIP.sch]  Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_scoreGlasgow_ASIP.sch]  Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un élément text
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;35088-4&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_scoreGlasgow_ASIP.sch]  Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section Abdomen doit être 35088-4 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_scoreGlasgow_ASIP.sch]  Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:entry) or cda:entry/cda:observation/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_scoreGlasgow_ASIP.sch]  Erreur de Conformité CI-SIS (Section ASIP Santé) : Les entrées optionnelles autorisées sont : 
            simple observation (1.3.6.1.4.1.19376.1.5.3.1.4.13)     
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M36"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M36"/>
   <xsl:template match="@*|node()" priority="-2" mode="M36">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M36"/>
   </xsl:template>

   <!--PATTERN S_scoreNIHSS_ASIPASIP Santé  Section score NIHSS -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ASIP Santé  Section score NIHSS </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.36&#34;]" priority="1000"
                 mode="M37">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.36&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_scoreNIHSS_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un templateId (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_scoreNIHSS_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_scoreNIHSS_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_scoreNIHSS_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un élément text
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;70182-1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_scoreNIHSS_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section Abdomen doit être 70182-1 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_scoreNIHSS_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:entry) or cda:entry/cda:observation/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_scoreNIHSS_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'entrée optionnelle autorisée est l'entrée simple observation templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'        
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M37"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M37"/>
   <xsl:template match="@*|node()" priority="-2" mode="M37">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M37"/>
   </xsl:template>

   <!--PATTERN S_scoreRankin_ASIPASIP Santé  Section information assuré -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ASIP Santé  Section information assuré </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.39&#34;]" priority="1000"
                 mode="M38">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.39&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_scoreRankin_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : la section doit contenir un templateId (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_scoreRankin_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_scoreRankin_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : la section doit contenir un id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_scoreRankin_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : la section doit contenir un élément text
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;MED-381&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_scoreRankin_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section Abdomen doit être MED-381 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:entry) or cda:entry/cda:observation/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_scoreRankin_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Les entrées optionnelles autorisées sont : 
            simple observation (1.3.6.1.4.1.19376.1.5.3.1.4.13)     
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M38"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M38"/>
   <xsl:template match="@*|node()" priority="-2" mode="M38">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M38"/>
   </xsl:template>

   <!--PATTERN S_statutCasPresenteQuorum_ASIPASIP Santé Section Statut du cas présenté et Quorum -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ASIP Santé Section Statut du cas présenté et Quorum </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.33&#34;]" priority="1000"
                 mode="M39">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.33&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_statutCasPresenteQuorum_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un templateId (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_statutCasPresenteQuorum_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_statutCasPresenteQuorum_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_statutCasPresenteQuorum_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un élément text
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;21874-3&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_statutCasPresenteQuorum_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section Abdomen doit être 21874-3 </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_statutCasPresenteQuorum_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:entry) or cda:entry/cda:organizer/cda:templateId/@root='1.2.250.1.213.1.1.3.7'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_statutCasPresenteQuorum_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'entrée optionnelle autorisée est organizer RCP templateId/@root='1.2.250.1.213.1.1.3.7'        
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M39"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M39"/>
   <xsl:template match="@*|node()" priority="-2" mode="M39">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M39"/>
   </xsl:template>

   <!--PATTERN S_statutDocASIP Section Statut du document-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ASIP Section Statut du document</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.2.35&#34;]" priority="1000"
                 mode="M40">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.2.35&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
                [S_statutDoc] Erreur de conformité CI-SIS : 'Statut du document' ne peut être utilisé que comme section
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;33557-0&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_statutDoc] Erreur de conformité CI-SIS : Le code de la section 'Statut du document' doit être '33557-0'              
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
                [S_statutDoc] Erreur de conformité CI-SIS :  L'élément 'codeSystem' de la section 
                'Statut du document' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:title"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_statutDoc] Erreur de conformité CI-SIS : Cette section doit avoir un titre significatif de son contenu.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_statutDoc] Erreur de conformité CI-SIS : La section doit avoir un identifiant unique permettant de les identifier.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:templateId)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_statutDoc] Erreur de conformité CI-SIS : Un seul templateId doit être présent pour cette section
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:entry/cda:observation/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_statutDoc] Erreur de conformité CI-SIS : Cette section comporte obligatoirement une simple Observation
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M40"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M40"/>
   <xsl:template match="@*|node()" priority="-2" mode="M40">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M40"/>
   </xsl:template>

   <!--PATTERN S_statutDossPresenteRCP_ANSANS Section statut du dossier présenté en RCP-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ANS Section statut du dossier présenté en RCP</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.33&#34;]" priority="1000"
                 mode="M41">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.33&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_statutDossPresenteRCP_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : La section doit contenir un templateId (cardinalité [1..*])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_statutDossPresenteRCP_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)&lt;2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_statutDossPresenteRCP_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : La section doit contenir au maximum un seul id (cardinalité [0..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;21874-3&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_statutDossPresenteRCP_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : Le code de cette section doit être '21874-3'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_statutDossPresenteRCP_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : Le code de la section doit être un code LOINC  
            system (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="//cda:templateId[@root = &#34;1.2.250.1.213.1.1.3.7&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_statutDossPresenteRCP_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : L'entrée Statut du dossier présenté en RCP (1.2.250.1.213.1.1.3.7) est obligatoirement présente dans cette section
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M41"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M41"/>
   <xsl:template match="@*|node()" priority="-2" mode="M41">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M41"/>
   </xsl:template>

   <!--PATTERN S_traitementLongCours_ASIPASIP Santé Section Traitement au long cours -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ASIP Santé Section Traitement au long cours </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.32&#34;]" priority="1000"
                 mode="M42">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.2.32&#34;]"/>
      <xsl:variable name="count_templateId" select="count(cda:templateId)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$count_templateId = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_traitementLongCours_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un templateId (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_traitementLongCours_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_traitementLongCours_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;18776-5&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_traitementLongCours_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section 'Traitement au long cours' doit être '18776-5' </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_traitementLongCours_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:component/cda:section) or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.19'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_traitementLongCours_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La sous-section optionnelle est la section Traitements (Medications - 1.3.6.1.4.1.19376.1.5.3.1.3.19).         
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(not(cda:component/cda:section) and cda:text) or (cda:component/cda:section and not(cda:text))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [S_traitementLongCours_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : 
            La section doit contenir un élément text s’il n’y a pas de sous-section Traitement (1.3.6.1.4.1.19376.1.5.3.1.3.19).
            La section ne doit pas contenir d’élément text s’il y a une ou plusieurs sous-sections Traitement (1.3.6.1.4.1.19376.1.5.3.1.3.19)
                    
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M42"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M42"/>
   <xsl:template match="@*|node()" priority="-2" mode="M42">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M42"/>
   </xsl:template>

   <!--PATTERN S_traitementsMRSection S_traitementsMR-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Section S_traitementsMR</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.2.54&#34;]" priority="1000"
                 mode="M43">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.2.54&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_traitementsMR] Erreur de Conformité : Le templateId de 'traitementsMR' ne peut être utilisé que pour une section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;10160-0&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_traitementsMR] Erreur de Conformité  : Le code de la section 'traitementsMR doit être '10160-0' 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_traitementsMR] Erreur de Conformité  : Le code de la section doit être un code LOINC  
            system (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=".//cda:templateId[@root = &#34;1.2.250.1.213.1.1.3.13&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            
            [S_traitementsMR] Erreur de Conformité  : La section traitementsMR doit contenir des entrées de type "Traitement Maladie rare" (1.2.250.1.213.1.1.3.13).
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M43"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M43"/>
   <xsl:template match="@*|node()" priority="-2" mode="M43">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M43"/>
   </xsl:template>

   <!--PATTERN S_TraitementsSortieSection Traitements à la sortie-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Section Traitements à la sortie</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.2.4&#34;]" priority="1000"
                 mode="M44">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.2.4&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="../cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_TraitementsSortie] Erreur de Conformité : Le templateId de 'Traitements à la sortie' ne peut être utilisé que pour une section. 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@code = &#34;10183-2&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_TraitementsSortie] Erreur de Conformité  : Le code de la section 'Traitements à la sortie doit être '10160-0' 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code[@codeSystem = &#34;2.16.840.1.113883.6.1&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            [S_TraitementsSortie] Erreur de Conformité  : Le code de la section doit être un code LOINC  
            system (2.16.840.1.113883.6.1). 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M44"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M44"/>
   <xsl:template match="@*|node()" priority="-2" mode="M44">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M44"/>
   </xsl:template>

   <!--PATTERN E_dispositifMedical-2_ASIPEntrée Dispositif médical ASIP-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Entrée Dispositif médical ASIP</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.3.20&#34;]" priority="1000"
                 mode="M45">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.3.20&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:supply[@classCode='SPLY' and @moodCode='EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_dispositifMedical-2_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Les attributs @classCode et @moodCode de l'élément 'supply' doivent être fixés respectivement aux valeurs 'SPLY' et 'EVN'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:templateId[@root=&#34;1.2.250.1.213.1.1.3.20&#34;])=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_dispositifMedical-2_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'entrée Dispositif médical, il doit y avoir un 'templateId' avec un attribut root='1.2.250.1.213.1.1.3.20'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.34&#34;])=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_dispositifMedical-2_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'entrée Dispositif médical, il doit y avoir un 'templateId' avec un attribut root='2.16.840.1.113883.10.20.1.34'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:effectiveTime)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_dispositifMedical-2_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'entrée Dispositif médical, il doit y avoir un seul (et un seul) 'effectiveTime'. Si la date n’est pas connue, utiliser la valeur nullFlavor="UNK".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:participant"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_dispositifMedical-2_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'entrée Dispositif médical, au moins un élément 'participant' est obligatoire.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:participant/cda:participantRole[@classCode='MANU'])=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_dispositifMedical-2_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'entrée Dispositif médical, un (et un seul) élément 'participant/participantRole' est obligatoire avec un attribut classCode="MANU".
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:participant/cda:participantRole/cda:playingDevice[@classCode='DEV' and @determinerCode='INSTANCE'])=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_dispositifMedical-2_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'entrée Dispositif médical, il doit y avoir un seul (et un seul) élément 'participant/participantRole/playingDevice' avec les attributs @classCode et @determinerCode respectivement fixés aux valeurs 'DEV' et 'INSTANCE'.
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M45"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M45"/>
   <xsl:template match="@*|node()" priority="-2" mode="M45">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M45"/>
   </xsl:template>

   <!--PATTERN E_dispositifMedicalComplement_frCI-SIS Dispositif Médical Implante" (1.2.250.1.213.1.1.3.1)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Dispositif Médical Implante" (1.2.250.1.213.1.1.3.1)</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.3.1&#34;]" priority="1000"
                 mode="M46">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.3.1&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="@classCode=&#34;OBS&#34; and @moodCode=&#34;EVN&#34;"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
         [E_dispositifMedicalComplement_fr]: Erreur de conformité CI-SIS : L'élément organizer doit avoir ses attributs fixés ainsi: classCode="OBS" et moodCode="EVN"
      </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:templateId[@root=&#34;1.2.250.1.213.1.1.3.1&#34;])=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
         [E_dispositifMedicalComplement_fr]: Erreur de conformité CI-SIS : L'élément organizer doit avoir un élément templateId avec un attribut root='1.2.250.1.213.1.1.3.1'
      </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:templateId[@root=&#34;1.3.6.1.4.1.19376.1.5.3.1.4.13&#34;])=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
         [E_dispositifMedicalComplement_fr]: Erreur de conformité CI-SIS : L'élément organizer doit avoir un élément templateId avec un attribut root='1.3.6.1.4.1.19376.1.5.3.1.4.13'
      </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
         [E_dispositifMedicalComplement_fr]: Erreur de conformité CI-SIS : Un élément "Dispositif Médical - Complément" comporte obligatoirement un élément "id".</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:code)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
         [E_dispositifMedicalComplement_fr]: Erreur de conformité CI-SIS : Un élément "Dispositif Médical - Complément" ne doit comporter qu'un seul élément "code"</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:text/cda:reference)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
         [E_dispositifMedicalComplement_fr]: Erreur de conformité CI-SIS : Un élément "Dispositif Médical - Complément" doit comporter un élément "text" avec une référence</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:effectiveTime)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
         [E_dispositifMedicalComplement_fr]: Erreur de conformité CI-SIS : Un élément "Dispositif Médical - Complément" doit comporter un élément "effectiveTime" pour horodater l'observation</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:statusCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
         [E_dispositifMedicalComplement_fr]: Erreur de conformité CI-SIS : Un élément "Dispositif Médical Implanté" comporte obligatoirement un élément "statutCode" </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:value)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
         [E_dispositifMedicalComplement_fr]: Erreur de conformité CI-SIS : Un élément "Dispositif Médical Implanté" comporte obligatoirement un élément "value" pour donner une valeur à l'élément observé </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M46"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M46"/>
   <xsl:template match="@*|node()" priority="-2" mode="M46">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M46"/>
   </xsl:template>

   <!--PATTERN E_dispositifMedicalImplante_frCI-SIS Dispositif Médical Implante" (1.2.250.1.213.1.1.3.2)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">CI-SIS Dispositif Médical Implante" (1.2.250.1.213.1.1.3.2)</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.3.2&#34;]" priority="1000"
                 mode="M47">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.3.2&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="@classCode=&#34;CLUSTER&#34; and @moodCode=&#34;EVN&#34;"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
         [E_dispositifMedicalImplante_fr]: Erreur de conformité CI-SIS : L'élément 'organizer' doit comporter les attributs suivants : classCode="CLUSTER" et moodCode="EVN"
      </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:templateId[@root=&#34;1.2.250.1.213.1.1.3.2&#34;])=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
         [E_dispositifMedicalImplante_fr]: Erreur de conformité CI-SIS : L'élément 'organizer' doit comporter un élément 'templateId' avec un attribut root='1.2.250.1.213.1.1.3.2'
      </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
         [E_dispositifMedicalImplante_fr]: Erreur de conformité CI-SIS : Un élément "Dispositif Médical Implanté" comporte obligatoirement un élément "id".</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:code)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
         [E_dispositifMedicalImplante_fr]: Erreur de conformité CI-SIS : Un élément "Dispositif Médical Implanté" ne doit comporter qu'un seul élément "code"</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:statusCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
         [E_dispositifMedicalImplante_fr] Erreur de conformité CI-SIS : Un élément "Dispositif Médical Implanté" comporte obligatoirement un élément "statutCode" </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M47"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M47"/>
   <xsl:template match="@*|node()" priority="-2" mode="M47">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M47"/>
   </xsl:template>

   <!--PATTERN E_observationNIHSSComponent_ASIPASIP-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ASIP</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.3.8&#34;]" priority="1000"
                 mode="M48">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.3.8&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:observation[@classCode='OBS' and @moodCode='EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_observationNIHSSComponent_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation NIHSS component, les attributs @classCode, @moodCode de l'élément observation sont fixés resectivement aux valeurs 'OBS', 'EVN' </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_observationNIHSSComponent_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation NIHSS component, il doit y avoir un élément id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:templateId)=3"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_observationNIHSSComponent_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation NIHSS component, il doit y avoir trois templateId (crdinalité [3..3])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_observationNIHSSComponent_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation NIHSS component, il doit y avoir le template Id de la simple observation (’1.3.6.1.4.1.19376.1.5.3.1.4.13’)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId/@root='2.16.840.1.113883.10.20.1.31'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_observationNIHSSComponent_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation NIHSS component, Il doit y avoir le templateId/@root='2.16.840.1.113883.10.20.1.31'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode/@code='completed'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_observationNIHSSComponent_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation NIHSS component, le statusCode doit présent et fixé à la valeur @code='completed'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:effectiveTime"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_observationNIHSSComponent_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation NIHSS component, un élément effectiveTime doit être présent 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:value)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_observationNIHSSComponent_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation NIHSS component, il doit y avoir un élément value (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:interpretationCode)&lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
           [E_observationNIHSSComponent_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation NIHSS component, il peut y avoir un interpretationCode (cardinalité [0..1])
       </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M48"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M48"/>
   <xsl:template match="@*|node()" priority="-2" mode="M48">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M48"/>
   </xsl:template>

   <!--PATTERN E_observationScoreNIHSS_ASIPASIP-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ASIP</svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.3.6&#34;]" priority="1000"
                 mode="M49">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.3.6&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:observation[@classCode='OBS' and @moodCode='EVN' and @negationInd='false']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_observationScoreNIHSS_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation score NIHSS, les attributs @classCode, @moodCode et @negationInd de l'élément observation sont fixés resectivement aux valeurs 'OBS', 'EVN' et 'false'</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_observationScoreNIHSS_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation score NIHSS, il doit y avoir un élément id (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:templateId)=3"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_observationScoreNIHSS_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation score NIHSS, il doit y avoir trois templateId (crdinalité [3..3])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_observationScoreNIHSS_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation score NIHSS, il doit y avoir le template Id de la simple observation (’1.3.6.1.4.1.19376.1.5.3.1.4.13’)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:templateId/@root='2.16.840.1.113883.10.20.1.31'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_observationScoreNIHSS_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation score NIHSS, Il doit y avoir le templateId/@root='2.16.840.1.113883.10.20.1.31'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode/@code='completed'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_observationScoreNIHSS_ASIP.sch]  :Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation dispositif médicaux, le statusCode doit présent et fixé à la valeur @code='completed'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:effectiveTime"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_observationScoreNIHSS_ASIP.sch]  :Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation dispositif médicaux, un élément effectiveTime doit être présent 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:value)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_observationScoreNIHSS_ASIP.sch]  :Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation dispositif médicaux, il doit y avoir un élément value (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(cda:entryRelationship) or cda:entryRelationship/cda:observation/cda:templateId/@root='1.2.250.1.213.1.1.3.8'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_observationScoreNIHSS_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation score NIHSS, il ne peut y avoir que des observations NIHSS Component entry (1.2.250.1.213.1.1.3.8)
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M49"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M49"/>
   <xsl:template match="@*|node()" priority="-2" mode="M49">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M49"/>
   </xsl:template>

   <!--PATTERN E_organizerDocumentAttache_ASIPASIP Santé organizer RCP -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ASIP Santé organizer RCP </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.3.18&#34;]" priority="1000"
                 mode="M50">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root = &#34;1.2.250.1.213.1.1.3.18&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:organizer[@classCode = 'CLUSTER' and @moodCode = 'EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_organizerDocumentAttache_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans
            l'organizer Document attaché, les attributs @classCode et @moodCode de l'élément
            observation sont fixés resectivement aux valeurs 'CLUSTER' et 'EVN'</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:id) = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> [E_organizerDocumentAttache_ASIP.sch] Erreur de conformité
            CI-SIS (ASIP Santé) : Dans l'organizer Document attaché, il doit y avoir un élément id
            (cardinalité [1..1]) </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> [E_organizerDocumentAttache_ASIP.sch] Erreur de conformité CI-SIS
            (ASIP Santé) : Dans l'organizer Document attaché, l'élément code doit être présent </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode/@code = 'completed'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> [E_organizerDocumentAttache_ASIP.sch]
            Erreur de conformité CI-SIS (ASIP Santé) : Dans l'organizer Document attaché, le
            statusCode doit présent et fixé à la valeur @code='Completed' </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:component/cda:observation/cda:templateId/@root = '1.3.6.1.4.1.19376.1.5.3.1.4.13'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> [E_organizerDocumentAttache_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans
            l'organizer Document attaché,il doit y avoir au moins une simple observation
            (templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13') </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:component/cda:observationMedia[@classCode = 'OBS' and @moodCode = 'EVN']/cda:value[@mediaType and @representation = 'B64']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> [E_organizerDocumentAttache_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans
            l'organizer Document attaché, il doit y avoir au moins un observation media, contenant
            une value dont le XPath est le suivant :
            cda:component/cda:observationMedia[@classCode='OBS' and
            @moodCode='EVN']/cda:value[@mediaType='text/xml' and @representation='B64'] </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M50"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M50"/>
   <xsl:template match="@*|node()" priority="-2" mode="M50">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M50"/>
   </xsl:template>

   <!--PATTERN E_organizerRCP_ASIPASIP Santé organizer RCP -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ASIP Santé organizer RCP </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.3.7&#34;]" priority="1000"
                 mode="M51">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.3.7&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:organizer[@classCode='CLUSTER' and @moodCode='EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_organizerRCP_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'organizer RCP, les attributs @classCode et @moodCode de l'élément observation sont fixés resectivement aux valeurs 'CLUSTER' et 'EVN'</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_organizerRCP_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'organizer RCP, l'élément code doit être présent
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode/@code='completed'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_organizerRCP_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'organizer RCP, le statusCode doit présent et fixé à la valeur @code='completed'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:component/cda:observation/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            ’1.3.6.1.4.1.19376.1.5.3.1.4.13, il doit y avoir au moins une simple observation (templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13')
       </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M51"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M51"/>
   <xsl:template match="@*|node()" priority="-2" mode="M51">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M51"/>
   </xsl:template>

   <!--PATTERN E_organizerTraitementInitialAVC_ASIPASIP Santé organizer RCP -->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ASIP Santé organizer RCP </svrl:text>

	  <!--RULE -->
<xsl:template match="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.3.16&#34;]" priority="1000"
                 mode="M52">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;1.2.250.1.213.1.1.3.16&#34;]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="self::cda:organizer[@classCode='BATTERY' and @moodCode='EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_organizerTraitementInitialAVC_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'organizer traitement initial AVC, les attributs @classCode et @moodCode de l'élément observation sont fixés resectivement aux valeurs 'BATTERY' et 'EVN'</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_organizerTraitementInitialAVC_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'organizer traitement initial AVC, l'élément code doit être présent
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:statusCode/@code='completed'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_organizerTraitementInitialAVC_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'organizer traitement initial AVC, le statusCode doit présent et fixé à la valeur @code='completed'
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cda:author)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_organizerTraitementInitialAVC_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'organizer traitement initial AVC, il doit y avoir un élément author (cardinalité [1..1])
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="cda:component/cda:observation/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
            [E_organizerTraitementInitialAVC_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'organizer traitement initial AVC, il doit y avoir au moins une simple observation (templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13')
       </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M52"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M52"/>
   <xsl:template match="@*|node()" priority="-2" mode="M52">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M52"/>
   </xsl:template>
</xsl:stylesheet>