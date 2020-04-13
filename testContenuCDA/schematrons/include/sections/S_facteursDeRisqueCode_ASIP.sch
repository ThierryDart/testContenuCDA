<?xml version="1.0" encoding="UTF-8"?>


<!--                  Section Facteurs de risque  ASIP Santé
    
   Teste la conformité de la section facteurs de rique  (1.2.250.1.213.1.1.2.31) créée par l'ASIP Santé
    
    Au 17/08/2017, cette section est utilisée par le volet VSM
    
    Historique :
    17/08/2017 : LBE : Création
    14/01/2020 : NMA : Renommage de facteurs de risque en facteurs de risque codé
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_facteursDeRisqueCode_ASIP">
    <title>ASIP Santé Section Facteurs de risque codé</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.31"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId &gt; 0">
            [S_facteursDeRisqueCode_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir au moins un templateId
        </assert>
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_facteursDeRisqueCode_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </assert>
        <assert test="count(cda:id)=1">
            [S_facteursDeRisqueCode_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </assert>

        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "57207-3"]'>
            [S_facteursDeRisqueCode_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section 'Facteurs de risque' doit être '57207-3' </assert>
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_facteursDeRisqueCode_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        <!-- Vérification des sous-sections optionnelles -->
        <assert test="not(cda:component/cda:section) or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.16.1' or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.5.3.1' or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.15'">
            [S_facteursDeRisqueCode_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Les sous-sections optionnelles possibles sont :  
            Habitus, mode de vie (Coded Social History - 1.3.6.1.4.1.19376.1.5.3.1.3.16.1)
            Facteurs de risque professionnels (Hazardous Working Conditions - 1.3.6.1.4.1.19376.1.5.3.1.1.5.3.1)
            Antécédents familiaux (Coded Family Medical History - 1.3.6.1.4.1.19376.1.5.3.1.3.15)
        </assert>
        <assert test="(not(cda:component/cda:section) and cda:text) or (count(cda:component/cda:section)=3 and not(cda:text)) or (count(cda:component/cda:section)&lt;3 and cda:component/cda:section)">
            [S_facteursDeRisqueCode_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : 
            Si aucune des 3 sous-sections optionnelles n’est présente : l’élément text est requis . Dans ce cas le contenu de la section est intégralement non structuré.
            Si les 3 sous-sections optionnelles sont présentes : l’élément text est interdit. En effet, chacune est porteuse de son propre texte en plus de ses données structurées. Ce cas correspond à la structuration maximale de cette section.
            Dans les autres cas, l’élément text peut être présent et il porte le texte correspondant à une ou plusieurs sous-sections optionnelles absentes.
        </assert>
        

    </rule>

</pattern>
