<?xml version="1.0" encoding="UTF-8"?>


<!--                  Section Documents ajoutés ANS
    
   Teste la conformité de la section Documents ajoutés (1.2.250.1.213.1.1.2.37) créée par l'ANS
        
    Historique :
    14/01/2020 : NMA : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_documentsAjoutes_ANS">
    <title>ANS Section Documents ajoutés</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.37"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId &gt; 0">
            [S_documentsAjoutes_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : La section doit contenir un templateId (cardinalité [1..*])
        </assert>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_documentsAjoutes_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:id)&lt;2">
            [S_documentsAjoutes_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : La section doit contenir au maximum un seul id (cardinalité [0..1])
        </assert>
        
        <assert test="cda:text">
            [S_documentsAjoutes_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : La section doit contenir un élément text
        </assert>
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "55107-7"]'>
            [S_documentsAjoutes_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : Le code de cette section doit être '55107-7'
        </assert>

        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_documentsAjoutes_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : Le code de la section doit être un code LOINC  
            system (2.16.840.1.113883.6.1). 
        </assert> 
        
        <assert test='//cda:templateId[@root = "1.2.250.1.213.1.1.3.18"]'> 
            [S_documentsAjoutes_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : L'entrée Document attaché (1.2.250.1.213.1.1.3.18) est obligatoirement présente dans cette section
        </assert> 
        
    </rule>

</pattern>
