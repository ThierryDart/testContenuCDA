<?xml version="1.0" encoding="UTF-8"?>


<!--                  Section information assuré ASIP Santé
    
   Teste la conformité de la section information assuré (1.2.250.1.213.1.1.2.38) créée par l'ASIP Santé
    
    Au 17/08/2017, cette section est utilisée par le volet CR-RTN
    
    Historique :
    17/08/2017 : LBE : Création
    20/10/17 : NMA : Suppression du test sur la nomenclature utilisée pour coder la section
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_informationAssure_ASIP">
    <title>ASIP Santé  Section information assuré </title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.38"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId = 1">
            [S_InformationAssure_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un templateId (cardinalité [1..1])
        </assert>
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_InformationAssure_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </assert>
        <assert test="count(cda:id)=1">
            [S_InformationAssure_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </assert>
        <assert test="cda:text">
            [S_InformationAssure_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un élément text
        </assert>        
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "35525-4"]'>
            [S_InformationAssure_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section Abdomen doit être 35525-4 </assert>
        <!--<assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_InformationAssure_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>-->
        <!-- Vérification des entrées optionnelles -->
        <assert test="not(cda:entry) or cda:entry/cda:organizer/cda:templateId/@root='1.2.250.1.213.1.1.3.18'">
            [S_InformationAssure_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Les entrées optionnelles autorisées sont : 
            Organizer document attaché (1.2.250.1.213.1.1.3.18)     
        </assert>

    </rule>

</pattern>
