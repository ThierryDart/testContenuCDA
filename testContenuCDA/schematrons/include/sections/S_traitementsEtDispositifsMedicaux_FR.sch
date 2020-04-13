<?xml version="1.0" encoding="UTF-8"?>

<!--  IHE PCC v3.0  Section: 1.2.250.1.213.1.1.2.70 -->

<!-- TraitementsEtDispositifsMedicaux_FR.sch
    
    Teste la conformité de la section "Traitements et dispositifs médicaux" (1.2.250.1.213.1.1.2.70)
    Cette section est utilisée par le document TLM-DA
    
    Historique :
    29/11/2019 : Création
    19/12/2019 : Corrections
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_traitementsEtDispositifsMedicaux_FR">
    <title>Section FR Traitements et dispositifs médicaux</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.70"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId=1">
            [S_traitementsEtDispositifsMedicaux_FR.sch] Erreur de conformité CI-SIS (Section FR) : La section doit contenir un templateId (cardinalité [1..1])
        </assert>
        <!-- Vérifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_traitementsEtDispositifsMedicaux_FR.sch] Erreur de conformité CI-SIS (Section FR) : Cet élément ne peut être utilisé que comme section.
        </assert>
        <assert test="count(cda:id)=1">
            [S_traitementsEtDispositifsMedicaux_FR.sch] Erreur de conformité CI-SIS (Section FR) : La section doit contenir un id (cardinalité [1..1])
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "XXXXX-X"]'> 
            [S_traitementsEtDispositifsMedicaux_FR.sch] Erreur de conformité CI-SIS : Le code de la section 'Traitements et Dispositifs Médicaux' doit être 'XXXXX-X' 
        </assert> 
        <assert test='cda:code[@codeSystem = "1.2.250.1.213.1.1.4.322"]'> 
            [S_traitementsEtDispositifsMedicaux_FR.sch] Erreur de conformité CI-SIS :  L'attribut 'codeSystem' de la section a pour valeur '1.2.250.1.213.1.1.4.322' (TA_ASIP). 
        </assert>
        <!-- Vérification de la présence de l'élément text -->
        <assert test="(not(cda:component/cda:section) and cda:text) or (count(cda:component/cda:section)&lt;=2 and not(cda:text) and (cda:component/cda:section))
            and (cda:component/cda:section/cda:templateId[
            @root = '1.3.6.1.4.1.19376.1.5.3.1.3.19' or
            @root = '1.2.250.1.213.1.1.2.1'])">
            [S_traitementsEtDispositifsMedicaux_FR.sch] Erreur de conformité CI-SIS (Section FR) : 
            Si aucune des 2 sous-sections optionnelles n’est présente : l’élément text est obligatoire.
            Si les 2 sous-sections sont présentes : l’élément text est interdit.   
        </assert>
        <!-- Vérification de la présence des sous-section optionnelles -->
        <assert test="not(cda:component/cda:section) or cda:component/cda:section/cda:templateId[
            @root = '1.3.6.1.4.1.19376.1.5.3.1.3.19' or
            @root = '1.2.250.1.213.1.1.2.1']">
            [S_traitementsEtDispositifsMedicaux_FR.sch]  Erreur de conformité CI-SIS (Section FR) : Les sous-sections optionnelles possibles sont : 
            Traitements (1.3.6.1.4.1.19376.1.5.3.1.3.19) et Dispositifs médicaux (codé) (1.2.250.1.213.1.1.2.1)
        </assert>
    </rule>
    
</pattern>