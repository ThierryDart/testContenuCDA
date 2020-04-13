<?xml version="1.0" encoding="UTF-8"?>


<!--                  Section conclusion du CR-ACP ASIP Santé
    
   Teste la conformité de la section conclusion du CR-ACP ASIP Santé (1.2.250.1.213.1.1.2.34) créée par l'ASIP Santé
    
    Au 17/08/2017, cette section est utilisée par les volets FRCP, OBS_SNM
    
    Historique :
    17/08/2017 : LBE : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_conclusionCR-ACP_ASIP">
    <title>ASIP Santé Section CR-ACP </title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.34"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId = 1">
            [S_conclusionCR-ACP_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un templateId (cardinalité [1..1])
        </assert>
        <assert test="count(cda:id)=1">
            [S_conclusionCR-ACP_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </assert>
        <assert test="cda:text">
            [S_conclusionCR-ACP_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un élément text
        </assert>
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_conclusionCR-ACP_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </assert>
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "30954-2"]'>
            [S_conclusionCR-ACP_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section Abdomen doit être 30954-2 </assert>
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_statutCasPresenteQuorum_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        <!-- Vérification des sous-sections optionnelles -->
        <assert test="not(cda:component/cda:section) or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.13.2.11' or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.8.1.2.5'">
            [S_statutCasPresenteQuorum_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Les sous sections optionelles autorisées sont : 
            Procédures et interventions (1.3.6.1.4.1.19376.1.5.3.1.1.13.2.11)
            conclusion CR-ACP (1.3.6.1.4.1.19376.1.8.1.2.5)            
        </assert>

    </rule>

</pattern>
