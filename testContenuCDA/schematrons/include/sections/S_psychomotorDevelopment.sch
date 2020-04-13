<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[S_psychomotorDevelopment.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Psychomotor Development" (1.3.6.1.4.1.19376.1.7.3.1.1.13.4)
    aux spécifications d'IHE PCC v3.0
    
    Note: La section est codée avec le code provisoire xx-MCH-PsychoMDev, provenant de la nomenclature
    TA_CS, provisoirement avant son intégration dans la nomenclature LOINC.
    Lorsque celle-ci sera effective, la modification des schematrons correspondants sera 
    effectuée.
    la nomenclature de
    
    Historique :
    24/06/11 : CRI : Création
    14/11/16 : NMA : Teste la présence de l'entrée Simple Observation
    03/07/2017 : LBE :  Ajout du comptre de templateId + conventions de nommage + modifciation du nom du schématron pour le rendre conforme à IHE PCC
    22/11/17 : NMA : Mise à jour des codes TA_CS ==> TA_ASIP
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_psychomotorDevelopment">
    <title>IHE PCC v3.0 Psychomotor Development</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.7.3.1.1.13.4"]'> 
        
        <let name="count_templateId" value="count(cda:templateId)"/>
        <assert test="$count_templateId =1">
            [S_psychomotorDevelpment.sch] Erreur de conformité PCC : 'Psychomotor Development' ne doit contenir qu'un seul templateId (cardinalité [1..1])
        </assert>
        
        <!-- Verifier que le templateId est utilisé à bon escient -->        
        <assert test='../cda:section'> 
            Erreur de Conformité au volet PCC: 'Psychomotor Development' ne peut être utilisé que comme section.
        </assert>

        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "MED-189"]'> 
            Erreur de Conformité au volet PCC: Le code de la section 'Psychomotor Development' doit être 'MED-189'
        </assert> 
        <assert test='cda:code[@codeSystem = "1.2.250.1.213.1.1.4.322"]'> 
            Erreur de Conformité au volet PCC: L'élément 'codeSystem' de la section 'Psychomotor Deveopment' doit être codé dans la nomenclature TA_ASIP 
            (1.2.250.1.213.1.1.4.322). 
        </assert> 
        
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.4.13"]'>
            Erreur de Conformité au volet PCC: La section 'Psychomotor Development' ne contient pas d'entrée 'Simple Observation'.        
        </assert> 


    </rule>
</pattern>
