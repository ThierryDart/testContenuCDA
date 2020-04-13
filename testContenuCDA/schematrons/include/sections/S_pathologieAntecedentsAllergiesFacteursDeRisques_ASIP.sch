<?xml version="1.0" encoding="UTF-8"?>


<!--                  Section pathologie, antécédents, allergies et facteurs de risques ASIP Santé
    
   Teste la conformité de la section Historique des examens biologiues (1.2.250.1.213.1.1.2.29) créée par l'ASIP Santé
    
    Au 17/08/2017, cette section est utilisée par le volet VSM
    
    Historique :
    17/08/2017 : LBE : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_pathologieAntecedentsAllergiesFacteursDeRiques_ASIP">
    <title>ASIP Santé Section pathologie, antécédents, allergies et facteurs de risques  </title>

    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.29"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId = 1">
            [S_pathologieAntecedentsAllergiesFacteursDeRiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un templateId (cardinalité [1..1])
        </assert>
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_pathologieAntecedentsAllergiesFacteursDeRiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </assert>
        <assert test="count(cda:id)=1">
            [S_pathologieAntecedentsAllergiesFacteursDeRiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </assert>
        <assert test="cda:text">
            [S_pathologieAntecedentsAllergiesFacteursDeRiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un élément text
        </assert> 
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "46612-8"]'>
            [S_pathologieAntecedentsAllergiesFacteursDeRiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section 'Pathologie, antécédents, allergies et facteurs de risques' doit être '46612-8' </assert>
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_pathologieAntecedentsAllergiesFacteursDeRiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        <!-- Vérification des sous-sections obligatoires -->
        <assert test="cda:component/cda:section/cda:templateId/@root='1.2.250.1.213.1.1.2.30' and cda:component/cda:section/cda:templateId/@root='1.2.250.1.213.1.1.2.31'">
            [S_pathologieAntecedentsAllergiesFacteursDeRiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section 'Pathologie, antécédents, allergies et facteurs de risques' contient obligatoirement les sous sections 'Pathologie en cours, antécédents et allergies'
            (1.2.250.1.213.1.1.2.30) et 'Facteurs de risque' (1.2.250.1.213.1.1.2.31)           
        </assert>

    </rule>

</pattern>
