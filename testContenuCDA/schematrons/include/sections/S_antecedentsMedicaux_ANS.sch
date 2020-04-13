<?xml version="1.0" encoding="UTF-8"?>

<!--  CI-SIS Antécédents médicaux Section: 1.2.250.1.213.1.1.2.46 -->

<!--                 Section Antécédents médicaux ANS
    
    Teste la conformité de la section "Antécédents médicaux" (1.2.250.1.213.1.1.2.2)
    aux spécifications du CI-SIS
   
   
    
    Historique :
    13/01/2020 : NMA : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_AnecedentsMedicaux_ANS">
    <title>CI-SIS - Section Antécédents médicaux</title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.2"]'> 
        <!-- Verifier que le templateId est utilisé à bon escient --> 
        <assert test='../cda:section'> 
            [S_AnecedentsMedicaux_ANS.sch] erreur de conformité CI-SIS (ANS) :  'Antécédents médicaux' ne peut être utilisé que comme section. 
        </assert> 
        <assert test="count(cda:id)">
            [S_AnecedentsMedicaux_ANS.sch] erreur de conformité CI-SIS (ANS) : L'élément doit contenir un id unique (cardinalité [1..1])
        </assert>
        <assert test="cda:text">
            [S_AnecedentsMedicaux_ANS.sch] erreur de conformité CI-SIS (ANS) : Un élément texte doit être présent dans la section éléments cliniques rapportés
        </assert>
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "11348-0"]'> 
            [S_AnecedentsMedicaux_ANS.sch] erreur de conformité CI-SIS (ANS) : Le code de la section 'Antécédents médicaux' doit être '11348-0' 
        </assert> 
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_AnecedentsMedicaux_ANS.sch] erreur de conformité CI-SIS (ANS) : L'attribut 'codeSystem' de la section a pour valeur '2.16.840.1.113883.6.1' (LOINC). 
        </assert>


    </rule>
    
</pattern>