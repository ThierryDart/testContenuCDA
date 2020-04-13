<?xml version="1.0" encoding="UTF-8"?>

<!--  IHE PCC v3.0  Section : 1.2.250.1.213.1.1.2.68 -->

<!--  anamneseEtFacteursDeRisque_FR.sch
    
    Teste la conformité de la section "Anamnèse et facteurs de risques" (1.2.250.1.213.1.1.2.68)
    Cette section est utilisée par le volet TLM-DA

    Historique :
    29/11/2019 : Création
    19/12/2019 : Corrections
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_anamneseEtFacteursDeRisques_FR">
    <title>Section FR Anamnèse et facteurs de risques</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.68"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId=1">
            [S_anamneseEtFacteursDeRisques_FR.sch] Erreur de conformité CI-SIS (Section FR) : La section doit contenir un templateId (cardinalité [1..1])
        </assert>
        <!-- Vérifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_anamneseEtFacteursDeRisques_FR.sch] Erreur de conformité CI-SIS (Section FR) : Cet élément ne peut être utilisé que comme section.
        </assert>
        <assert test="count(cda:id)=1">
            [S_anamneseEtFacteursDeRisques_FR.sch] Erreur de onformité CI-SIS (Section FR) : La section doit contenir un id (cardinalité [1..1])
        </assert>
                
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "46612-8"]'> 
            [S_anamneseEtFacteursDeRisques_FR.sch] Erreur de conformité CI-SIS (Section FR) : Le code de la section 'ANAMNESE ET FACTEURS DE RISQUES' doit être '46612-8' 
        </assert> 
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_anamneseEtFacteursDeRisques_FR.sch] Erreur de conformité CI-SIS (Section FR) :  L'attribut 'codeSystem' du code de la section doit être '2.16.840.1.113883.6.1' (LOINC). 
        </assert>
        <!-- Vérification de la sous-section obligatoire Anamnèse -->
        <assert test='cda:component/cda:section/cda:templateId/@root="1.2.250.1.213.1.1.2.69"'> 
            [S_anamneseEtFacteursDeRisques_FR] Erreur de conformité CI-SIS (Section FR) : Cette section Anamnèse et facteurs de risques doit contenir la section FR Anamnèse (1.2.250.1.213.1.1.2.69).
        </assert>
        <!-- Vérification de la présence des sous-sections optionnelles -->
        <!-- [APE] Ce test ne fonctionne pas -->
        <assert test="not(cda:component/cda:section) or cda:component/cda:section/cda:templateId[
            @root = '1.3.6.1.4.1.19376.1.5.3.1.3.16' or
            @root = '1.3.6.1.4.1.19376.1.5.3.1.1.5.3.1']">
            [S_anamneseEtFacteursDeRisques_FR.sch] Erreur de conformité CI-SIS (Section FR) : Les sous-sections optionnelles possibles sont : 
            Habitus, Mode de vie (Social History - 1.3.6.1.4.1.19376.1.5.3.1.3.16) et Facteurs de risques professionnels (Hazardous working conditions - 1.3.6.1.4.1.19376.1.5.3.1.1.5.3.1)
        </assert>
                
    </rule>
    
</pattern>