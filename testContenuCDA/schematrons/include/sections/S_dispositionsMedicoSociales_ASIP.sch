<?xml version="1.0" encoding="UTF-8"?>


<!--                  Section score de Rankin ASIP Santé
    
   Teste la conformité de la section dispositions médico-sociales (1.2.250.1.213.1.1.2.44) créée par l'ASIP Santé
    
    Au 17/08/2017, cette section est utilisée par le volet PPS
    
    Historique :
    17/08/2017 : LBE : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_dispositionsMedicoSociales_ASIP">
    <title>ASIP Santé  Section score Glasgow </title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.44"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId = 1">
            [S_dispositionsMedicoSociales_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un templateId (cardinalité [1..1])
        </assert>
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_dispositionsMedicoSociales_ASIP.sch]  Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </assert>
        <assert test="count(cda:id)=1">
            [S_dispositionsMedicoSociales_ASIP.sch]  Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </assert>
        <assert test="cda:text">
            [S_dispositionsMedicoSociales_ASIP.sch]  Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un élément text
        </assert>        
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "34841-7"]'>
            [S_dispositionsMedicoSociales_ASIP.sch]  Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section Abdomen doit être 35088-4 </assert>
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_dispositionsMedicoSociales_ASIP.sch]  Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        <!-- Vérification des entrées optionnelles -->
        <assert test="not(cda:entry) or cda:entry/cda:observation/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'">
            [S_scoreGlasgow_ASIP.sch]  Erreur de Conformité CI-SIS (Section ASIP Santé) : Les entrées optionnelles autorisées sont : 
            simple observation (1.3.6.1.4.1.19376.1.5.3.1.4.13)     
        </assert>

    </rule>

</pattern>
