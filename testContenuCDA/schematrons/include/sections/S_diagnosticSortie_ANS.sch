<?xml version="1.0" encoding="UTF-8"?>


<!--                  Section diagnostic Sortie ANS
    
   Teste la conformité de la section diagnostic de sortie (1.2.250.1.213.1.1.2.5) créée par l'ANS
        
    Historique :
    10/01/2020 : NMA : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_diagnosticSortie_ANS">
    <title>ANS Section diagnostic de sortie</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.5"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId &gt;0">
            [S_diagnosticSortie_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : La section doit contenir un templateId au moins (cardinalité [1..*])
        </assert>
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_diagnosticSortie_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : Cet élément ne peut être utilisé que comme section.
        </assert>
        <assert test="count(cda:id)&lt;2">
            [S_diagnosticSortie_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : La section doit contenir au maximum un seul id (cardinalité [0..1])
        </assert>
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "11535-2"]'>
            [S_diagnosticSortie_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : Le code de la section 'Dossier' doit être '11535-2'
        </assert>
        
    </rule>

</pattern>
