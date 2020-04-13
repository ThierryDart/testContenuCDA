<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_codedResultsSubsections_CSE.sch ]O@%#o>>=-
    
    Teste la conformité de la section " Coded Results" (1.3.6.1.4.1.19376.1.5.3.1.3.28)
    aux spécifications du volet CS8
    
    Historique :
    25/07/11 : CRI : Création
    
-->
    <!--  IHE PCC Coded Results Section: 1.3.6.1.4.1.19376.1.5.3.1.3.28 -->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_codedResultsSubsections_CSE">
    <!-- errors -->

    <title>IHE PCC Coded Results Section</title>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.28']">

<!-- Verifier que la sous-section procedure est presente --> 
        <assert test=".//cda:templateId[@root = '1.3.6.1.4.1.19376.1.5.3.1.4.19']">
            [S_codedResultsSubsections_CSE.sch] Erreur de Conformité au volet CSE: La section Coded Results doit contenir une entrée "Procedure". </assert>
    </rule>
</pattern>
