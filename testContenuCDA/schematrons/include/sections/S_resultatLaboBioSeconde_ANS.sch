<?xml version="1.0" encoding="UTF-8"?>


<!--                  Section Résultats de laboratoire de biologie de seconde intention ANS
    
   Teste la conformité de la section Résultats de laboratoire de biologie de seconde intention (1.2.250.1.213.1.1.2.60) créée par l'ANS
    
    
    Historique :
    13/01/2020 : NMA : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_resultatLaboBioSeconde_ANS">
    <title>Section Résultats de laboratoire de biologie de seconde intention ANS </title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.60"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId &gt; 0">
            [S_resultatLaboBioSeconde_ANS.sch] Erreur de Conformité CI-SIS : La section doit contenir un templateId (cardinalité [1..*])
        </assert>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_resultatLaboBioSeconde_ANS.sch]  Erreur de Conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:id)&gt;0">
            [S_resultatLaboBioSeconde_ANS.sch]  Erreur de Conformité CI-SIS : La section doit contenir un id au moins(cardinalité [1..1])
        </assert>
        
        <assert test="cda:text">
            [S_resultatLaboBioSeconde_ANS.sch]  Erreur de Conformité CI-SIS : La section doit contenir un élément text
        </assert>        

        
    </rule>

</pattern>
