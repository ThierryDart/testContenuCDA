<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ ER_comments_int.sch ]O@%#o>>=-
    
    Teste les entrées de la section PCC comments (1.3.6.1.4.1.19376.1.5.3.1.4.2)
    
    25/07/11 : CRI : Création
    30/10/17 : NMA : Ajout du test de présence de l'élément text
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="ER_comments_int">
    
        <title>IHE PCC v3.0 Comments - errors validation phase</title>
        <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.2"]'>
            
            <assert test='cda:templateId[@root="2.16.840.1.113883.10.20.1.40"]'>
                [ER_comments_int] Erreur de Conformité PCC: Le templateId CCD (2.16.840.1.113883.10.20.1.40) de l'entrée
                Comments doit être déclaré.</assert>
            
            <assert test='cda:code[@code="48767-8" and
                @codeSystem="2.16.840.1.113883.6.1"]'>
                [ER_comments_int] Erreur de Conformité PCC: L'élément "code" pour l'entrée "Comments" est requis. Ses attributs "code" et "codeSystem"
                sont obligatoires (cf. CI-SIS Volet de contenu CDA)</assert>
            
            <assert test='cda:statusCode[@code = "completed"]'>
                [ER_comments_int] Erreur de Conformité PCC: La valeur de l'élément "code" de "statusCode" est toujours fixée à "completed". </assert>
            
            <assert test='not(cda:author) or (
                cda:author/cda:time and
                cda:author/cda:assignedAuthor/cda:id and
                cda:author/cda:assignedAuthor/cda:addr and
                cda:author/cda:assignedAuthor/cda:telecom and
                cda:author/cda:assignedAuthor/cda:assignedPerson/cda:name and
                cda:author/cda:assignedAuthor/cda:representedOrganization/cda:name)'>
                [ER_comments_int] Erreur de Conformité PCC: Un élément "Comment" peut avoir un auteur.
                L'horodatage de la création de l'élément "Comment" est réalisé à partir de l'élément "time" lorsque l'élément "author" est présent.
                L'identifiant de l'auteur (id), son adresse (addr) et son numéro de téléphone (telecom) sont dans ce cas obligatoires. 
                Le nom de l'auteur et/ou celui de l'organisation qu'il représente doit être présent.</assert>
            

                <assert test='cda:text'>
                [ER_comments_int] Erreur de Conformité PCC (Alerte): L'élément "observation" d'une entrée "Comments" contiendra un composant "text"
                Celui-ci contiendra un élément "reference" qui pointera sur la partie narrative où est notifiée le commentaire, plutôt 
                que de dupliquer ce texte.</assert>
        </rule>
</pattern>