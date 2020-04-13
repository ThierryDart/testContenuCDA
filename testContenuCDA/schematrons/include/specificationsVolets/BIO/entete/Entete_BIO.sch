<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    Entete_BIO.sch
    Teste la conformité de l'entete du CR-BIO au CI-SIS
    
    Historique :
    01/02/2018 :  NMA : Création
    09/07/2018 : NMA : Suppression du test de présence du numéro d’accréditation du laboratoire responsable
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="Entete_BIO">
    
    <rule context='cda:ClinicalDocument'>
         
        <assert test="cda:setId">
            [Entete_BIO] L'élément setId est obligatoirement présent
        </assert>
        
        <assert test="cda:setId[@root]">
            [Entete_BIO] L'attribut root est obligatoire dans la balise setId
        </assert>
    </rule>
    
    <rule context='cda:ClinicalDocument/cda:authenticator'>
        <assert test="cda:templateId">
            [Entete_BIO] Le templateId de l'authenticator est obligatoirement présent
        </assert>
        
        <assert test="cda:assignedEntity/cda:addr">
            [Entete_BIO] L'adresse du biologiste médical valideur est obligatoirement présente
        </assert>
        
        <assert test="cda:assignedEntity/cda:telecom">
            [Entete_BIO] Les coordonnées telecom du biologiste médical valideur sont obligatoirement présents
        </assert>
        
        <assert test="cda:representedOrganisation/cda:id or not (cda:representedOrganisation)">
            [Entete_BIO] L'identifiant du laboratoire est obligatoirement présent
        </assert>
        
        <assert test="cda:representedOrganisation/cda:name or not (cda:representedOrganisation)">
            [Entete_BIO] Le nom du laboratoire est obligatoirement présent
        </assert>
        
        <assert test="cda:representedOrganisation/cda:telecom or not (cda:representedOrganisation)">
            [Entete_BIO] Les coordonnées telecom du laboratoire sont obligatoirement présents
        </assert>
        
        <assert test="cda:representedOrganisation/cda:addr or not (cda:representedOrganisation)">
            [Entete_BIO] L'adresse du laboratoire est obligatoirement présente
        </assert>
    </rule>
    
    <rule context='cda:ClinicalDocument/cda:participant'>
        
        <assert test="cda:associatedEntity/cda:addr">
            [Entete_BIO] L'adresse du participant est obligatoirement présente
        </assert>
        
        <assert test="cda:associatedEntity/cda:telecom">
            [Entete_BIO] Le telecom du participant est obligatoirement présent
        </assert>
        
        <assert test="cda:associatedEntity/cda:assignedPerson/cda:representedOrganisation/cda:id or not(cda:associatedEntity/cda:assignedPerson/cda:representedOrganisation)">
            [Entete_BIO] L'identifiant de l'établissement participant est obligatoirement présent
        </assert>
        
        <assert test="cda:associatedEntity/cda:assignedPerson/cda:representedOrganisation/cda:name or not(cda:associatedEntity/cda:assignedPerson/cda:representedOrganisation)">
            [Entete_BIO] Le nom de l'établissement participant est obligatoirement présent
        </assert>
        
        <assert test="cda:associatedEntity/cda:assignedPerson/cda:representedOrganisation/cda:telecom or not(cda:associatedEntity/cda:assignedPerson/cda:representedOrganisation)">
            [Entete_BIO] Le telecom de l'établissement participant est obligatoirement présent
        </assert>
        
        <assert test="cda:associatedEntity/cda:assignedPerson/cda:representedOrganisation/cda:addr or not(cda:associatedEntity/cda:assignedPerson/cda:representedOrganisation)">
            [Entete_BIO] L'adresse de l'établissement participant est obligatoirement présente
        </assert>
    </rule>
    
    <rule context='cda:ClinicalDocument/cda:documentationOf/cda:serviceEvent'>
        <assert test="cda:code">
            [Entete_BIO] Le code de l'acte principal documenté est obligatoirement présent
        </assert>
    </rule>
    
    <rule context='cda:ClinicalDocument/cda:documentationOf/cda:serviceEvent/cda:performer'>
        <assert test="cda:time">
            [Entete_BIO] La date d'exécution de l'acte principal documenté est obligatoirement présente
        </assert>
        <assert test="cda:assignedEntity/cda:representedOrganization/cda:id">
            [Entete_BIO] L'identifiant du laboratoire est obligatoirement présent
        </assert>
        <assert test="cda:assignedEntity/cda:representedOrganization/cda:name">
            [Entete_BIO] Le nom du laboratoire est obligatoirement présent
        </assert>
        <assert test="cda:assignedEntity/cda:representedOrganization/cda:telecom">
            [Entete_BIO] Les coordonnées telecom du laboratoire sont obligatoirement présentes
        </assert>
        <assert test="cda:assignedEntity/cda:representedOrganization/cda:addr">
            [Entete_BIO] L'adresse du laboratoire est obligatoirement présente
        </assert>
        <assert test="cda:assignedEntity/cda:representedOrganization/cda:standardIndustryClassCode">
            [Entete_BIO] Le cadre d'exercice du laboratoire est obligatoirement présent
        </assert>
        
    </rule>

    <rule context='cda:ClinicalDocument/cda:componentOf/cda:encompassingEncounter'>
        <assert test="cda:responsibleParty/cda:assignedEntity/cda:id">
            [Entete_BIO] L'identifiant du biologiste responsable doit être présent (responsibleParty/assignedEntity/id)
        </assert>
        <assert test="cda:responsibleParty/cda:assignedEntity/cda:code">
            [Entete_BIO] La profession/spécialité du biologiste responsable doit être présente (responsibleParty/assignedEntity/code)
        </assert>
        <assert test="cda:responsibleParty/cda:assignedEntity/cda:assignedPerson/cda:name/cda:family">
            [Entete_BIO] L'identité du biologiste responsable doit être présente (responsibleParty/assignedEntity/assignedPerson/name/family)
        </assert>
<!--        <assert test="cda:responsibleParty/cda:assignedEntity/cda:representedOrganization/cda:id[@root='1.2.250.1.213.6.3.1']">
            [Entete_BIO] Le Numéro d’accréditation du laboratoire responsable doit être présent (responsibleParty/assignedEntity/representedOrganization/id[root ="1.2.250.1.213.6.3.1"])
        </assert>-->
    </rule>
    
</pattern>