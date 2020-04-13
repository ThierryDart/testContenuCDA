<?xml version="1.0" encoding="UTF-8"?>

<!--  CI-SIS Bilan Cancérologie Section: 1.2.250.1.213.1.1.2.59 -->

<!--                 Section Bilan Cancérologie ANS
    
    Teste la conformité de la section "Bilan Cancérologie" (1.2.250.1.213.1.1.2.59)
    aux spécifications du CI-SIS
   
   
    
    Historique :
    14/01/2020 : NMA : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_BilanCancérologie_ANS">
    <title>CI-SIS - Section Bilan Cancérologie</title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.59"]'> 
        
        <!-- Verifier que le templateId est utilisé à bon escient --> 
        <assert test='../cda:section'> 
            [S_BilanCancérologie_ANS.sch] erreur de conformité CI-SIS (ANS) :  'Bilan Cancérologie' ne peut être utilisé que comme section. 
        </assert> 
        
        <assert test="count(cda:id)=1">
            [S_BilanCancérologie_ANS.sch] erreur de conformité CI-SIS (ANS) : L'élément doit contenir un id unique (cardinalité [1..1])
        </assert>
        
        <assert test="cda:text">
            [S_BilanCancérologie_ANS.sch] erreur de conformité CI-SIS (ANS) : Un élément texte doit être présent dans la section éléments cliniques rapportés
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "72135-7"]'> 
            [S_BilanCancérologie_ANS.sch] erreur de conformité CI-SIS (ANS) : Le code de la section 'Bilan Cancérologie' doit être '72135-7' 
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_BilanCancérologie_ANS.sch] erreur de conformité CI-SIS (ANS) : L'attribut 'codeSystem' de la section a pour valeur '2.16.840.1.113883.6.1' (LOINC). 
        </assert>
        
        <assert test="//cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.36'">
            [S_BilanCancérologie_ANS.sch] erreur de conformité CI-SIS (ANS) : Une sous-section de type Plan de soin codé est obligatoire (1.3.6.1.4.1.19376.1.5.3.1.3.36)
        </assert>
        
        <assert test="//cda:templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.1.13.7'">
            [S_BilanCancérologie_ANS.sch] erreur de conformité CI-SIS (ANS) : Une sous-section de type Résultats d’évènements codé est obligatoire (1.3.6.1.4.1.19376.1.7.3.1.1.13.7)
        </assert>
        
        <assert test="//cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.28'">
            [S_BilanCancérologie_ANS.sch] erreur de conformité CI-SIS (ANS) : Une sous-section de type Résultats d’examens codé est obligatoire (1.3.6.1.4.1.19376.1.5.3.1.3.28)
        </assert>
        
        
    </rule>
    
</pattern>