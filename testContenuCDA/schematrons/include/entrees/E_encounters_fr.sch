<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_encounters_fr.sch ]O@%#o>>=-
    
    Teste les entrées de l'entrée Modèle de contenu CDA Encounters (1.3.6.1.4.1.19376.1.5.3.1.4.14)
    
   
-->



<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_encounters_fr">


    <title>IHE PCC v3.0 Encounters - errors validation phase</title>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.14']">
        
       <let name="count_id" value="count(cda:id)"/>
        
        <assert test="$count_id=1">
            [E_encounters_fr.sch] Erreur de conformité CI-SIS : L'élément encounters doit contenir un élément id (cardinalité [1..1])
        </assert>
    
    
    </rule>
    
</pattern>
