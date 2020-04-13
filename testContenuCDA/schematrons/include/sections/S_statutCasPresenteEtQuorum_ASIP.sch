<?xml version="1.0" encoding="UTF-8"?>


<!--                  Section Statut du Cas présenté et Quorum ASIP Santé
    
   Teste la conformité de la section Statut du Cas présenté et Quorum ASIP Santé (1.2.250.1.213.1.1.2.33) créée par l'ASIP Santé
    
    Au 17/08/2017, cette section est utilisée par le volet FRCP
    
    Historique :
    17/08/2017 : LBE : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_statutCasPresenteQuorum_ASIP">
    <title>ASIP Santé Section Statut du cas présenté et Quorum </title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.33"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId = 1">
            [S_statutCasPresenteQuorum_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un templateId (cardinalité [1..1])
        </assert>
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_statutCasPresenteQuorum_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </assert>
        <assert test="count(cda:id)=1">
            [S_statutCasPresenteQuorum_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </assert>
        <assert test="cda:text">
            [S_statutCasPresenteQuorum_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un élément text
        </assert>        
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "21874-3"]'>
            [S_statutCasPresenteQuorum_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section Abdomen doit être 21874-3 </assert>
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_statutCasPresenteQuorum_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        <!-- Vérification des sous-sections optionnelles -->
        <assert test="not(cda:entry) or cda:entry/cda:organizer/cda:templateId/@root='1.2.250.1.213.1.1.3.7'">
            [S_statutCasPresenteQuorum_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'entrée optionnelle autorisée est organizer RCP templateId/@root='1.2.250.1.213.1.1.3.7'        
        </assert>

    </rule>

</pattern>
