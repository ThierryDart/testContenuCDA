<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_procedureEntry_fr.sch ]O@%#o>>=-
    
    Teste l'entrée Procedure Entry (1.3.6.1.4.1.19376.1.5.3.1.4.19)
    
    27/06/17 : NMA : Création
    26/07/17 : NMA : Mise en commentaire du test sur la nomenclature CCAM, celle ci n'est utilisée que s'il s'agit d'actes médicaux
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_procedureEntry_fr">

        <title>CI-SIS Procedure Entry</title>
        <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.19"]'>
            <let name="count_templateId" value="count(cda:templateId)"/>
            
<!--            <assert test='cda:code[@codeSystem="1.2.250.1.213.2.5"]'>
                [E_procedureEntry_fr] Erreur de conformité CI-SIS : Un élément "Procedure Entry" est codé à partir de la nomenclature CCAM.</assert>
-->            
            <assert test='count(cda:approachSiteCode)&lt;2'>
                [E_procedureEntry_fr] Erreur de conformité CI-SIS : Un seul élément approachSiteCode au maximum peut être présent
            </assert>

            <assert test='count(cda:targetSiteCode)&lt;2'>
                [E_procedureEntry_fr] Erreur de conformité CI-SIS : Un seul élément targetSiteCode au maximum peut être présent
            </assert>
        </rule>
</pattern>
        
