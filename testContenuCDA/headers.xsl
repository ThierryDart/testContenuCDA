<?xml version="1.0" encoding="UTF-8"?>
<!--
  Title : cda_asip.xsl / headers.xsl  
  =======================================================================================================================================================
  This StyleSheet is based on the StyleSheet "Modular CDA XSL StyleSheet (cda_modular.xsl)" made by Alchuler Associates LCC.
  Below is the original declaration of Alschuler Associates LCC
  Title: Modular CDA XSL StyleSheet
  Original Filename: headers.xsl 
  Version: 3.0
  Revision History: 8/12/09 Jingdong Li updated 
  Specification: ANSI/HL7 CDA, R2-2005  
  The current version and documentation are available at www.alschulerassociates.com/cda/?topic=cda-xsl. 
  We welcome feedback to tools@alschulerassociates.com
  The stylesheet is the cumulative work of several developers; the most significant prior milestones were the foundation work from HL7 
  Germany and Finland (Tyylitiedosto) and HL7 US (Calvin Beebe), and the presentation approach from Tony Schaller, medshare GmbH provided at IHIC 2009. 
  =======================================================================================================================================================
  Suivi des version de la feuille de style française (ANS) :
    - The original StyleSheet has been modified for FRANCE in order to :
          - Translate the labels from english to french
          - Edit supplementary informations
          - Detect a Xades envelopping signature of a Clinical Document
          - Add comments in case of impossibility to edit pdf files in nonXMLBody and within structuredBody with IE/EDGE and Firefox 3.x
    - 16/06/2015 : Version 1.1.1
    - 24/05/2019 : Ajout commentaire dans 'participant' 
    - 03/12/2019 : Ajout de la profession dans 'participant'
    - 31/12/2019 : Modification pour afficher le nom de la personne ET le nom de sa structure dans 'participant'
  =======================================================================================================================================================    
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:n1="urn:hl7-org:v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <xsl:import href="utility.xsl"/>
  <!-- Eléments de l'en-tête -->
  
  <!-- Document -->
  <xsl:template name="documentGeneral"> Document <table class="header_table">
      <tbody>
        <!-- Type -->
        <tr>
          <td width="40%">
            <span class="td_label">
              <xsl:text>Type</xsl:text>
            </span>
          </td>
          <td width="40%">
            <xsl:call-template name="show-code">
              <xsl:with-param name="code" select="n1:code"/>
            </xsl:call-template>
          </td>
        </tr>
        <!-- Identifiant -->
        <tr>
          <td width="40%">
            <span class="td_label">
              <xsl:text>Identifiant</xsl:text>
            </span>
          </td>
          <td width="40%">
            <xsl:call-template name="show-id">
              <xsl:with-param name="id" select="n1:id"/>
            </xsl:call-template>
          </td>
        </tr>
        <!-- Version -->
        <tr>
          <td width="40%">
            <span class="td_label">
              <xsl:text>Version</xsl:text>
            </span>
          </td>
          <td width="40%">
            <xsl:value-of select="n1:versionNumber/@value"/>
          </td>
        </tr>
        <!-- Lot de ersion -->
        <tr>
          <td width="40%">
            <span class="td_label">
              <xsl:text>Lot de versions</xsl:text>
            </span>
          </td>
          <td width="40%">
            <xsl:call-template name="show-id">
              <xsl:with-param name="id" select="n1:setId"/>
            </xsl:call-template>
          </td>
        </tr>
        <!-- Date de création -->
        <tr>
          <td width="40%">
            <span class="td_label">
              <xsl:text>Création</xsl:text>
            </span>
          </td>
          <td width="40%">
            <xsl:call-template name="show-time">
              <xsl:with-param name="datetime" select="n1:effectiveTime"/>
            </xsl:call-template>
          </td>
        </tr>
        <!-- Domaine = FRANCE -->
        <tr>
          <td width="40%">
            <span class="td_label">
              <xsl:text>Domaine</xsl:text>
            </span>
          </td>
          <td width="40%">
            <xsl:call-template name="show-realmCode">
              <xsl:with-param name="realmCode" select="n1:realmCode"/>
            </xsl:call-template>
          </td>
        </tr>
        <!-- Modèle CDA -->
        <tr>
          <td width="40%">
            <span class="td_label">
              <xsl:text>Modèle CDA</xsl:text>
            </span>
          </td>
          <td width="40%">
            <xsl:call-template name="show-typeId">
              <xsl:with-param name="typeId" select="n1:typeId"/>
            </xsl:call-template>
          </td>
        </tr>
        <!-- OID de conformité -->
        <tr>
          <td width="40%">
            <span class="td_label">
              <xsl:text>Conformité</xsl:text>
            </span>
          </td>
          <td width="40%">
            <xsl:for-each select="n1:templateId">
              <xsl:call-template name="show-templateId"> </xsl:call-template>
              <br/>
            </xsl:for-each>
          </td>
        </tr>
        <!-- Langue principale -->
        <tr>
          <td width="40%">
            <span class="td_label">
              <xsl:text>Langue principale</xsl:text>
            </span>
          </td>
          <td width="40%">
            <xsl:call-template name="show-languageCode">
              <xsl:with-param name="languageCode" select="n1:languageCode"/>
            </xsl:call-template>
          </td>
        </tr> 
        <!-- Niveau de confidentialité -->
        <xsl:if test="n1:confidentialityCode">
          <tr>
            <td width="20%">
              <span class="td_label">
                <xsl:text>Niveau de confidentialité</xsl:text>
              </span>
            </td>
            <td width="80%">
              <xsl:choose>
                <xsl:when test="n1:confidentialityCode/@code = &apos;N&apos;">
                  <xsl:text>Normal</xsl:text>
                </xsl:when>
                <xsl:when test="n1:confidentialityCode/@code = &apos;R&apos;">
                  <xsl:text>Restreint</xsl:text>
                </xsl:when>
                <xsl:when test="n1:confidentialityCode/@code = &apos;V&apos;">
                  <xsl:text>Très restreint</xsl:text>
                </xsl:when>
              </xsl:choose>
              <xsl:if test="n1:confidentialityCode/n1:originalText">
                <xsl:text> </xsl:text>
                <xsl:value-of select="n1:confidentialityCode/n1:originalText"/>
              </xsl:if>
            </td>
          </tr>
        </xsl:if>
        <!-- Document remplacé -->
        <xsl:if test="n1:relatedDocument">
          <xsl:for-each select="n1:relatedDocument">
            <tr>
              <td width="20%">
                <span class="td_label">
                  <xsl:text>Ident. doc. remplacé</xsl:text>
                </span>
              </td>
              <td width="80%">
                <xsl:for-each select="n1:parentDocument/n1:id">
                  <xsl:call-template name="show-id"/>
                </xsl:for-each>
              </td>
            </tr>
            <tr>
              <td width="20%">
                <span class="td_label">
                  <xsl:text>Version</xsl:text>
                </span>
              </td>
              <td width="80%">
                <xsl:for-each select="n1:parentDocument">
                  <xsl:value-of select="n1:versionNumber/@value"/>
                </xsl:for-each>
              </td>
            </tr>
          </xsl:for-each>
        </xsl:if>
      </tbody>
    </table>
  </xsl:template>
 
  <!-- author = Auteur -->
  <xsl:template name="author">
    <xsl:if test="n1:author"> Auteur(s) <table class="header_table">
        <tbody>
          <xsl:for-each select="n1:author/n1:assignedAuthor">
            <tr>
              <td width="20%">
                <span class="td_label">
                  <xsl:text>Auteur</xsl:text>
                </span>
              </td>
              <td width="80%">
                <!-- Nom de l'auteur -->
                <xsl:if test="n1:assignedPerson/n1:name">
                  <xsl:call-template name="show-name">
                    <xsl:with-param name="name" select="n1:assignedPerson/n1:name"/>
                  </xsl:call-template>
                  <br/>
                  <!-- Identifiant de l'auteur -->
                  <xsl:call-template name="show-id">
                    <xsl:with-param name="id" select="n1:id"/>
                  </xsl:call-template>
                </xsl:if>
                <!-- Nom du dispositif (auteur) -->
                <xsl:if test="n1:assignedAuthoringDevice/n1:softwareName">
                  <xsl:value-of select="n1:assignedAuthoringDevice/n1:softwareName"/>
                </xsl:if>
                <!-- Adresse de l'auteur -->
                <xsl:if test="n1:addr">
                  <br/><br/>
                  <xsl:call-template name="show-address">
                    <xsl:with-param name="address" select="n1:addr"/>
                  </xsl:call-template>
                </xsl:if>
                <!-- Télécom de l'auteur -->
                <xsl:if test="n1:telecom">
                  <br/><br/>
                  <xsl:for-each select="n1:telecom">
                    <xsl:call-template name="show-telecom">
                      <xsl:with-param name="telecom" select="."/>
                    </xsl:call-template>
                  </xsl:for-each>
                </xsl:if>
              </td>
            </tr>
            <!-- Profession / spécialité de l'auteur -->
            <xsl:for-each select="n1:code">
              <tr>
                <td>
                  <span class="td_label">
                    <xsl:text>Profession</xsl:text>
                  </span>
                </td>
                <td>
                  <xsl:call-template name="show-code">
                    <xsl:with-param name="code" select="."/>
                  </xsl:call-template>
                </td>
              </tr>
            </xsl:for-each>
            <!-- Organisation de l'auteur -->
            <xsl:if test="n1:representedOrganization">
              <tr>
                <td width="20%">
                  <span class="td_label">
                    <xsl:text>Organisation</xsl:text>
                  </span>
                </td>
                <td width="80%">                  
                  <!-- Nom de l'organisation -->
                  <xsl:if test="n1:representedOrganization/n1:name">
                    <xsl:call-template name="show-name">
                      <xsl:with-param name="name" select="n1:representedOrganization/n1:name"/>
                    </xsl:call-template>
                  </xsl:if>
                  <!-- Identifiant de l'organisation -->
                  <xsl:if test="n1:representedOrganization/n1:id">
                    <br/>
                    <xsl:for-each select="n1:representedOrganization/n1:id">
                      <xsl:call-template name="show-id">
                        <xsl:with-param name="id" select="n1:representedOrganization/n1:id"/>
                      </xsl:call-template>
                    </xsl:for-each>
                  </xsl:if>
                  <!-- Adresse de l'organisation -->
                  <xsl:if test="n1:representedOrganization/n1:addr">
                    <br/><br/>
                    <xsl:call-template name="show-address">
                      <xsl:with-param name="address" select="n1:representedOrganization/n1:addr"/>
                    </xsl:call-template>
                  </xsl:if>
                  <!-- Télécom de l'organisation -->
                  <xsl:if test="n1:representedOrganization/n1:telecom">
                    <br/><br/>
                    <xsl:for-each select="n1:representedOrganization/n1:telecom">
                      <xsl:call-template name="show-telecom">
                        <xsl:with-param name="telecom" select="."/>
                      </xsl:call-template>
                    </xsl:for-each>
                  </xsl:if>
                </td>
              </tr>
            </xsl:if>
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>
  
  <!--  authenticator = PS attestant la validité du document -->
  <xsl:template name="authenticator">
    <xsl:if test="n1:authenticator"> Approbateurs <table class="header_table">
        <tbody>
          <xsl:for-each select="n1:authenticator">
            <tr>
              <td width="20%">
                <span class="td_label">
                  <xsl:text>Approbateur</xsl:text>
                </span>
              </td>
              <td width="80%">
                <xsl:call-template name="show-assignedEntity-name">
                  <xsl:with-param name="asgnEntity" select="n1:assignedEntity"/>
                </xsl:call-template>
                <br/>
                <xsl:if test="n1:assignedEntity/n1:addr">
                  <br/>
                  <xsl:call-template name="show-address">
                    <xsl:with-param name="address" select="n1:assignedEntity/n1:addr"/>
                  </xsl:call-template>
                </xsl:if>
                <xsl:if test="n1:assignedEntity/n1:telecom">
                  <br/><br/>
                  <xsl:for-each select="n1:assignedEntity/n1:telecom">
                    <xsl:call-template name="show-telecom">
                      <xsl:with-param name="telecom" select="."/>
                    </xsl:call-template>
                  </xsl:for-each>
                </xsl:if>
              </td>
            </tr>
            <tr>
              <td width="20%">
                <span class="td_label">
                  <xsl:text>Organisation</xsl:text>
                </span>
              </td>
              <td width="80%" colspan="3">
                <span style="font-weight:bold;">
                  <xsl:call-template name="show-assignedEntity-orga">
                    <xsl:with-param name="asgnEntity" select="n1:assignedEntity"/>
                  </xsl:call-template>
                </span>
                <br/>
                <xsl:call-template name="show-assignedEntity-orga-id">
                  <xsl:with-param name="asgnEntity" select="n1:assignedEntity"/>
                </xsl:call-template>
                <xsl:if test="n1:assignedEntity/n1:representedOrganization/n1:addr">
                  <br/>
                  <xsl:call-template name="show-address">
                    <xsl:with-param name="address"
                      select="n1:assignedEntity/n1:representedOrganization/n1:addr"/>
                  </xsl:call-template>
                </xsl:if>
                
                <xsl:if test="n1:assignedEntity/n1:representedOrganization/n1:telecom">
                  <br/><br/>
                  <xsl:for-each select="n1:assignedEntity/n1:representedOrganization/n1:telecom">
                    <xsl:call-template name="show-telecom">
                      <xsl:with-param name="telecom" select="."/>
                    </xsl:call-template>
                  </xsl:for-each>
                </xsl:if>
              </td>
            </tr>
            <tr>
              <td width="20%">
                <span class="td_label">
                  <xsl:text>Approuvé le</xsl:text>
                </span>
              </td>
              <td width="80%" colspan="3">
                <xsl:call-template name="show-time">
                  <xsl:with-param name="datetime" select="n1:time"/>
                </xsl:call-template>
              </td>
            </tr>
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>
  
  <!-- legalAuthenticator = Signataire légal -->
  <xsl:template name="legalAuthenticator">
    <xsl:if test="n1:legalAuthenticator"> Signataire légal <table class="header_table">
      <tbody>
          <!-- Signataire légal -->
          <tr>
            <td width="20%">
              <span class="td_label">
                <xsl:text>Signataire</xsl:text>
              </span>
            </td>
            <td width="80%">
              <!-- Nom et identifiant du signataire légal -->
              <xsl:call-template name="show-assignedEntity-name">
                <xsl:with-param name="asgnEntity" select="n1:legalAuthenticator/n1:assignedEntity"/>
              </xsl:call-template>
              <!-- Adresse du signataire légal -->
              <xsl:if test="n1:legalAuthenticator/n1:assignedEntity/n1:addr">
                <br/><br/>
                <xsl:call-template name="show-address">
                  <xsl:with-param name="address"
                    select="n1:legalAuthenticator/n1:assignedEntity/n1:addr"/>
                </xsl:call-template>
              </xsl:if>
              <!-- Télécom du signataire légal -->
              <xsl:if test="n1:legalAuthenticator/n1:assignedEntity/n1:telecom">
                <br/><br/>
                <xsl:for-each select="n1:legalAuthenticator/n1:assignedEntity/n1:telecom">
                  <xsl:call-template name="show-telecom">
                    <xsl:with-param name="telecom" select="."/>
                  </xsl:call-template>
                </xsl:for-each>
              </xsl:if>       
            </td>
          </tr>
          <!-- Organisation du Signataire légal -->
          <tr>
            <td width="20%">
              <span class="td_label">
                <xsl:text>Organisation</xsl:text>
              </span>
            </td>
            <td width="80%" colspan="3">
              <!-- Nom organisation du signataire légal -->
              <span style="font-weight:bold;">
                <xsl:call-template name="show-assignedEntity-orga">
                  <xsl:with-param name="asgnEntity" select="n1:legalAuthenticator/n1:assignedEntity"/>
                </xsl:call-template>
              </span>
              <br/>
              <xsl:call-template name="show-assignedEntity-orga-id">
                <xsl:with-param name="asgnEntity" select="n1:legalAuthenticator/n1:assignedEntity"/>
              </xsl:call-template>
              <!-- Adresse organisation du signataire légal -->
              <xsl:if
                test="n1:legalAuthenticator/n1:assignedEntity/n1:representedOrganization/n1:addr">
                <br/>
                <xsl:call-template name="show-address">
                  <xsl:with-param name="address"
                    select="n1:legalAuthenticator/n1:assignedEntity/n1:representedOrganization/n1:addr"/>
                </xsl:call-template>
              </xsl:if>
              <!-- Télécom organisation du signataire légal -->
              <xsl:if test="n1:legalAuthenticator/n1:assignedEntity/n1:representedOrganization/n1:telecom">
                <br/><br/>
                <xsl:for-each select="n1:legalAuthenticator/n1:assignedEntity/n1:representedOrganization/n1:telecom">
                  <xsl:call-template name="show-telecom">
                    <xsl:with-param name="telecom" select="."/>
                  </xsl:call-template>
                </xsl:for-each>
              </xsl:if>       
            </td>
          </tr>
          <!-- Signature -->
          <tr>
            <td width="20%">
              <span class="td_label">
                <xsl:text>Signature</xsl:text>
              </span>
            </td>
            <td>
              <xsl:call-template name="show-sig">
                <xsl:with-param name="sig" select="n1:legalAuthenticator/n1:signatureCode"/>
              </xsl:call-template>
              <xsl:if test="n1:legalAuthenticator/n1:time/@value">
                <xsl:text> le </xsl:text>
                <xsl:call-template name="show-time">
                  <xsl:with-param name="datetime" select="n1:legalAuthenticator/n1:time"/>
                </xsl:call-template>
              </xsl:if>
            </td>
          </tr>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>

  <!-- dataEnterer = Opérateur de saisie -->
  <xsl:template name="dataEnterer">
    <xsl:if test="n1:dataEnterer"> Rédacteur(s) <table class="header_table">
        <tbody>
          <tr>
            <td width="20%">
              <span class="td_label">
                <xsl:text>Rédacteur</xsl:text>
              </span>
            </td>
            <td width="80%">
              <xsl:call-template name="show-assignedEntity-name">
                <xsl:with-param name="asgnEntity" select="n1:dataEnterer/n1:assignedEntity"/>
              </xsl:call-template>
              <xsl:if test="n1:dataEnterer/n1:assignedEntity/n1:addr">
                <br/><br/>
                <xsl:call-template name="show-address">
                  <xsl:with-param name="address" select="n1:dataEnterer/n1:assignedEntity/n1:addr"/>
                </xsl:call-template>
              </xsl:if>
              <xsl:if test="n1:dataEnterer/n1:assignedEntity/n1:telecom">                
                <br/><br/>
                <xsl:for-each select="n1:dataEnterer/n1:assignedEntity/n1:telecom">
                  <xsl:call-template name="show-telecom">
                    <xsl:with-param name="telecom" select="."/>
                  </xsl:call-template>
                </xsl:for-each>
              </xsl:if>
            </td>
          </tr>
          <xsl:if test="n1:dataEnterer/n1:assignedEntity/n1:representedOrganization">
            <tr>
              <td width="20%">
                <span class="td_label">
                  <xsl:text>Organisation</xsl:text>
                </span>
              </td>
              <td width="80%" colspan="3">
                <span style="font-weight:bold; ">
                  <xsl:call-template name="show-assignedEntity-orga">
                    <xsl:with-param name="asgnEntity" select="n1:dataEnterer/n1:assignedEntity"/>
                  </xsl:call-template>
                </span>
                <br/>
                <xsl:call-template name="show-assignedEntity-orga-id">
                  <xsl:with-param name="asgnEntity" select="n1:dataEnterer/n1:assignedEntity"/>
                </xsl:call-template>
                <xsl:if test="n1:dataEnterer/n1:assignedEntity/n1:representedOrganization/n1:addr">
                  <br/>
                  <xsl:call-template name="show-address">
                    <xsl:with-param name="address"
                      select="n1:dataEnterer/n1:assignedEntity/n1:representedOrganization/n1:addr"/>
                  </xsl:call-template>
                </xsl:if>
                <xsl:if
                  test="n1:dataEnterer/n1:assignedEntity/n1:representedOrganization/n1:telecom">
                  <br/><br/>
                  <xsl:for-each
                    select="n1:dataEnterer/n1:assignedEntity/n1:representedOrganization/n1:telecom">
                    <xsl:call-template name="show-telecom">
                      <xsl:with-param name="telecom"
                        select="n1:dataEnterer/n1:assignedEntity/n1:representedOrganization/n1:telecom"
                      />
                    </xsl:call-template>
                  </xsl:for-each>
                </xsl:if>
              </td>
            </tr>
          </xsl:if>
          <tr>
            <td width="20%">
              <span class="td_label">
                <xsl:text>Rédigé le </xsl:text>
              </span>
            </td>
            <td>
              <xsl:call-template name="show-time">
                <xsl:with-param name="datetime" select="n1:dataEnterer/n1:time"/>
              </xsl:call-template>
            </td>
          </tr>
          <!-- <xsl:if test="n1:dataEnterer/n1:assignedEntity/n1:representedOrganization/n1:addr | n1:dataEnterer/n1:assignedEntity/n1:representedOrganization/n1:telecom"> -->
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>

  <!-- componentOf = Prise en charge -->
  <xsl:template name="componentof">
    <xsl:if test="n1:componentOf"> Prise en charge <table class="header_table">
        <tbody>
          <!-- Identifiant de la prise en charge --> 
          <xsl:if test="n1:componentOf/n1:encompassingEncounter/n1:id">
            <tr>
              <td width="20%">
                <span class="td_label">
                  <xsl:text>Identifiant</xsl:text>
                </span>
              </td>
              <td width="80%">
                <xsl:call-template name="show-id">
                  <xsl:with-param name="id" select="n1:componentOf/n1:encompassingEncounter/n1:id"/>
                </xsl:call-template>
              </td>
            </tr>
          </xsl:if>
          
          <!-- Type de prise en charge --> 
          <xsl:if test="n1:componentOf/n1:encompassingEncounter/n1:code">
            <tr>
              <td width="20%">
                <span class="td_label">
                  <xsl:text>Type</xsl:text>
                </span>
              </td>
              <td width="80%">
                <xsl:call-template name="show-code">
                  <xsl:with-param name="code"
                    select="n1:componentOf/n1:encompassingEncounter/n1:code"/>
                </xsl:call-template>
              </td>
            </tr>
          </xsl:if> 
          
          <!-- Date de la prise en charge --> 
          <xsl:if test="n1:componentOf/n1:encompassingEncounter/n1:effectiveTime">
            <xsl:if test="n1:componentOf/n1:encompassingEncounter/n1:effectiveTime/@value">
              <tr>
                <td width="20%">
                  <span class="td_label">
                    <xsl:text>Date</xsl:text>
                  </span>
                </td>
                <td colspan="3" width="80%">
                  <xsl:call-template name="show-time">
                    <xsl:with-param name="datetime"
                      select="n1:componentOf/n1:encompassingEncounter/n1:effectiveTime"/>
                  </xsl:call-template>
                </td>
              </tr>
            </xsl:if>
            <xsl:if test="n1:componentOf/n1:encompassingEncounter/n1:effectiveTime/n1:low">
              <tr>
                <td width="20%">
                  <span class="td_label">
                    <xsl:text>Début</xsl:text>
                  </span>
                </td>
                <td colspan="3" width="80%">
                  <xsl:call-template name="show-time">
                    <xsl:with-param name="datetime"
                      select="n1:componentOf/n1:encompassingEncounter/n1:effectiveTime/n1:low"/>
                  </xsl:call-template>
                </td>
              </tr>
            </xsl:if>
            <xsl:if test="n1:componentOf/n1:encompassingEncounter/n1:effectiveTime/n1:high">
              <tr>
                <td width="20%">
                  <span class="td_label">
                    <xsl:text>Fin</xsl:text>
                  </span>
                </td>
                <td colspan="3" width="80%">
                  <xsl:call-template name="show-time">
                    <xsl:with-param name="datetime"
                      select="n1:componentOf/n1:encompassingEncounter/n1:effectiveTime/n1:high"/>
                  </xsl:call-template>
                </td>
              </tr>
            </xsl:if>
          </xsl:if> 
          
          <!-- Responsable de la prise en charge --> 
          <xsl:if test="n1:componentOf/n1:encompassingEncounter/n1:responsibleParty">
            <tr>
              <td>
                <span class="td_label">
                  <xsl:text>Responsable de la prise en charge</xsl:text>
                </span>
              </td>
              <td width="80%" colspan="3">
                
                <!-- Identifiant du responsable de la prise en charge --> 
                <xsl:call-template name="show-assignedEntity-name">
                  <xsl:with-param name="asgnEntity"
                    select="n1:componentOf/n1:encompassingEncounter/n1:responsibleParty/n1:assignedEntity"/>
                </xsl:call-template>
                
                <!-- Adresse du responsable de la prise en charge --> 
                <xsl:if test="n1:componentOf/n1:encompassingEncounter/n1:responsibleParty/n1:assignedEntity/n1:addr">
                  <br/><br/>
                  <xsl:call-template name="show-address">
                    <xsl:with-param name="address"
                      select="n1:componentOf/n1:encompassingEncounter/n1:responsibleParty/n1:assignedEntity/n1:addr"/>
                  </xsl:call-template>
                </xsl:if>
                
                <!-- Télécom du responsable de la prise en charge --> 
                <xsl:if test="n1:componentOf/n1:encompassingEncounter/n1:responsibleParty/n1:assignedEntity/n1:telecom">
                  <br/>
                  <xsl:for-each select="n1:componentOf/n1:encompassingEncounter/n1:responsibleParty/n1:assignedEntity/n1:telecom">
                      <xsl:call-template name="show-telecom">
                      <xsl:with-param name="telecom" select="."/>
                    </xsl:call-template>
                  </xsl:for-each>
                </xsl:if>
              </td>
            </tr>
            
            <!-- Organisation du responsable de la prise en charge --> 
            <xsl:if test="n1:componentOf/n1:encompassingEncounter/n1:responsibleParty/n1:assignedEntity/n1:representedOrganization">
              <tr>
                <td width="20%">
                  <span class="td_label">
                    <xsl:text>Organisation</xsl:text>
                  </span>
                </td>
                <td width="80%" colspan="3">
                  <!-- Nom de l'organisation du responsable de la prise en charge --> 
                  <span style="font-weight:bold; ">
                    <xsl:call-template name="show-assignedEntity-orga">
                      <xsl:with-param name="asgnEntity"
                        select="n1:componentOf/n1:encompassingEncounter/n1:responsibleParty/n1:assignedEntity"/>
                    </xsl:call-template>
                  </span>
                  <br/>
                  <!-- Identifiant de l'organisation du responsable de la prise en charge --> 
                  <xsl:call-template name="show-assignedEntity-orga-id">
                    <xsl:with-param name="asgnEntity"
                      select="n1:componentOf/n1:encompassingEncounter/n1:responsibleParty/n1:assignedEntity"/>
                  </xsl:call-template>
                  <!-- Adresse de l'organisation du responsable de la prise en charge --> 
                  <xsl:if test="n1:componentOf/n1:encompassingEncounter/n1:responsibleParty/n1:assignedEntity/n1:representedOrganization/n1:addr">
                    <br/>
                    <xsl:call-template name="show-address">
                      <xsl:with-param name="address"
                        select="n1:componentOf/n1:encompassingEncounter/n1:responsibleParty/n1:assignedEntity/n1:representedOrganization/n1:addr"/>
                    </xsl:call-template>
                  </xsl:if>                  
                  <!-- Télécom organisation du signataire légal -->
                  <xsl:if test="n1:componentOf/n1:encompassingEncounter/n1:responsibleParty/n1:assignedEntity/n1:representedOrganization/n1:telecom">
                    <br/>
                    <xsl:for-each select="n1:componentOf/n1:encompassingEncounter/n1:responsibleParty/n1:assignedEntity/n1:representedOrganization/n1:telecom">
                      <xsl:call-template name="show-telecom">
                        <xsl:with-param name="telecom" select="."/>
                      </xsl:call-template>
                    </xsl:for-each>
                  </xsl:if>       
                  
                  
                </td>
              </tr>
            </xsl:if>
          </xsl:if> 
          <xsl:if
            test="n1:componentOf/n1:encompassingEncounter/n1:location/n1:healthCareFacility">
            <tr>
              <td width="20%">
                <span class="td_label">
                  <xsl:text>Lieu</xsl:text>
                </span>
              </td>
              <td width="80%" colspan="3">
                <xsl:if
                  test="n1:componentOf/n1:encompassingEncounter/n1:location/n1:healthCareFacility/n1:code">
                  <xsl:call-template name="show-code">
                    <xsl:with-param name="code"
                      select="n1:componentOf/n1:encompassingEncounter/n1:location/n1:healthCareFacility/n1:code"
                    />
                  </xsl:call-template>
                </xsl:if>                
                <br/>
                <xsl:if
                  test="n1:componentOf/n1:encompassingEncounter/n1:location/n1:healthCareFacility/n1:location/n1:name">
                  <xsl:call-template name="show-name">
                    <xsl:with-param name="name"
                      select="n1:componentOf/n1:encompassingEncounter/n1:location/n1:healthCareFacility/n1:location/n1:name"
                    />
                  </xsl:call-template>
                </xsl:if> <xsl:if
                  test="n1:componentOf/n1:encompassingEncounter/n1:location/n1:healthCareFacility/n1:location/n1:addr">
                  <br/>
                  <xsl:call-template name="show-address">
                    <xsl:with-param name="address"
                      select="n1:componentOf/n1:encompassingEncounter/n1:location/n1:healthCareFacility/n1:location/n1:addr"
                    />
                  </xsl:call-template>
                </xsl:if>
              </td>
            </tr>
          </xsl:if>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>

  <!-- custodian = Organisation chargée de la conservation du document -->
  <xsl:template name="custodian">
    <xsl:if test="n1:custodian"> Organisation chargée de la conservation du document<table
        class="header_table">
        <tbody>
          <tr>
            <td width="20%">
              <span class="td_label">
                <xsl:text>Organisation</xsl:text>
              </span>
            </td>
            <td width="80%">
              <!-- Nom de l'organisation -->
              <xsl:if
                test="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:name">
                <xsl:call-template name="show-name">
                  <xsl:with-param name="name"
                    select="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:name"/>
                </xsl:call-template>
              </xsl:if>
              <!-- Identifiant de l'organisation -->
              <xsl:if
                test="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:id">
                <br/>
                <xsl:call-template name="show-id">
                  <xsl:with-param name="id"
                    select="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:id"/>
                </xsl:call-template>
              </xsl:if>
              <!-- Adresse de l'organisation -->
              <xsl:if
                test="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:addr">
                <br/><br/>
                <xsl:call-template name="show-address">
                  <xsl:with-param name="address"
                    select="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:addr"/>
                </xsl:call-template>
              </xsl:if>
              <!-- Télécom de l'organisation -->            
              <xsl:if test="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:telecom">
                <br/><br/>
                <xsl:for-each select="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:telecom">
                  <xsl:call-template name="show-telecom">
                    <xsl:with-param name="telecom" select="."/>
                  </xsl:call-template>
                </xsl:for-each>
              </xsl:if>
            </td>
          </tr>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>

  <!-- documentationOf -->
  <xsl:template name="documentationOf">
    <xsl:if test="n1:documentationOf"> Acte(s) <table class="header_table">
        <tbody>
          <xsl:for-each select="n1:documentationOf">
            <!-- code de l'acte -->
            <tr>
              <td width="20%">
                <span class="td_label">
                  <text>Acte</text>
                </span>
              </td>
              <td width="80%" colspan="3">
                <xsl:if test="n1:serviceEvent/n1:code">
                  <xsl:call-template name="show-code">
                    <xsl:with-param name="code" select="n1:serviceEvent/n1:code"/>
                  </xsl:call-template>
                </xsl:if>
              </td>
            </tr>
            <!-- date de l'acte -->
            <xsl:if test="n1:serviceEvent/n1:effectiveTime">
              <xsl:if test="n1:serviceEvent/n1:effectiveTime/@value">
                <tr>
                  <td width="20%">
                    <span class="td_label">
                      <xsl:text>Date</xsl:text>
                    </span>
                  </td>
                  <td colspan="3" width="80%">
                    <xsl:call-template name="show-time">
                      <xsl:with-param name="datetime" select="n1:serviceEvent/n1:effectiveTime"/>
                    </xsl:call-template>
                  </td>
                </tr>
              </xsl:if>
              <xsl:if test="n1:serviceEvent/n1:effectiveTime/n1:low">
                <tr>
                  <td width="20%">
                    <span class="td_label">
                      <xsl:text>Début</xsl:text>
                    </span>
                  </td>
                  <td colspan="3" width="80%">
                    <xsl:call-template name="show-time">
                      <xsl:with-param name="datetime"
                        select="n1:serviceEvent/n1:effectiveTime/n1:low"/>
                    </xsl:call-template>
                  </td>
                </tr>
              </xsl:if>
              <xsl:if test="n1:serviceEvent/n1:effectiveTime/n1:high">
                <tr>
                  <td width="20%">
                    <span class="td_label">
                      <xsl:text>Fin</xsl:text>
                    </span>
                  </td>
                  <td colspan="3" width="80%">
                    <xsl:call-template name="show-time">
                      <xsl:with-param name="datetime"
                        select="n1:serviceEvent/n1:effectiveTime/n1:high"/>
                    </xsl:call-template>
                  </td>
                </tr>
              </xsl:if>
            </xsl:if>
            <!-- erreur APE			 exécutant 	
            <xsl:if select="n1:serviceEvent/n1:performer/n1:assignedEntity">		
				<tr>
					<td width="20%">
						<span class="td_label">
							  <text>Exécutant</text>
						</span>
					</td>
					<td width="80%" colspan="3">
						  <xsl:call-template name="show-assignedEntity-name">
							<xsl:with-param name="asgnEntity" select="n1:assignedEntity"/>
						  </xsl:call-template>
						  <xsl:if test="n1:assignedEntity/n1:addr">
							<br/>
							<xsl:call-template name="show-address">
							  <xsl:with-param name="address" select="n1:assignedEntity/n1:addr"/>
							</xsl:call-template>
						  </xsl:if>
						  <xsl:if test="n1:assignedEntity/n1:telecom">
							<br/>
							<xsl:for-each select="n1:assignedEntity/n1:telecom">
								<xsl:call-template name="show-telecom">
								  <xsl:with-param name="telecom" select="."/>
								</xsl:call-template>
							</xsl:for-each>
						  </xsl:if>
					</td>
				</tr>
				<tr>
					<td width="20%">
						<span class="td_label">
						  <xsl:text>Organisation</xsl:text>
						</span>
					</td>
					<td width="80%" colspan="3">
						<xsl:if test="n1:assignedEntity/n1:representedOrganization">
							<span style="font-weight:bold; ">
								<xsl:call-template name="show-assignedEntity-orga">
									<xsl:with-param name="asgnEntity" select="n1:assignedEntity"/>
								</xsl:call-template>
							</span>
							<br/>
							<xsl:call-template name="show-assignedEntity-orga-id">
								<xsl:with-param name="asgnEntity" select="n1:assignedEntity"/>
							</xsl:call-template>
							<xsl:if test="n1:assignedEntity/n1:representedOrganization/n1:addr">
								<br/>
								<xsl:call-template name="show-address">
									<xsl:with-param name="address" select="n1:performer/n1:assignedEntity/n1:representedOrganization/n1:addr"/>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="n1:assignedEntity/n1:representedOrganization/n1:telecom">
								<br/>
								<xsl:for-each select="n1:assignedEntity/n1:representedOrganization/n1:telecom">
									<xsl:call-template name="show-telecom">
										<xsl:with-param name="telecom" select="n1:assignedEntity/n1:representedOrganization/n1:telecom"/>
									</xsl:call-template>
								</xsl:for-each>
							</xsl:if>
						</xsl:if>
					</td>
				</tr>		 
			</xsl:if>
			-->
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>

  <!-- inFulfillmentOf -->
  <xsl:template name="inFulfillmentOf">
    <xsl:if test="n1:inFulfillmentOf"> Prescription <table class="header_table">
        <tbody>
          <xsl:for-each select="n1:inFulfillmentOf">
            <tr>
              <td width="20%">
                <span class="td_label">
                  <xsl:text>Référence</xsl:text>
                </span>
              </td>
              <td width="80%">
                <xsl:for-each select="n1:order">
                  <xsl:for-each select="n1:id">
                    <xsl:call-template name="show-id"/>
                  </xsl:for-each>
                </xsl:for-each>
              </td>
            </tr>           
            <tr>
              <td width="20%">
                <xsl:for-each select="n1:order">
                  <xsl:for-each select="n1:code">
                    <xsl:text>Commentaire</xsl:text>
                  </xsl:for-each>
                  <xsl:for-each select="n1:priorityCode">
                    <xsl:text>Priorité</xsl:text>
                  </xsl:for-each>
                </xsl:for-each>
              </td>
              <td width="80%">
                <xsl:for-each select="n1:order">
                  <xsl:for-each select="n1:code">
                    <xsl:call-template name="show-code">
                      <xsl:with-param name="code" select="."/>
                    </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="n1:priorityCode">
                    <br/>
                    <xsl:call-template name="show-code">
                      <xsl:with-param name="code" select="."/>
                    </xsl:call-template>
                  </xsl:for-each>
                </xsl:for-each>
              </td>
            </tr>
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>

  <!-- informant -->
  <xsl:template name="informant">
    <xsl:if test="n1:informant"> Informateur(s) <table class="header_table">
        <tbody>
          <xsl:for-each select="n1:informant">
            <xsl:if test="n1:assignedEntity">
              <tr>
                <td width="20%">
                  <span class="td_label">
                    <xsl:text>PS Informateur</xsl:text>
                  </span>
                </td>
                <td width="80%">
                  <xsl:call-template name="show-assignedEntity-name">
                    <xsl:with-param name="asgnEntity" select="n1:assignedEntity"/>
                  </xsl:call-template>
                </td>
              </tr>
              <xsl:if test="n1:assignedEntity/n1:representedOrganization">
                <tr>
                  <td width="20%">
                    <span class="td_label">
                      <xsl:text>Organisation</xsl:text>
                    </span>
                  </td>
                  <td width="80%" colspan="3">
                    <span style="font-weight:bold;">
                      <xsl:call-template name="show-assignedEntity-orga">
                        <xsl:with-param name="asgnEntity" select="n1:assignedEntity"/>
                      </xsl:call-template>
                    </span>
                    <br/>
                    <xsl:call-template name="show-assignedEntity-orga-id">
                      <xsl:with-param name="asgnEntity" select="n1:assignedEntity"/>
                    </xsl:call-template>
                    <xsl:if test="n1:assignedEntity/n1:representedOrganization/n1:addr">
                      <br/>
                      <xsl:call-template name="show-address">
                        <xsl:with-param name="address"
                          select="n1:assignedEntity/n1:representedOrganization/n1:addr"/>
                      </xsl:call-template>
                      <xsl:if test="n1:assignedEntity/n1:representedOrganization/n1:telecom">
                        <br/><br/>
                        <xsl:for-each
                          select="n1:assignedEntity/n1:representedOrganization/n1:telecom">
                          <xsl:call-template name="show-telecom">
                            <xsl:with-param name="telecom"
                              select="n1:assignedEntity/n1:representedOrganization/n1:telecom"/>
                          </xsl:call-template>
                        </xsl:for-each>
                      </xsl:if>
                    </xsl:if>
                  </td>
                </tr>
              </xsl:if>
            </xsl:if>
            <xsl:if test="n1:relatedEntity">
              <tr>
                <td width="20%">
                  <span class="td_label">
                    <xsl:call-template name="show-relatedEntityClass">
                      <xsl:with-param name="clsCode" select="n1:relatedEntity/@classCode"/>
                    </xsl:call-template>
                  </span>
                </td>
                <td width="80%">
                  <xsl:call-template name="show-relatedEntity">
                    <xsl:with-param name="relatedEntity" select="n1:relatedEntity"/>
                  </xsl:call-template>
                  <xsl:if test="n1:relatedEntity/n1:addr">
                    <br/>
                    <xsl:call-template name="show-address">
                      <xsl:with-param name="address" select="n1:relatedEntity/n1:addr"/>
                    </xsl:call-template>
                  </xsl:if>
                  <xsl:if test="n1:relatedEntity/n1:telecom">
                    <br/><br/>
                    <xsl:for-each select="n1:relatedEntity/n1:telecom">
                      <xsl:call-template name="show-telecom">
                        <xsl:with-param name="telecom" select="."/>
                      </xsl:call-template>
                    </xsl:for-each>
                  </xsl:if>
                </td>
              </tr>
            </xsl:if>
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>

  <!-- informationRecipient -->
  <xsl:template name="informationRecipient">
    <xsl:if test="n1:informationRecipient"> Destinataire(s) <table class="header_table">
        <tbody>
          <xsl:for-each select="n1:informationRecipient">
            <tr>
              <td width="20%">
                <span class="td_label">
                  <xsl:text>Destinataire</xsl:text>
                </span>
              </td>
              <td width="80%">
                <xsl:if test="n1:intendedRecipient/n1:informationRecipient/n1:name">
                  <xsl:call-template name="show-name">
                    <xsl:with-param name="name"
                      select="n1:intendedRecipient/n1:informationRecipient/n1:name"/>
                  </xsl:call-template>
                  <br/>
                </xsl:if>
                <xsl:call-template name="show-id">
                  <xsl:with-param name="id" select="n1:intendedRecipient/n1:id"/>
                </xsl:call-template>
                <xsl:if test="n1:intendedRecipient/n1:addr">
                  <br/><br/>
                  <xsl:for-each select="n1:intendedRecipient/n1:addr">
                    <xsl:call-template name="show-address">
                      <xsl:with-param name="address" select="."/>
                    </xsl:call-template>
                  </xsl:for-each>
                </xsl:if>
                <xsl:if test="n1:intendedRecipient/n1:telecom">
                  <br/><br/>
                  <xsl:for-each select="n1:intendedRecipient/n1:telecom">
                    <xsl:call-template name="show-telecom">
                      <xsl:with-param name="telecom" select="."/>
                    </xsl:call-template>
                  </xsl:for-each>
                </xsl:if>
              </td>
            </tr>
            <xsl:if test="n1:intendedRecipient/n1:receivedOrganization">
              <tr>
                <td width="20%">
                  <span class="td_label">
                    <xsl:text>Organisation</xsl:text>
                  </span>
                </td>
                <td width="80%">
                  <xsl:if test="n1:intendedRecipient/n1:receivedOrganization/n1:name">
                    <xsl:call-template name="show-name">
                      <xsl:with-param name="name"
                        select="n1:intendedRecipient/n1:receivedOrganization/n1:name"/>
                    </xsl:call-template>
                  </xsl:if>
                  <xsl:if test="n1:intendedRecipient/n1:receivedOrganization/n1:id">
                    <xsl:for-each select="n1:intendedRecipient/n1:receivedOrganization/n1:id">
                      <br/>
                      <xsl:call-template name="show-id">
                        <xsl:with-param name="id"
                          select="n1:intendedRecipient/n1:receivedOrganization/n1:id"/>
                      </xsl:call-template>
                    </xsl:for-each>
                  </xsl:if>
                  <xsl:if test="n1:intendedRecipient/n1:receivedOrganization/n1:addr">
                    <br/><br/>
                    <xsl:call-template name="show-address">
                      <xsl:with-param name="address"
                        select="n1:intendedRecipient/n1:receivedOrganization/n1:addr"/>
                    </xsl:call-template>
                  </xsl:if>
                  <xsl:if test="n1:intendedRecipient/n1:receivedOrganization/n1:telecom">
                    <br/><br/>
                    <xsl:for-each select="n1:intendedRecipient/n1:receivedOrganization/n1:telecom">
                      <xsl:call-template name="show-telecom">
                        <xsl:with-param name="telecom" select="."/>
                      </xsl:call-template>
                    </xsl:for-each>
                  </xsl:if>
                </td>
              </tr>
            </xsl:if> </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>

  <!-- Participant -->
  <xsl:template name="participant">
    <xsl:if test="n1:participant"> Participant(s) <table class="header_table">
        <tbody>
          <xsl:for-each select="n1:participant">
            <tr>
              <td width="20%">
                <xsl:variable name="participtRole">
                  <xsl:call-template name="translateRoleAssoCode">
                    <xsl:with-param name="code" select="n1:associatedEntity/@classCode"/>
                  </xsl:call-template>
                </xsl:variable>
                <xsl:choose>
                  <xsl:when test="$participtRole">
                    <span class="td_label">
                      <xsl:choose>                        
                        <xsl:when test="@typeCode = 'RESP'">
                          <xsl:if test="n1:functionCode">
                            <xsl:choose>
                              <xsl:when test="n1:functionCode/@code = '353'">
                                <xsl:text>Responsable de l'équipe de soins</xsl:text>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>Responsable de l'acte</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:if>
                        </xsl:when>              
                        <xsl:when test="@typeCode = 'REF'">
                          <xsl:text>Prescripteur</xsl:text>
                        </xsl:when>
                        <xsl:when test="@typeCode = 'REFB'">
                          <xsl:text>Praticien adresseur</xsl:text>
                        </xsl:when>
                        <xsl:when test="@typeCode = 'INF'">
                          <xsl:if test="n1:functionCode">
                            <xsl:choose>
                              <xsl:when test="n1:functionCode/@code = 'PCP'">
                                <xsl:text>Médecin traitant</xsl:text>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>Informateur</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:if>
                        </xsl:when>
                        <xsl:when test="@typeCode = 'PRF'">
                          <xsl:if test="n1:functionCode">
                            <xsl:choose>
                              <xsl:when test="n1:functionCode/@code = '353'">
                                <xsl:text>Membre de l'équipe de soins</xsl:text>
                              </xsl:when>
                              <xsl:when test="n1:functionCode/@code = 'CORRE'">
                                <xsl:text>Correspondant</xsl:text>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>Exécutant</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:if>
                        </xsl:when>                     
                        <xsl:when test="@typeCode = 'CON'">
                          <xsl:if test="n1:functionCode">
                            <xsl:choose>
                              <xsl:when test="n1:functionCode/@code = 'CORRE'">
                                <xsl:text>Correspondant</xsl:text>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>Consultant</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:if>
                        </xsl:when>                        
                        <xsl:when test="@typeCode = 'VRF'">
                          <xsl:text>Vérificateur</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:text>Participant</xsl:text>
                        </xsl:otherwise>
                      </xsl:choose>
                    </span>
                  </xsl:when>
                  <xsl:otherwise>
                    <span class="td_label">
                      <xsl:text>Participant</xsl:text>
                    </span>
                  </xsl:otherwise>
                </xsl:choose>
              </td> 
              <td width="80%">
                <!-- DEBUT Modification pour afficher le nom de la personne ET le nom de sa structure (31/12/2019)
                <xsl:call-template name="show-associatedEntity">
                  <xsl:with-param name="assoEntity" select="n1:associatedEntity"/>
                </xsl:call-template>
                -->
                <xsl:if test="n1:associatedEntity/n1:associatedPerson">
                  <tr>
                    <xsl:call-template name="show-name">
                      <xsl:with-param name="name" select="n1:associatedEntity/n1:associatedPerson/n1:name"/>
                    </xsl:call-template>
                  </tr>
                  <!-- DEBUT Ajout profession participant 03/12/2019 -->      
                  <xsl:if test="n1:associatedEntity/n1:code">
                    <tr>
                      <xsl:call-template name="show-code">
                        <xsl:with-param name="code" select="n1:associatedEntity/n1:code"/>
                      </xsl:call-template>                    
                    </tr>
                  </xsl:if> 
                  <br/>               
                  <!-- FIN Ajout profession participant 03/12/2019 -->                  
                </xsl:if>  
                
                <xsl:if test="n1:associatedEntity/n1:scopingOrganization">
                  <tr>
                    <xsl:call-template name="show-name">
                      <xsl:with-param name="name" select="n1:associatedEntity/n1:scopingOrganization/n1:name"/>
                    </xsl:call-template>                                 
                  </tr>
                  <!-- Identifiant de l'organisation -->
                  <xsl:if test="n1:associatedEntity/n1:scopingOrganization/n1:id">
                    
                    <xsl:for-each select="n1:associatedEntity/n1:scopingOrganization/n1:id">
                      <xsl:call-template name="show-id">
                        <xsl:with-param name="id" select="n1:associatedEntity/n1:scopingOrganization/n1:id"/>
                      </xsl:call-template>
                    </xsl:for-each>
                  </xsl:if>
                  <br/>
                </xsl:if>  
                <!-- FIN Modification pour afficher le nom de la personne ET le nom de sa structure (31/12/2019) -->
                
                <xsl:if test="n1:associatedEntity/n1:addr">
                  <xsl:call-template name="show-address">
                    <xsl:with-param name="address" select="n1:associatedEntity/n1:addr"/>
                  </xsl:call-template>
                  <br/>
                </xsl:if>
                
                <xsl:if test="n1:associatedEntity/n1:telecom">                  
                  <xsl:for-each select="n1:associatedEntity/n1:telecom">
                    <xsl:call-template name="show-telecom">
                      <xsl:with-param name="telecom" select="."/>
                    </xsl:call-template>
                  </xsl:for-each>
                </xsl:if>
              </td>
            </tr> 
            
            <xsl:if test="n1:time">
              <xsl:if test="n1:time/n1:low">
                <tr>
                  <td>
                    <xsl:text>Début</xsl:text>
                  </td>
                  <td>
                    <xsl:call-template name="show-time">
                      <xsl:with-param name="datetime" select="n1:time/n1:low"/>
                    </xsl:call-template>
                  </td>
                </tr>
              </xsl:if>
              <xsl:if test="n1:time/n1:high">
                <tr>
                  <td>
                    <xsl:text>Fin</xsl:text>
                  </td>
                  <td>
                    <xsl:call-template name="show-time">
                      <xsl:with-param name="datetime" select="n1:time/n1:high"/>
                    </xsl:call-template>
                  </td>
                </tr>
              </xsl:if>
            </xsl:if>
            
            <!-- DEBUT Ajout commentaire participant 24/05/2019 -->      
            <xsl:if test="n1:functionCode/n1:originalText">
                <tr>
                  <td>
                    <xsl:text>Commentaire</xsl:text>
                  </td>
                  <td>
                    <xsl:call-template name="show-participantOriginalText">
                      <xsl:with-param name="participantOriginalText" select="n1:functionCode/n1:originalText"/>
                    </xsl:call-template>
                  </td>
                </tr>
            </xsl:if>
            <!-- FIN Ajout commentaire participant 24/05/2019 -->
            <br/>
            
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>

  <!-- recordTarget -->
  <xsl:template name="recordTarget"> Patient <table class="header_table">
      <tbody>
        <xsl:for-each select="n1:recordTarget/n1:patientRole">
          <xsl:if test="not(n1:id/@nullFlavor)">
            <xsl:call-template name="show-patient-name">
              <xsl:with-param name="name" select="n1:patient/n1:name"/>
            </xsl:call-template>
            <tr>
              <td width="20%">
                <span class="td_label">
                  <xsl:text>Date de naissance</xsl:text>
                </span>
              </td>
              <td width="30%">
                <xsl:call-template name="show-time">
                  <xsl:with-param name="datetime" select="n1:patient/n1:birthTime"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr><td width="15%">
                <span class="td_label">
                  <xsl:text>Sexe</xsl:text>
                </span>
              </td>
              <td>
                <xsl:for-each select="n1:patient/n1:administrativeGenderCode">
                  <xsl:call-template name="show-gender"/>
                </xsl:for-each>
              </td></tr>
            <xsl:if test="n1:patient/n1:birthplace/n1:place">
              <tr>
                <td width="20%">
                  <span class="td_label">
                    <xsl:text>Lieu de naissance</xsl:text>
                  </span>
                </td>
                <td colspan="3">
                  <xsl:if test="n1:patient/n1:birthplace/n1:place/n1:name">
                    <xsl:call-template name="show-name">
                      <xsl:with-param name="name" select="n1:patient/n1:birthplace/n1:place/n1:name"
                      />
                    </xsl:call-template>
                    <br/>
                  </xsl:if>
                  <xsl:if test="n1:patient/n1:birthplace/n1:place/n1:addr">
                    <xsl:call-template name="show-address">
                      <xsl:with-param name="address"
                        select="n1:patient/n1:birthplace/n1:place//n1:addr"/>
                    </xsl:call-template>
                  </xsl:if>
                </td>
              </tr>
            </xsl:if>
            <tr>
              <td>
                <span class="td_label">
                  <xsl:text>Adresse</xsl:text>
                </span>
              </td>
              <td>
                <xsl:call-template name="show-address">
                  <xsl:with-param name="address" select="n1:addr"/>
                </xsl:call-template>
              </td>
            </tr>
            <xsl:for-each select="n1:telecom">
              <tr>
                <td>
                  <span class="td_label">
                    <xsl:text>Telécom</xsl:text>
                  </span>
                </td>
                <td>
                  <xsl:call-template name="show-telecom">
                    <xsl:with-param name="telecom" select="."/>
                  </xsl:call-template>
                </td>
              </tr>
            </xsl:for-each>
            <tr>
              <td>
                <span class="td_label">
                  <xsl:text>Identifiant(s)</xsl:text>
                </span>
              </td>
              <td>
                <xsl:for-each select="n1:id">
                  <xsl:choose>
                    <xsl:when test="@root = '1.2.250.1.213.1.4.2'">
                      <xsl:text>INS-C : </xsl:text>
                    </xsl:when>
                    <xsl:when test="@root = '1.2.250.1.213.1.4.6'">
                      <xsl:text>INS-C (de test) : </xsl:text>
                    </xsl:when>
                    <xsl:when test="@root = '1.2.250.1.213.1.4.7'">
                      <xsl:text>INS-C (de démo) : </xsl:text>
                    </xsl:when>
                    <xsl:when test="@root = '1.2.250.1.213.1.4.8'">
                      <xsl:text>INS-NIR : </xsl:text>
                    </xsl:when>                    
                    <xsl:when test="@root = '1.2.250.1.213.1.4.9'">
                      <xsl:text>INS-NIA : </xsl:text>
                    </xsl:when>                    
                    <xsl:when test="@root = '1.2.250.1.213.1.4.10'">
                      <xsl:text>INS-NIR (de test) : </xsl:text>
                    </xsl:when>
                    <xsl:when test="@root = '1.2.250.1.213.1.4.11'">
                      <xsl:text>INS-NIR (de démo) : </xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:text>Autre : </xsl:text>
                    </xsl:otherwise>
                  </xsl:choose>
                  <xsl:call-template name="show-id"/><br/>
                  <br/>
                </xsl:for-each>
              </td>
            </tr>
            <tr>
              <td>
                <span class="td_label">
                  <xsl:text>Représentant du patient</xsl:text>
                </span>
              </td>
              <!--<td>
                  <xsl:call-template name="show-name">
                    <xsl:with-param name="name" select="n1:patient/n1:guardian/n1:guardianPerson/n1:name"/>
                  </xsl:call-template>
                  <br/>
                
              </td>-->
              <td width="80%">
                <xsl:if test="n1:patient/n1:guardian/n1:guardianPerson/n1:name"> <xsl:call-template name="show-name">
                  <xsl:with-param name="name" select="n1:patient/n1:guardian/n1:guardianPerson/n1:name"/>
                </xsl:call-template>
                </xsl:if>
                <xsl:if test="n1:patient/n1:guardian/n1:addr"> <xsl:call-template name="show-address">
                  <xsl:with-param name="address" select="n1:patient/n1:guardian/n1:addr"/>
                </xsl:call-template>
                </xsl:if>
                <xsl:if test="n1:patient/n1:guardian/n1:telecom">
                  <br/>
                  <xsl:for-each select="n1:patient/n1:guardian/n1:telecom">
                    <xsl:call-template name="show-telecom">
                      <xsl:with-param name="telecom" select="."/>
                    </xsl:call-template>
                  </xsl:for-each>
                </xsl:if>
              </td>
            </tr>
          </xsl:if>
        </xsl:for-each>
      </tbody>
    </table>
  </xsl:template>

  <!-- authorization (consent) -->
  <xsl:template name="authorization">
    <xsl:if test="n1:authorization"> Autorisation <table class="header_table">
        <tbody>
          <xsl:for-each select="n1:authorization">
            <tr>
              <td width="20%">
                <span class="td_label">
                  <xsl:text>Autorisation</xsl:text>
                </span>
              </td>
              <td width="80%">
                <xsl:if test="n1:consent/n1:code">
                  <xsl:call-template name="show-code">
                    <xsl:with-param name="code" select="n1:consent/n1:code"/>
                  </xsl:call-template>
                  <br/>
                </xsl:if>
                <xsl:call-template name="show-code">
                  <xsl:with-param name="code" select="n1:consent/n1:statusCode"/>
                </xsl:call-template>
              </td>
            </tr>
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>

  <!-- setAndVersion -->
  <xsl:template name="setAndVersion">
    <xsl:if test="n1:setId and n1:versionNumber">
      <table class="header_table">
        <tbody>
          <tr>
            <td width="20%">
              <xsl:text>Lot de versions</xsl:text>
            </td>
            <td colspan="3">
              <xsl:text>Identifiant </xsl:text>
              <xsl:call-template name="show-id">
                <xsl:with-param name="id" select="n1:setId"/>
              </xsl:call-template>
              <xsl:text>Numéro de version </xsl:text>
              <xsl:value-of select="n1:versionNumber/@value"/>
            </td>
          </tr>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
