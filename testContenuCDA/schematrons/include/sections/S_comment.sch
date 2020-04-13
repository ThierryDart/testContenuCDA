<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_Comment.sch ]O@%#o>>=-
    
    - Teste la conformité de la section "Comment" (1.2.250.1.213.1.1.2.47)
    aux spécifications du CI-SIS
    
    Historique :
    11/10/2016 : NMA : Création  CommentSection20161011.sch
    04/07/17 : NMA : Ajout de la contrainte sur le nombre des templateIds et renommage du schématron
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_comment">
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.47"]'> 
        <!-- Verify that the template id is used on the appropriate type of object --> 
        <assert test='../cda:section'> 
            [S_Comment] Erreur de Conformité CI-SIS : Ce composant ne peut être utilisé qu'en tant que section. 
        </assert> 
        <assert test="count(cda:templateId)=1">
            [S_Comment] Erreur de Conformité CI-SIS : Un Seul templateId doit être présent pour cette section
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "48767-8"]'> 
            [S_Comment] Erreur de Conformité CI-SIS : Le code de la section doit être 48767-8 
        </assert> 
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_Comment] Erreur de Conformité CI-SIS : Le code de la section doit être tiré de la terminologie LOINC (2.16.840.1.113883.6.1). 
        </assert> 
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.13"]'> 
            <!-- Verify that all required data elements are present -->
            [S_Comment] Erreur de Conformité CI-SIS : La section doit contenir des entrées 
            du type Simple Observation Entry  (1.3.6.1.4.1.19376.1.5.3.1.4.13).
            
        </assert> 
    </rule> 
</pattern>

