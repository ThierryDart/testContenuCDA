<?xml version="1.0" encoding="UTF-8"?>


<!--                  Section resultat Examens Biologiques ANS
    
   Teste la conformité de la section Résultat des examens biologiques ANS (1.2.250.1.213.1.1.2.10) créée par l'ANS
    
    
    Historique :
    13/01/2020 : NMA : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_resultatExamBio_ANS">
    <title>Section Résultats d'examens Biologiques ANS </title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.10"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId &gt; 0">
            [S_resultatExamBio_ANS.sch] Erreur de Conformité CI-SIS : La section doit contenir un templateId (cardinalité [1..*])
        </assert>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_resultatExamBio_ANS.sch]  Erreur de Conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:id)=1">
            [S_resultatExamBio_ANS.sch]  Erreur de Conformité CI-SIS : La section doit contenir un id (cardinalité [1..1])
        </assert>
        
        <assert test="cda:text">
            [S_resultatExamBio_ANS.sch]  Erreur de Conformité CI-SIS : La section doit contenir un élément text
        </assert>        

        
    </rule>

</pattern>
