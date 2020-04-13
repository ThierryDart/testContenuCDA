<?xml version="1.0" encoding="UTF-8"?>


<!-- Section score de Rankin ASIP Santé
    
     Teste la conformité de la section score de Rankin (1.2.250.1.213.1.1.2.39) créée par l'ASIP Santé
     Au 17/08/2017, cette section est utilisée par le volet AVC_AUNV
    
    Historique :
    17/08/2017 : LBE : Création
    20/10/2017 : NMA : Suppression du test sur la nomenclature utilisée pour coder la section
    01/04/2019 : APE : Correction du contrôle du code de la section
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_scoreRankin_ASIP">
    <title>ASIP Santé  Section information assuré </title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.39"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId = 1">
            [S_scoreRankin_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : la section doit contenir un templateId (cardinalité [1..1])
        </assert>
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_scoreRankin_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : cet élément ne peut être utilisé que comme section.
        </assert>
        <assert test="count(cda:id)=1">
            [S_scoreRankin_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : la section doit contenir un id (cardinalité [1..1])
        </assert>
        <assert test="cda:text">
            [S_scoreRankin_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : la section doit contenir un élément text
        </assert>
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "MED-381"]'>
            [S_scoreRankin_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section Abdomen doit être MED-381 </assert>
       <!-- <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_sectionInformationAssure_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>-->
        <!-- Vérification des entrées optionnelles -->
        <assert test="not(cda:entry) or cda:entry/cda:observation/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'">
            [S_scoreRankin_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Les entrées optionnelles autorisées sont : 
            simple observation (1.3.6.1.4.1.19376.1.5.3.1.4.13)     
        </assert>

    </rule>

</pattern>
