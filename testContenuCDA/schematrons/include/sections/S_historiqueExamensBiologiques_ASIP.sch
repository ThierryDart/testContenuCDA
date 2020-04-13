<?xml version="1.0" encoding="UTF-8"?>


<!--                  Section Historique des examens biologiues ASIP Santé
    
   Teste la conformité de la section Historique des examens biologiues (1.2.250.1.213.1.1.2.28) créée par l'ASIP Santé
    
    Au 17/08/2017, cette section est utilisée par le volet CVAC
    
    Historique :
    17/08/2017 : LBE : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_historiqueExamensBiologiques_ASIP">
    <title>ASIP Santé Section Historique des examens biologiues </title>

    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.28"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId = 1">
            [S_historiqueExamensBiologiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un templateId (cardinalité [1..1])
        </assert>
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_historiqueExamensBiologiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </assert>
        <assert test="count(cda:id)=1">
            [S_historiqueExamensBiologiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </assert>
        <assert test="cda:text">
            [S_historiqueExamensBiologiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un élément text
        </assert> 
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "26436-6"]'>
            [S_historiqueExamensBiologiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section Abdomen doit être 57074-7 </assert>
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_historiqueExamensBiologiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        <!-- Vérification des sous-sections optionnelles -->
        <assert test="not(cda:component/cda:section) or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.1.13.7'">
            [S_historiqueExamensBiologiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Labor and Delivery peut contenir une sous section PCC coded Event outcomes (templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.1.13.7')
        </assert>

    </rule>

</pattern>
