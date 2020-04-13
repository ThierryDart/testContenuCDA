<?xml version="1.0" encoding="UTF-8"?>

<!--  CI-SIS Interpretation Section: 1.2.250.1.213.1.1.2.58 -->

<!--                 Section Interpretation ANS
    
    Teste la conformité de la section "Interpretation" (1.2.250.1.213.1.1.2.58)
    aux spécifications du CI-SIS
   
   
    
    Historique :
    14/01/2020 : NMA : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_Interpretation_ANS">
    <title>CI-SIS - Section Interpretation</title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.58"]'> 
        
        <!-- Verifier que le templateId est utilisé à bon escient --> 
        <assert test='../cda:section'> 
            [S_Interpretation_ANS.sch] erreur de conformité CI-SIS (ANS) :  'Interpretation' ne peut être utilisé que comme section. 
        </assert> 
        
        <assert test="count(cda:id)=1">
            [S_Interpretation_ANS.sch] erreur de conformité CI-SIS (ANS) : L'élément doit contenir un id unique (cardinalité [1..1])
        </assert>
        
        <assert test="cda:text">
            [S_Interpretation_ANS.sch] erreur de conformité CI-SIS (ANS) : Un élément texte doit être présent dans la section éléments cliniques rapportés
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "22030-1"]'> 
            [S_Interpretation_ANS.sch] erreur de conformité CI-SIS (ANS) : Le code de la section 'Interpretation' doit être '22030-1' 
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_Interpretation_ANS.sch] erreur de conformité CI-SIS (ANS) : L'attribut 'codeSystem' de la section a pour valeur '2.16.840.1.113883.6.1' (LOINC). 
        </assert>
        
        <assert test="//cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.36'">
            [S_Interpretation_ANS.sch] erreur de conformité CI-SIS (ANS) : Une sous-section de type Plan de soin codé est obligatoire (1.3.6.1.4.1.19376.1.5.3.1.3.36)
        </assert>
        
        <assert test="//cda:templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.1.13.7'">
            [S_Interpretation_ANS.sch] erreur de conformité CI-SIS (ANS) : Une sous-section de type Résultats d’évènements codé est obligatoire (1.3.6.1.4.1.19376.1.7.3.1.1.13.7)
        </assert>
        
        <assert test="//cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.28'">
            [S_Interpretation_ANS.sch] erreur de conformité CI-SIS (ANS) : Une sous-section de type Résultats d’examens codé est obligatoire (1.3.6.1.4.1.19376.1.5.3.1.3.28)
        </assert>
        
        <assert test="//cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.6'">
            [S_Interpretation_ANS.sch] erreur de conformité CI-SIS (ANS) : Une sous-section de type Problèmes actifs codé est obligatoire (1.3.6.1.4.1.19376.1.5.3.1.3.6)
        </assert>
        
        <assert test="//cda:templateId/@root='1.2.250.1.213.1.1.2.37'">
            [S_Interpretation_ANS.sch] erreur de conformité CI-SIS (ANS) : Une sous-section de type Documents ajoutés est obligatoire (1.2.250.1.213.1.1.2.37)
        </assert>
        
        
    </rule>
    
</pattern>