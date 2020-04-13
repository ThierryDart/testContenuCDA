<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    Entete_CRGM.sch
    Teste la conformité de l'entete du volet CR-GM au CI-SIS
    
    Historique :
    08/01/2019 :  NNA : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="Entete_CRGM">

    <rule context='cda:ClinicalDocument'>
        <assert test="cda:code[@code='51969-4']">
            [Entete_CRGM] Le code du document CRGM doit être égal à '51969-4'
        </assert>
    </rule>      
    
    <rule context='cda:ClinicalDocument/cda:author'>
        <assert test="count(cda:author)&lt;4">
            [Entete_CRGM] Il doit y avoir au maximum 3 Auteurs pour le document CR-GM.
        </assert>
        <assert test="cda:assignedAuthor/cda:id">
            [Entete_CRGM] L'identifiant de l'auteur du document CR-GM est obligatoirement présente.
        </assert>
        <assert test="cda:assignedAuthor/cda:code">
            [Entete_CRGM] La Profession/spécialité de l’auteur est obligatoirement présente.         
        </assert>
        <assert test="cda:assignedAuthor/cda:assignedPerson">
            [Entete_CRGM] Identité de l’auteur (Nom, prénom, prefix, etc..)  est obligatoirement présente.         
        </assert>
    </rule>
           
    <rule context='cda:ClinicalDocument/cda:custodian'>
        <assert test="cda:assignedCustodian/cda:representedCustodianOrganization/cda:name">
            [Entete_CRGM] La Valeur du nom du Laboratoire est obligatoirement présent.         
        </assert>
    </rule>
    
    <rule context='cda:ClinicalDocument/cda:informationRecipient'>
        <assert test="count(cda:informationRecipient)&lt;3">
            [Entete_CRGM] Il doit y avoir au maximum 2 destinataires en copie du document CR-GM.
        </assert>
    </rule>        
    
    <rule context='cda:ClinicalDocument/cda:legalAuthenticator'>
        <assert test="cda:assignedEntity/cda:representedOrganization/cda:addr">
            [Entete_CRGM] L'adresse de l'organisation du responsable du document CRGM est obligatoirement présente.         
        </assert>
    </rule>  
    
    <rule context='cda:ClinicalDocument/cda:participant'>
        <assert test="count(../cda:participant)=2">
            [Entete_CRGM] Il doit y avoir 2 participants impliqués les actes décrits par le document CR-GM (Le Médecin prescripteur et le Préleveur).
        </assert>
        <assert test="../cda:participant[@typeCode='REF'] or ../cda:participant[@typeCode='PRF']">
            [Entete_CRGM] L'attribut typeCode de l'élément participant prend la valeur typeCode='REF' s'il s'agit du Médecin prescripteur et typeCode='PRF' s'il s'agit d'un Préleveur.
        </assert>
        <!--<assert test="cda:associatedEntity/cda:code">
            [Entete_CRGM] La Profession/ Spécialité du PS participant est obligatoirement présente.
        </assert>-->
        <assert test="cda:associatedEntity/cda:associatedPerson">
            [Entete_CRGM] Les informations d’identité du PS participant sont obligatoirement présentes.
        </assert>
    </rule>
        
    <rule context="cda:ClinicalDocument/cda:documentationOf">
        <assert test="cda:serviceEvent/cda:code and (cda:serviceEvent/cda:code[@code='51956-1'])">
            [Entete_CRGM] Le code de l'acte documenté est obligatoire et doit être égal à '51956-1'.            
        </assert>
    </rule>
  
    <rule context="cda:ClinicalDocument/cda:componentOf">
        <assert test="cda:encompassingEncounter/cda:code[@code='AMB']">
            [Entete_CRGM] Le type de prise en charge doit avoir comme code 'AMB'.            
        </assert>
    </rule>
    
    
    
    
    
    
    
</pattern>