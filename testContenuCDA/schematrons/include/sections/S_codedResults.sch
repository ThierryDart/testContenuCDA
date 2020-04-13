<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_codedResults.sch ]O@%#o>>=-
    
    Teste la conformité de la section " Coded Results" (1.3.6.1.4.1.19376.1.5.3.1.3.28)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    25/07/11 : CRI : Création
    04/07/17 : NMA : Ajout des contraintes sur le nombre des templateIds, sur les entrées et renommage du schématron
    08/11/17 : NMA : Ajout du test sur le templateId parent
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_codedResults">

    <title>IHE PCC Coded Results Section</title>
    <rule context="*[cda:templateId/@root=&quot;1.3.6.1.4.1.19376.1.5.3.1.3.28&quot;]">
        <!-- Verifier que le templateId est utilisé correctement --> 
        <assert test="../cda:section"> 
            [S_codedResults] Erreur de Conformité PCC :  'Coded Results' ne peut être utilisé que comme section.</assert>
        
        <assert test="cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.3.27']"> 
            [S_codedResults] Erreur de conformité PCC : Le templateId parent (1.3.6.1.4.1.19376.1.5.3.1.3.27) doit être présent pour cette section</assert>
        
        <assert test="count(cda:templateId)=2">
            [S_codedResults] Erreur de Conformité PCC : Seuls deux templateIds doivent être présents pour cette section
        </assert>
        
        <!-- Vérifier le code de la section -->
        <assert test="cda:code[@code = '30954-2']"> 
            [S_codedResults] Erreur de Conformité PCC : Le code de la section 'Coded Results' doit être '30954-2'</assert>
        
        <assert test="cda:code[@codeSystem = &quot;2.16.840.1.113883.6.1&quot;]"> 
            [S_codedResults] Erreur de Conformité PCC : L'élément 'codeSystem' de la section 
            'Coded Results' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1).</assert>
        
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.19"]'>
            [S_CodedResults] Erreur de Conformité PCC : La section Coded Results doit contenir au moins une entrées de type Procedure Entry (1.3.6.1.4.1.19376.1.5.3.1.4.19).
        </assert>
        
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.13"]'>
            [S_CodedResults] Erreur de Conformité PCC : La section Coded Results doit contenir au moins une entrées de type Simple Obesrvation (1.3.6.1.4.1.19376.1.5.3.1.4.13).
        </assert>
    </rule>
</pattern>
