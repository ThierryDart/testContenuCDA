<?xml version="1.0" encoding="UTF-8"?>


<!--                  Section Commentaire sur le document
    
   Teste la conformité de la section Commentaire sur le document (1.3.6.1.4.1.19376.1.4.1.2.16)
        
    Historique :
    14/01/2020 : NMA : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_documentSummary">
    <title>Section Commentaire sur le document</title>
    
    <rule context='*[cda:templateId/@root = "1.3.6.1.4.1.19376.1.4.1.2.16"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId &gt; 0">
            [S_documentSummary.sch] Erreur de Conformité PCC : La section doit contenir un templateId (cardinalité [1..*])
        </assert>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_documentSummary.sch] Erreur de Conformité PCC : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:id)&lt;2">
            [S_documentSummary.sch] Erreur de Conformité PCC : La section doit contenir au maximum un seul id (cardinalité [0..1])
        </assert>
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "55112-7"]'>
            [S_documentSummary.sch] Erreur de Conformité PCC : Le code de cette section doit être '55112-7'
        </assert>

        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_documentSummary.sch] Erreur de Conformité PCC : Le code de la section doit être un code LOINC  
            system (2.16.840.1.113883.6.1). 
        </assert> 
        
        
    </rule>

</pattern>
