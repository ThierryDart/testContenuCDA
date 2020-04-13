<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ ER_severity_fr.sch ]O@%#o>>=-
    
    Teste la conformité d'une entrée utilisée dans le volet du CI-SIS aux spécifications de l'entryRelationship
    PCC severity (1.3.6.1.4.1.19376.1.5.3.1.4.1)  
    
    
    Historique :
    27/06/17 : NMA : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="ER_severity_fr">

    <title>CI-SIS Severity</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.1"]'>
          <assert test='cda:code[@code="SEV"]'>
            [ER_severity_fr] Erreur de Conformité CI-SIS: L'élément 'code' de l'entrée 'severity' indique la 
            sévérité de l'allergie provoquée.
            L'attribut code de l'élément 'code' est fixé à 'SEV'.</assert>
        
    </rule>
</pattern>
