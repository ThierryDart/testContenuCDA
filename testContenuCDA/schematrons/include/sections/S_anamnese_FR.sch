<?xml version="1.0" encoding="UTF-8"?>

<!--  IHE PCC v3.0  Section: 1.2.250.1.213.1.1.2.69 -->

<!--  anamnese_FR.sch
    
    Teste la conformité de la section "Anamnèse" (1.2.250.1.213.1.1.2.69)
    Cette section est utilisée par le document TLM-DA
    
    Historique :
    29/11/2019 : Création
    19/12/2019 : Corrections
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_anamnese_FR">
    <title>Section FR Anamnèse</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.69"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId=1">
            [S_anamnese_FR.sch] Erreur de conformité CI-SIS (Section FR) : La section doit contenir un templateId (cardinalité [1..1])
        </assert>
        <!-- Vérifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_anamnese_FR.sch] Erreur de conformité CI-SIS (Section FR) : Cet élément ne peut être utilisé que comme section.
        </assert>
        <assert test="count(cda:id)=1">
            [S_anamnese_FR.sch] Erreur de conformité CI-SIS (Section FR) : La section doit contenir un id (cardinalité [1..1])
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "34117-2"]'> 
            [S_anamnese_FR.sch] Erreur de conformité CI-SIS (Section FR) : Le code de la section 'ANAMNESE' doit être '34117-2' 
        </assert> 
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_anamnese_FR.sch] Erreur de conformité CI-SIS (Section FR) : L'attribut 'codeSystem' de la section a pour valeur '2.16.840.1.113883.6.1' (LOINC). 
        </assert>
        <!-- Vérification de la présence de l'élément text -->
        <assert test="(not(cda:component/cda:section) and cda:text) or (count(cda:component/cda:section)&lt;=5 and not(cda:text) and (cda:component/cda:section))
            and (cda:component/cda:section/cda:templateId[
            @root = '1.3.6.1.4.1.19376.1.5.3.1.3.6' or
            @root = '1.3.6.1.4.1.19376.1.5.3.1.3.8' or
            @root = '1.3.6.1.4.1.19376.1.5.3.1.3.12' or
            @root = '1.3.6.1.4.1.19376.1.5.3.1.3.13' or
            @root = '1.3.6.1.4.1.19376.1.5.3.1.3.15'])">
            [S_anamnese_FR.sch] Erreur de conformité CI-SIS (Section FR) : 
            Si aucune des 5 sous-sections optionnelles n’est présente : l’élément text est obligatoire.
            Si les 5 sous-sections sont présentes : l’élément text est interdit. En effet, chacune est porteuse de son propre texte en plus de ses données structurées.            
        </assert>
        
    </rule>
    
</pattern>