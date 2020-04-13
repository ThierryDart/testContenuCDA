<?xml version="1.0" encoding="UTF-8"?>


<!-- Section conclusion CRO  ASIP Santé
    
    Teste la conformité de la section conclusion  du CRO  (1.2.250.1.213.1.1.2.26) créée par l'ASIP Santé
        
    Historique :
    17/08/2017 : LBE : Création (section utilisée par le volet FRCP)
    06/06/2019 : Mofication du code LOINC de la section
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_conclusionCRO_ASIP">
    <title>ASIP Santé Section conclusion CRO </title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.26"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId = 1">
            [S_conclusionCRO_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un templateId (cardinalité [1..1])
        </assert>
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_conclusionCRO_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </assert>
        <assert test="count(cda:id)=1">
            [S_conclusionCRO_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </assert>
        <assert test="cda:text">
            [S_conclusionCRO_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un élément text
        </assert> 
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "10218-6"]'>
            [S_conclusionCRO_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section Conclusion du CRO doit être 10218-6 </assert>
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_laborAndDelivery_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        

    </rule>

</pattern>
